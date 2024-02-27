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
    wire [3:0] Q;
    
    n_bit_shift_left nbsl(
        .D(D),
        .Q(Q)
    );
    
    initial begin
        // Test Case 1: Basic left shift
        D = 4'b0101; // Input: 0101, Expected Output: 1010
        #10; // Wait for 10 time units to observe the change
        $display("Test Case 1: D=0101, Q=%b", Q);
        
        // Test Case 2: Left shift with leading 1
        D = 4'b1001; // Input: 1001, Expected Output: 0010
        #10;
        $display("Test Case 2: D=1001, Q=%b", Q);
        
        // Test Case 3: Left shift with all zeros
        D = 4'b0000; // Input: 0000, Expected Output: 0000
        #10;
        $display("Test Case 3: D=0000, Q=%b", Q);
        
        // Test Case 4: Left shift with all ones
        D = 4'b1111; // Input: 1111, Expected Output: 1110
        #10;
        $display("Test Case 4: D=1111, Q=%b", Q);
        
        // Test Case 5: Left shift with alternating bits
        D = 4'b1010; // Input: 1010, Expected Output: 0100
        #10;
        $display("Test Case 5: D=1010, Q=%b", Q);
        $finish;
    end
endmodule

