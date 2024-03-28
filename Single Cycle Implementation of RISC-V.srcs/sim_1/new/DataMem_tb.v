`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 09:31:58 AM
// Design Name: 
// Module Name: DataMem_tb
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
module DataMem_tb;

    // Inputs
    reg clk;
    reg MemRead;
    reg MemWrite;
    reg [5:0] addr;
    reg [31:0] data_in;
    reg [2:0] funct3;

    // Output
    wire [31:0] data_out;
    //wire [31:0] mem [0:63];
    // Instantiate the Unit Under Test (UUT)
    DataMem uut (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(addr),
        .data_in(data_in),
        .funct3(funct3),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Clock with a period of 10 ns

    initial begin
        // Initialize Inputs
        clk = 0;
        MemRead = 0;
        MemWrite = 0;
        addr = 0;
        data_in = 0;
        funct3 = 3'b000;
        //Write operation
        #10;
        addr = 6'b000001;
        data_in = 32'hA5A5A5A5;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        //Read operation
        #10;
        funct3 = 3'b000;
        addr = 6'b000001;
        MemRead = 1;
        #10;
        MemRead = 0;

        // End of simulation
        #10;
        $finish;
    end

endmodule

