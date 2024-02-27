`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 07:04:34 AM
// Design Name: 
// Module Name: RippleCarryAdder
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


module RippleCarryAdder #(parameter N = 32)( // Change N to your desired bit width
    input [N-1:0] A,
    input [N-1:0] B,
    input cin,
    output [N-1:0] Sum,
    output cout
);
    wire [N:0] carry; // Internal carry wires, including carry-in and carry-out
    assign carry[0] = cin; // Assign carry-in to the first carry bit

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : adder_loop
            FullAdder FA(
                .a(A[i]),
                .b(B[i]),
                .cin(carry[i]),
                .sum(Sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[N]; // The final carry-out
endmodule
