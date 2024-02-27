`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 07:03:40 AM
// Design Name: 
// Module Name: FullAdder
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


module FullAdder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    // Logic for sum and carry out
    assign sum = a ^ b ^ cin; // XOR for sum
    assign cout = (a & b) | (b & cin) | (cin & a); // OR for carry out
    
endmodule

