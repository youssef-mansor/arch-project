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
    //assign some values to the first 5 locations
    initial begin
        mem[0] = 32'b00000000010000010000000100010011;
        mem[1] = 32'b01000010010000000000001000101101;
        mem[2] = 32'b01000000010000010000000000010000;
        mem[3] = 32'b00000000010000010000000100010010;
        mem[4] = 32'b01000000010000010000000000010100;
        // Assign other values as needed...
    end
endmodule

