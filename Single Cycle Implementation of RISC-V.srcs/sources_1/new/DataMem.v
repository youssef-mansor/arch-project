`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 09:17:58 AM
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk, 
    input MemRead, 
    input MemWrite,
    input [5:0] addr, 
    input [31:0] data_in, 
    output reg [31:0] data_out);
    
    reg [31:0] mem [0:63];
    
    always @(posedge clk) begin
        if (MemWrite) begin
            // Write data to memory at the specified address
            mem[addr] <= data_in;
        end
    end
    
    always @(*) begin
         if (MemRead) begin
        // Read data from memory at the specified address
        data_out <= mem[addr];
    end
    end
    
endmodule 
