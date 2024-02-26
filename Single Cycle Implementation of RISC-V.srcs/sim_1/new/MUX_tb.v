`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:54:03 AM
// Design Name: 
// Module Name: MUX_tb
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
//module MUX(
//    input a,//input 0
//    input b,//input 1
//    input s,//selection
//    input o //output
//    );

module MUX_tb;
    reg clk;
    localparam period = 10;
    reg a;
    reg b;
    reg s;
    wire o;
    
    MUX mx(.a(a), .b(b), .s(s), .o(o));
    
    initial begin
        clk = 1'b0;
        forever # (period/2) clk = ~clk;
    end
    
    initial begin
        a = 1;
        b = 0;
        s = 1;
        #(period)
        s = 0;
        #(period)
        a = 0;
        b = 1;
        s = 1;
        #(period)
        s = 0;
        #(period)
        $finish;
    end
endmodule
