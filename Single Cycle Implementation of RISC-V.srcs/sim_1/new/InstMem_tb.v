`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 09:07:53 AM
// Design Name: 
// Module Name: InstMem_tb
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

module InstMem_tb;

    // Inputs
    reg [5:0] addr;

    // Outputs
    wire [31:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    InstMem uut (
        .addr(addr), 
        .data_out(data_out)
    );

    initial begin
        // Initialize Inputs
        addr = 6'b000000;
        
        // Wait 100 ns for global reset to finish
        #20;
        // Add stimulus here
        $display("Addr: 0, Data out: %b", data_out);
        
        addr = 6'b000001; #10;
        $display("Addr: 1, Data out: %b", data_out);
        
        addr = 6'b000010; #10;
        $display("Addr: 2, Data out: %b", data_out);
        
        addr = 6'b000011; #10;
        $display("Addr: 3, Data out: %b", data_out);
        
        addr = 6'b000100; #10;
        $display("Addr: 4, Data out: %b", data_out);
        
        $finish;
    end

endmodule


