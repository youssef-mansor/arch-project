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
    
    
        // first test case: Includes: lw, or, beq, add, sw, sub
        mem[0]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
        mem[1]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)
        mem[2]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)
        mem[3]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2
        mem[4]=32'b0_000000_00011_00100_000_0100_0_1100011; //beq x4, x3, 4
        mem[5]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2
        mem[6]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2
        mem[7]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)
        mem[8]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)
        mem[9]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1
        mem[10]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
        mem[11]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
        mem[12]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1



//         second test case: Includes: addi, add, sub, xor, ebreak, slti, andi, slt, ecall
//        mem[0]=32'b00000000101000000000000010010011; // addi x1, x0, 10
//        mem[1]=32'b00000001010000000000000100010011; // addi x2, x0, 20
//        mem[2]=32'b00000000001000001000000110110011; // add x3, x1, x2
//        mem[3]=32'b01000000000100011000001000110011; // sub x4, x3, x1
//        mem[4]=32'b00000000011000101100001110110011; // xor x7, x5, x6
//        mem[5]=32'b00000000000100000000000001110011; // ebreak
//        mem[6]=32'b00000000111100100010010000010011; // slti x8, x4, 15
//        mem[7]=32'b00000000001100011111001010010011; // andi x5, x3, 3
//        mem[8]=32'b00000000001100100010010010110011; // slt x9, x4, x3
//        mem[9]=32'b00000000000000000000000001110011; // ecall
        
        
        
        // Thid program: different branches, auipc, lui, jal, jalr

    end
    
endmodule

