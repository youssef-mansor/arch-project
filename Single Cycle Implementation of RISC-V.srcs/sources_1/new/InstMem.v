`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 09:02:23 AM
// Design Name: 
// Module Name: InstMem
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


module InstMem (input [5:0] addr, output [31:0] data_out);
    reg [31:0] mem [0:63];
    assign data_out = mem[addr];
    
    //initialize the instruction memory
    initial begin
//program original given in lab
//        mem[0]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
//        mem[1]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)
//        mem[2]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)
//        mem[3]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2
//        mem[4]=32'b0_000000_00011_00100_000_0100_0_1100011; //beq x4, x3, 4
//        mem[5]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2
//        mem[6]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2
//        mem[7]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)
//        mem[8]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)
//        mem[9]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1
//        mem[10]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
//        mem[11]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
//        mem[12]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1
//program given in lab 7 with nops
//    mem[0]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[1]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
//    mem[2]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[3]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[4]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[5]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)
//    mem[6]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[7]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[8]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[9]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)
//    mem[10]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[11]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[12]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[13]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2
//    mem[14]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[15]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[16]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[17]=32'b0_000001_00011_00100_000_0000_0_1100011; //beq x4, x3, 16
//    mem[18]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[19]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[20]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[21]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2
//    mem[22]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[23]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[24]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[25]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2    //2196147
//    mem[26]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[27]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[28]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[29]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)      
//    mem[30]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[31]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[32]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[33]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)      //12591875 This instruction from lab7 will not work with byte addressable memroy
//    mem[34]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[35]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[36]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[37]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1
//    mem[38]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[39]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[40]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[41]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
//    mem[42]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[43]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[44]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[45]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
//    mem[46]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[47]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[48]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
//    mem[49]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1
//program from lab 7 suitable for forwarding ragab
//mem[0]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0//added to be skipped since PC starts with 4 after reset 
//    mem[1]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)     8323
//    mem[2]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)    //4202755
//    mem[3]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)    //8397187
//    mem[4]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2  //2155059
////    mem[5]=32'b00000000001100100000101001100011; //beq x4, x3, 20 //36831331
//    mem[5]=32'b0_000001_00011_00100_000_0000_0_1100011; //beq x4, x3, 16
//    mem[6]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
//    mem[7]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
//    mem[8]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
//    mem[9]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2  //2130355
//    mem[10]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2 //2196147
//    mem[11]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)  //5252643
//    mem[12]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)      //12591875
//    mem[13]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
//    mem[14]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1  //1274803
//    mem[15]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
//    mem[16]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2 
//    mem[17]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1
//temprorary trial
mem[0]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0//added to be skipped since PC starts with 4 after reset 
 mem[1]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)  17
            mem[2]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)  9
            mem[3]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0) 25
            mem[4]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2 25
            mem[5]=32'b0_000001_00011_00100_000_0000_0_1100011; //beq x4, x3, 16 0
            mem[6]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
            mem[7]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
            mem[8]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
            mem[9]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2
            mem[10]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
            mem[11]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
            mem[12]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
            mem[13]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2 34
            mem[14]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)
            mem[15]=32'b000000001100__00000_010_00110_0000011; //lw x6, 12(x0)
            mem[16]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1
            mem[17]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
            mem[18]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
            mem[19]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1




//program for lab 6
//          mem[0] = 32'b00000000000000000010000110000011;//lw x3, 0(x0)
//          mem[1] = 32'b00000000010000000010001000000011;//lw x4, 4(x0)
//          mem[2] = 32'b00000000100000000010001010000011;//lw x5, 8(x0)
//          mem[3] = 32'b00000000110000000010000010000011;//lw x1, 12(x0)
//          mem[4] = 32'b00000000000000101000100001100011;//beq x5, zero, 16
//          mem[5] = 32'b00000000010000011000000110110011;//add x3, x3, x4
//          mem[6] = 32'b00000000000100101000001010110011;//add x5, x5, x1 
//          mem[7] = 32'b11111110000000000000101011100011;//beq zero, zero, -12
//          mem[8] = 32'b00000000000000000000000000110011;//add x0, x0, x0
//          mem[9] = 32'b01000000010000011000000110110011;//sub x3, x3, x4
//          mem[10] = 32'b00000000010000011111000110110011;//and x3, x3, x4
//          mem[11] = 32'b00000000010000011110000110110011;//or x3, x3, x4
//          mem[12] = 32'b00000000001100000010100000100011;//sw x3, 16(x0)
//program for testing load instructions 
//            mem[0] = 32'b00000000000000110000001110000011; // lb x7, 0(x6)
//            mem[1] = 32'b00000000010000110000010000000011; // lb x8, 4(x6)
//            mem[2] = 32'b00000000000000110001010010000011; // lh x9, 0(x6)
//            mem[3] = 32'b00000000100000110001010100000011; // lh x10, 8(x6)
//            mem[4] = 32'b00000000000000110010010110000011; // lw x11, 0(x6)
//            mem[5] = 32'b00000000010000110100011000000011; // lbu x12, 4(x6)
//            mem[6] = 32'b00000000110000110100011010000011; // lbu x13, 12(x6)
//            mem[7] = 32'b00000000000000110101011100000011; // lhu x14, 0(x6)
//            mem[8] = 32'b00000001000000110101011110000011; // lhu x15, 16(x6)    
//program for testing branch instructins
//                mem[0] = 32'b00000000101000000000001010010011;  // addi x5, x0, 10
//                mem[1] = 32'b00000001010000000000001100010011;  // addi x6, x0, 20
//                mem[2] = 32'b00000000101000000000001110010011;  // addi x7, x0, 10
//                mem[3] = 32'b11111111111100000000010000010011;  // addi x8, x0, -1
//                mem[4] = 32'b11111111111000000000010010010011;  // addi x9, x0, -2
//                mem[5] = 32'b00000000011100101000010001100011;  // beq x5, x7, 8
//                mem[6] = 32'b00000000000100000000010100010011;  // addi x10, x0, 1
//                mem[7] = 32'b00000000011000101001010001100011;  // bne x5, x6, 8
//                mem[8] = 32'b00000000001000000000010100010011;  // addi x10, x0, 2
//                mem[9] = 32'b00000000011000101100010001100011;  // blt x5, x6, 8
//                mem[10] = 32'b00000000001100000000010100010011; // addi x10, x0, 3
//                mem[11] = 32'b00000000011000101101010001100011; // bge x5, x6, 8
//                mem[12] = 32'b00000000010000000000010100010011; // addi x10, x0, 4
//                mem[13] = 32'b00000000100101000110010001100011; // bltu x8, x9, 8 //will not branch and in rars next call is ecall
//program for testing storing instructions
//            mem[0] = 32'b00000000010100000000000010010011;//addi x1, x0, 5
//            mem[1] = 32'b00111110011100000000000100010011;//addi x2, x0, 999
//            mem[2] = 32'b11111011111100000000000110010011;//addi x3, x0, -65
//            mem[3] = 32'b00000000010000000000001000010011;//addi x4, x0, 4
//            mem[4] = 32'b00000000000100110000000000100011;//sb x1, 0(x6)
//            mem[5] = 32'b00000000001000110001000100100011;//sh x2, 2(x6)
//            mem[6] = 32'b00000000001100110010001000100011;//sw x3, 4(x6)

    end
    
endmodule

