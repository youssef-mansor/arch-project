`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2024 04:31:40 PM
// Design Name: 
// Module Name: RISC_V
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_V(
    input  clk, //connected to a push button
    input rst,  //connected to a push button (initialize pc and RF to zeros)
    input [1:0] ledSel,// Select infomration displayed on leds (instructions, control signals)
    input [3:0] ssdSel,// Select info displayed on SSD (PC, rs1, rs2, imm, etc..) //connected to pin E3
    output reg [15:0] LEDs,
    output reg [12:0] ssd
    );
    
    //Declaring all wires
    
    //instruction and PC
    wire [31:0] instruction;  
    wire [31:0] PC, PC_plus_4, branch_target, PC_input;
    wire zero_and_branch;
    wire [1:0] PCSrc; //out of branch_control into mux_pc

    //Control Unit  
    wire [3:0] ALUOp;
    wire [1:0] branchOp;
    wire MemRead, MemtoReg, MemWrite, AlUSrc, RegWrite;
    
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
    
    //Data Memory
    wire [31:0] read_data_mem;


    // IF/ID pipeline registers
    wire [10:0] Ctrl_Signals;
    wire [31:0] IF_ID_PC, IF_ID_Inst, IF_ID_PcPlusFour;

    // ID/EX pipeline registers
    wire [31:0] ID_EX_PC, ID_EX_PcPlusFour, ID_EX_Imm;
    wire [10:0] ID_EX_Ctrl;
    wire [2:0] ID_EX_Func3;
    wire [4:0] ID_EX_Rd, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Shamt;
    wire [31:0] ID_EX_RegisterRs1, ID_EX_RegisterRs2;
    wire        ID_EX_bit30;


    // EX/MEM pipeline registers
    wire [31:0]  EX_MEM_PC_add_imm, EX_MEM_PC_plus_4, EX_MEM_ALU_output, EX_MEM_ALU_Input_2;
    wire [5:0]  EX_MEM_Ctrl;
    wire [4:0]  EX_MEM_RegRd;
    wire [2:0]   EX_MEM_Func3;

    // MEM/WB pipeline registers
    wire [31:0]   MEM_WB_ALU_output, MEM_WB_PC_plus_4, MEM_WB_PC_add_imm, MEM_WB_MemData;
    wire [3:0]    MEM_WB_Ctrl;
    wire [4:0]    MEM_WB_RegRd;


    //Instantiating Modules
    //Instantiate Program counter
    N_bit_register program_counter(.load(1'b1),
                                   .clk(clk),
                                   .rst(rst),
                                   .D(PC_input),
                                   .Q(PC));
    //instruction memory
    InstMem IM(.addr(PC[5:0]/4), 
               .data_out(instruction));

    N_bit_register #(200) IF_ID(.clk(~clk),.rst(rst),.load(1'b1),.D({PC_plus_4,PC,instruction}),.Q({IF_ID_PcPlusFour,IF_ID_PC,IF_ID_Inst}));


    //register file
    Register_file RF(.clk(clk),
                     .rst(rst),
                     .read_reg_1_indx(IF_ID_Inst[19:15]),
                     .read_reg_2_indx(IF_ID_Inst[24:20]),
                     .write_reg_indx(MEM_WB_RegRd),
                     .write_data(write_data),
                     .reg_write(MEM_WB_Ctrl[3]),
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

    n_bit_2_x_1_MUX #(11) Control_mux(.a({ALUOp,MemRead,MemWrite,RegWrite,ALUSrc,MemToReg,branchOp}),.b(11'd0),.sel(PCSrc[0]|PCSrc[1]),.out(Ctrl_Signals));

    N_bit_register #(398) ID_EX(
         .clk(~clk),
         .rst(rst),
         .load(1'b1),
         .D({Ctrl_Signals,IF_ID_PcPlusFour,IF_ID_PC,read_data_1,read_data_2,imm_out,IF_ID_Inst[14:12],IF_ID_Inst[19:15],IF_ID_Inst[24:20],IF_ID_Inst[11:7],IF_ID_Inst[30],IF_ID_Inst[24:20]}),
         .Q({ID_EX_Ctrl,ID_EX_PcPlusFour,ID_EX_PC,ID_EX_RegisterRs1,ID_EX_RegisterRs2,ID_EX_Imm,ID_EX_Func3,ID_EX_RegR1,ID_EX_RegR2,ID_EX_Rd,ID_EX_bit30,ID_EX_Shamt})
      );


   //ALU Control
     ALU_control_unit alu_control (.ALUOp(ALUOp),
                                   .funct3(ID_EX_Func3),
                                   .bit_30(ID_EX_bit30),
                                   .ALU_selection(ALU_sel));
  
   //ALU
     N_bit_ALU #(32) alu_inst (.A(ID_EX_RegisterRs1),
                               .B(ALU_2nd_src_MUX_out),
                               .sel(ALU_sel),
                               .shift_amount(ID_EX_Shamt),
                               .ALU_output(ALU_output),
                               .ZeroFlag(zeroFlag),
                               .NegativeFlag(NegativeFlag),
                               .OverflowFlag(OverflowFlag),
                               .CarryFlag(CarryFlag));
   //MUX for ALU 2nd source
   n_bit_2_x_1_MUX  ALU_2nd_src(.a(ImmGen_output), //when ALUSrc
                                .b(ID_EX_RegisterRs2),
                                .s(ALUSrc),
                                .o(ALU_2nd_src_MUX_out));


   N_bit_register  #(300) EX_MEM(.clk(~clk),.rst(rst),.load(1'b1),
     .D({ID_EX_Ctrl[8:6],ID_EX_Ctrl[4:2],ID_EX_PcPlusFour,branch_target,ALU_output,ID_EX_RegisterRs2,ID_EX_Func3,ID_EX_Rd}),
     .Q({EX_MEM_Ctrl,EX_MEM_PC_plus_4,EX_MEM_PC_add_imm,EX_MEM_ALU_output,EX_MEM_ALU_Input_2,EX_MEM_Func3,EX_MEM_RegRd}));


   //Data Memory
   // TODO: make it dual memory
   DataMem data_memory (
       .clk(clk),
       .MemRead(EX_MEM_Ctrl[5]),
       .MemWrite(EX_MEM_Ctrl[4]),
       .addr(ALU_output[7:0]),
       .data_in(EX_MEM_ALU_Input_2),
       .funct3(EX_MEM_Func3),
       .data_out(read_data_mem)
   );


   N_bit_register  #(300) MEM_WB(.clk(clk),.rst(rst),.load(1'b1),
     .D({EX_MEM_Ctrl[3:0],EX_MEM_PC_plus_4,EX_MEM_PC_add_imm,EX_MEM_ALU_output,read_data_mem,EX_MEM_RegRd}),
     .Q({MEM_WB_Ctrl,MEM_WB_PC_plus_4,MEM_WB_PC_add_imm,MEM_WB_ALU_output,MEM_WB_MemData,MEM_WB_RegRd}));


   //MUX for Data Memory output
   n_bit_2_x_1_MUX RF_write_data(.a(MEM_WB_ALU_output),
                                 .b(MEM_WB_MemData),
                                 .s(MEM_WB_Ctrl[2]),
                                 .o(write_data));
   //shift left
   n_bit_shift_left SL( .D(ImmGen_output),
                        .Q(shift_left_1_out));
   //Adder for immediate
   assign branch_target = shift_left_1_out + PC;
   //Adder for PC
   assign PC_plus_4 = PC + 4; 
   
   //MUX for PC input 
//   n_bit_2_x_1_MUX mux_pc(.a(branch_target),
//                          .b(PC_plus_4),
//                          .s(zeroFlag & Branch),//TODO potential error
//                          .o(PC_input));


    branch_control bc(.branchOp(branchOp),
                    .funct3(ID_EX_Func3),
                    .zf(zeroFlag),
                    .cf(CarryFlag),
                    .sf(NegativeFlag),
                    .vf(OverflowFlag),
                    .PCSrc(PCSrc));
                    
    MUX_4x1 mux_pc(.a(PC_plus_4), //sel = 2'b00
                    .b(EX_MEM_PC_add_imm), //sel = 2'b01
                    .c(EX_MEM_ALU_output), //sel 2'b10 for jalr but TODO
                    .d(32'bx), //sel 2'b11
                    .sel(PCSrc),
                    .out(PC_input));
          
   //RISC-V input output
   always @(*) begin
       if(ledSel == 2'b00)
           LEDs = instruction [15:0];
       else if (ledSel == 2'b01)
           LEDs = instruction [31:16];
       else if (ledSel == 2'b10)
           LEDs = {8'b00000000, ALUOp, ALU_sel, zeroFlag, PCSrc};
       else
           LEDs = 0;
       end    
   
   always @(*) begin
       if(ssdSel == 4'b0000)
           ssd = PC;
       else if(ssdSel == 4'b0001)
           ssd = PC + 1;
       else if(ssdSel == 4'b0010)
           ssd = branch_target;
       else if(ssdSel == 4'b0011)
           ssd = PC_input;
       else if(ssdSel == 4'b0100)
           ssd = read_data_1;
       else if(ssdSel == 4'b0101)
           ssd = read_data_2;
       else if(ssdSel == 4'b0110)
           ssd = write_data;
       else if(ssdSel == 4'b0111)
           ssd = ImmGen_output;
       else if(ssdSel == 4'b1000)
           ssd = shift_left_1_out;
       else if(ssdSel == 4'b1001)
           ssd = ALU_2nd_src_MUX_out;
       else if(ssdSel == 4'b1010)
           ssd = ALU_output;
       else if(ssdSel == 4'b1011)
           ssd = read_data_mem;
   end

                                     
endmodule
