`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:08:22 AM
// Design Name: 
// Module Name: DFlipFlop_tb
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

//module DFlipFlop (input clk, 
//                  input rst, 
//                  input D, 
//                  output reg Q);

module DFlipFlop_tb;
    	localparam period = 10;

        
    	reg clk;
    	reg rst;
    	reg D;
    	wire Q;
    	
    	DFlipFlop DFF(.clk(clk), .rst(rst), .D(D), .Q(Q));

        initial begin
            clk = 1'b0;
            forever # (period/2) clk = ~clk;
        end
        
        initial begin
            rst = 1'b1;
            D = 1'b0;
            
            # (period);
            rst = 1'b0;
            # (period);
            D = 1'b1;
            # (period);
            $finish;
        end
endmodule
