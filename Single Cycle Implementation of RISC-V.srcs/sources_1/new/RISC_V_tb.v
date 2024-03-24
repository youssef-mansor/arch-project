`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2024 01:43:06 PM
// Design Name: 
// Module Name: RISC_V_tb
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


module RISC_V_tb;

// Inputs
reg clk;
reg rst;
reg [1:0] ledSel;
reg [3:0] ssdSel;
reg ssd_clk;

// Outputs
wire [15:0] LEDs;
wire [12:0] ssd;

// Clock generation
always #50 clk = ~clk; // 50MHz Clock
always #5 ssd_clk = ~ssd_clk; // 100MHz Clock for ssd_clk, just an example

// Instantiate the Unit Under Test (UUT)
RISC_V uut (
    .clk(clk), 
    .rst(rst), 
    .ledSel(ledSel), 
    .ssdSel(ssdSel), 
    .LEDs(LEDs), 
    .ssd(ssd)
);

initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    ledSel = 0;
    ssdSel = 0;
    ssd_clk = 0;

    #100;        
    rst = 0; // De-assert reset after 100ns

    // Cycle through all combinations of ledSel and ssdSel
    for(ledSel = 0; ledSel < 4; ledSel = ledSel + 1) begin
        for(ssdSel = 0; ssdSel < 16; ssdSel = ssdSel + 1) begin
            #100; // Wait for a period to observe the change
            $display("Time: %t, ledSel: %b, ssdSel: %b, LEDs: %h, ssd: %h", $time, ledSel, ssdSel, LEDs, ssd);
        end
    end

    // Finish simulation
    #100;
    $finish;
end


endmodule

