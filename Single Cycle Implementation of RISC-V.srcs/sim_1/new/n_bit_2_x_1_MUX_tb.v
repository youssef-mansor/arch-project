`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 10:12:31 AM
// Design Name: 
// Module Name: n_bit_2_x_1_MUX_tb
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


module n_bit_2_x_1_MUX_tb;
    reg [3:0] a;
    reg [3:0] b;
    reg s;
    reg clk;
    wire [3:0] o;
    
    localparam period = 10;
    
    n_bit_2_x_1_MUX mx(.a(a), .b(b), .s(s), .o(o));
    
    initial begin
        clk = 1'b0;
        forever # (period/2) clk = ~clk;
    end
    
    initial begin
        a = 13;
        b = 9;
        s = 1;
        #(period)
        s = 0;
        #(period)
        $finish;
    end
    
endmodule
