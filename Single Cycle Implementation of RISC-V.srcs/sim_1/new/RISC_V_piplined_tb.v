`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 02:26:43 AM
// Design Name: 
// Module Name: RISC_V_piplined_tb
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


module RISC_V_piplined_tb;

// Inputs
reg clk;
reg rst;


// Clock generation
always #50 clk = ~clk; // 50MHz Clock

// Instantiate the Unit Under Test (UUT)
RISC_V_piplined uut (
    .clk(clk), 
    .rst(rst) 
);

//block for testing using scopes and objects only
initial begin
        // Initialize Inputs
    clk = 1;
    rst = 1;
    #100
    rst = 0;
end


endmodule


