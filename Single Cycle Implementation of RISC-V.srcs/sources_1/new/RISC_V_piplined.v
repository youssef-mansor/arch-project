module RISC_V_piplined(
    input  clk, //connected to a push button
    input rst  //connected to a push button (initialize pc and RF to zeros)
);
    
    //Declaring all wires
    
    //instruction and PC
    wire [31:0] instruction;  
    wire [31:0] PC, PC_plus_4, branch_target, PC_input;
    wire zero_and_branch;
    wire [1:0] PCSrc; //out of branch_control into mux_pc
    
    //IF/ID register
    wire [31:0] IF_ID_PC, IF_ID_Inst;
    
    //Control Unit  
    wire [3:0] ALUOp;
    wire [1:0] branchOp;
    wire MemRead, MemtoReg, MemWrite, AlUSrc, RegWrite;
    
    //ID/EX register
    wire [10:0] ID_EX_Ctrl;
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
    wire [3:0] ID_EX_Func;
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;
    
    //ALU
    wire [3:0] ALU_sel;
    wire zeroFlag;
    wire [31:0] ALU_2nd_src_MUX_out;
    wire [31:0] ALU_output;
    wire [31:0] NegativeFlag;
    wire [31:0] OverflowFlag;
    wire [31:0] CarryFlag;
    
    //Register File
    wire [31:0] read_data_1;
    wire [31:0] read_data_2;
    wire [31:0] write_data;
    
    //Immediate Generator & shift lef
    wire [31:0] ImmGen_output;
    wire [31:0] shift_left_1_out;
    
 
    //EX/MEM
    wire [5:0] EX_MEM_Ctrl;
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_CarryFlag, EX_MEM_NegativeFlag, EX_MEM_OverflowFlag;
    wire [4:0] EX_MEM_Rd;
    wire [2:0] EX_MEM_funct3;
    wire EX_MEM_Zero;
    
    //Data Memory
    wire [31:0] read_data_mem;
    
    //MEM/WB register
    wire [1:0] MEM_WB_Ctrl;
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
    wire [4:0] MEM_WB_Rd;
           
    //Instantiating Modules
    //Instantiate Program counter
    N_bit_register program_counter(.load(1'b1),
                                   .clk(clk),
                                   .rst(rst),
                                   .D(PC_input),
                                   .Q(PC));
    //instruction memory
    InstMem IM(.addr(PC[7:2]), 
               .data_out(instruction));
               
    N_bit_register #(64) IF_ID(
                              .clk(clk),
                              .rst(rst),
                              .load(1'b1),//it should be always one
                              .D({PC, instruction}),
                              .Q({IF_ID_PC, IF_ID_Inst}));
    //register file
    Register_file RF(.clk(clk),
                     .rst(rst),
                     .read_reg_1_indx(IF_ID_Inst[19:15]),
                     .read_reg_2_indx(IF_ID_Inst[24:20]),
                     .write_reg_indx(MEM_WB_Rd),
                     .write_data(write_data),
                     .reg_write(MEM_WB_Ctrl[0]),
                     .read_reg_1_data(read_data_1),
                     .read_reg_2_data(read_data_2));
    //control unit
    control_unit CU ( .Inst_6_2(IF_ID_Inst[6:2]),
                      .Branch(branchOp),
                      .MemRead(MemRead),
                      .MemtoReg(MemtoReg),
                      .ALUOp(ALUOp),
                      .MemWrite(MemWrite),
                      .ALUsrc(ALUSrc),
                      .RegWrite(RegWrite));
    //Immediate generator
    ImmGen immediate_generator (.gen_out(ImmGen_output), 
                                .inst(IF_ID_Inst));
                                
    N_bit_register #(158) ID_EX ( //11 + 32 * 4 + 1 + 3 + 5  + 10
                                 .clk(clk),
                                 .rst(rst),
                                 .load(1'b1), //TODO make sure it's written each triggering edge
                                 .D({
                                 { //re-ordered to match datapath figure WB, M, EX
                                     ALUSrc,     //EX 10
                                     ALUOp,      //EX 9
                                                 //EX 8
                                                 //EX 7
                                                 //EX 6
                                     MemWrite,   //M  5
                                     MemRead,    //M  4
                                     branchOp,   //M  3
                                                 //M  2
                                     MemtoReg,   //WB 1
                                     RegWrite    //WB 0
                                     },
                                      IF_ID_PC, //32
                                      read_data_1, //32
                                      read_data_2, //32
                                      ImmGen_output, //32
                                      
                                      {IF_ID_Inst[30],
                                      IF_ID_Inst[14:12]}, //func3 //4
                                      
                                      IF_ID_Inst[19:15],       //Rs1 //5
                                      IF_ID_Inst[24:20],       //Rs2 //5
                                      IF_ID_Inst[11:7]} //rd         //5
                                      ),
                                    
                                 .Q({ID_EX_Ctrl,      //11
                                     ID_EX_PC,        //32
                                     ID_EX_RegR1,     //32
                                     ID_EX_RegR2,     //32
                                     ID_EX_Imm,       //32
                                     ID_EX_Func,      //4
                                     ID_EX_Rs1,       //5
                                     ID_EX_Rs2,       //5
                                     ID_EX_Rd}        //5
                                     )
                                 );
   //ALU Control
     ALU_control_unit alu_control (.ALUOp(ID_EX_Ctrl[9:6]),
                                   .funct3(ID_EX_Func[2:0]),
                                   .bit_30(ID_EX_Func[3]),
                                   .ALU_selection(ALU_sel));
  
   //ALU
     N_bit_ALU #(32) alu_inst (.A(ID_EX_RegR1),
                               .B(ALU_2nd_src_MUX_out),
                               .sel(ALU_sel),
                               .ALU_output(ALU_output),
                               .ZeroFlag(zeroFlag),
                               .NegativeFlag(NegativeFlag),
                               .OverflowFlag(OverflowFlag),
                               .CarryFlag(CarryFlag));
   //MUX for ALU 2nd source
   n_bit_2_x_1_MUX  ALU_2nd_src( .a(ID_EX_Imm), //when ALUSrc
                                .b(ID_EX_RegR2),
                                .s(ID_EX_Ctrl[10]),
                                .o(ALU_2nd_src_MUX_out));
    //shift left
     n_bit_shift_left SL( .D(ID_EX_Imm),
                          .Q(shift_left_1_out));
     //Adder for immediate
     assign branch_target = shift_left_1_out + ID_EX_PC;
     
    //EX/MEM
    N_bit_register #(207) EX_MEM (.clk(clk),
                   .rst(rst),
                   .load(1'b1),
                   .D({//5 + 32 + 32 + 1 + 32 + 32 + 32 + 3 + 32 + 5
                       ID_EX_Ctrl[5:0], //M, WB
                        branch_target,
                        CarryFlag, //new
                        zeroFlag,
                        ALU_output,
                        NegativeFlag, //new
                        OverflowFlag, //new
                        ID_EX_Func[2:0],
                        ID_EX_RegR2,
                        ID_EX_Rd}),
                        
                   .Q({ EX_MEM_Ctrl, 
                        EX_MEM_BranchAddOut, 
                        EX_MEM_CarryFlag,
                        EX_MEM_Zero,
                        EX_MEM_ALU_out,
                        EX_MEM_NegativeFlag,
                        EX_MEM_OverflowFlag, 
                        EX_MEM_funct3,
                        EX_MEM_RegR2, 
                        EX_MEM_Rd}));
                        

   //Data Memory
   DataMem data_memory (
       .clk(clk),
       .MemRead(EX_MEM_Ctrl[4]),
       .MemWrite(EX_MEM_Ctrl[5]),
       .addr(EX_MEM_ALU_out[7:0]), // no longer divide by 4 but check for funct3 to better understand what to return., address of byte not word be careful
       .data_in(EX_MEM_RegR2),
       .funct3(EX_MEM_funct3),
       .data_out(read_data_mem)
   );
   
   //MEM/WB
   N_bit_register #(71) MEM_WB(
        .clk(clk),
        .rst(rst),
        .load(1'b1),
        .D({
            EX_MEM_Ctrl[1:0],
            read_data_mem,
            EX_MEM_ALU_out,
            EX_MEM_Rd
            }),
        .Q({MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out,
            MEM_WB_Rd})
   );   
   
   //MUX for Data Memory output
   n_bit_2_x_1_MUX RF_write_data(.a(MEM_WB_Mem_out),
                                 .b(MEM_WB_ALU_out),
                                 .s(MEM_WB_Ctrl[1]),
                                 .o(write_data));
    
   //Adder for PC
   assign PC_plus_4 = PC + 4; 
   
   //MUX for PC input 
//   n_bit_2_x_1_MUX mux_pc(.a(branch_target),
//                          .b(PC_plus_4),
//                          .s(zeroFlag & Branch),//TODO potential error
//                          .o(PC_input));


    branch_control bc(.branchOp(EX_MEM_Ctrl[3:2]),
                    .funct3(EX_MEM_funct3),
                    .zf(EX_MEM_Zero),
                    .cf(EX_MEM_CarryFlag),
                    .sf(EX_MEM_NegativeFlag),
                    .vf(EX_MEM_OverflowFlag),
                    .PCSrc(PCSrc));
                    
    MUX_4x1 mux_pc(.a(PC_plus_4), //sel = 2'b00
                    .b(EX_MEM_BranchAddOut), //sel = 2'b01
                    .c(32'bx), //sel 2'b10 for jalr but TODO
                    .d(32'bx), //sel 2'b11
                    .sel(PCSrc),
                    .out(PC_input));//
                                     
endmodule
