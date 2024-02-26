`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 11:13:27 AM
// Design Name: 
// Module Name: n_bit_shift_left_tb
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

//module  n_bit_shift_left #(parameter N = 8)(
//    input clk,
//    input rst,  //reset all to zero asynchronously
//    input load, //when 1 (and shift = 0) all stages load from input
//    input shift, //when 1 shift is enabled (second priority after rst)
//    input [7:0] D,
//    output reg [7:0] Q,
//    input A //input value to be shifted into first stage
//    );

module n_bit_shift_left_tb;
    reg [3:0] D;
    wire [3:0]Q;
 
    
    
    n_bit_shift_left nbsl(
                          .D(D),
                          .Q(Q));
    initial begin
        D = 4'b0101;
    end
endmodule
