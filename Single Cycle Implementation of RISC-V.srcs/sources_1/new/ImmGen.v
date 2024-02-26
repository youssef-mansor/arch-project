`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2024 08:48:47 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen (output reg [31:0] gen_out,
               input [31:0] inst);
               
    wire[6:0] opcode = inst[6:0];
    
    always@(*)begin
        if(opcode[6])  //BEQ
            gen_out = {{20{inst[31]}}, inst[31], inst[7],  inst[30:25], inst[11:8]};
        else if (opcode[5]) //SW
            gen_out = {{20{inst[31]}}, inst[31:25], inst[11:7]};
        else //Lw
            gen_out = {{20{inst[31]}}, inst[31:20]};
    end


endmodule
