`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 02:07:15 PM
// Design Name: 
// Module Name: ALU_control_unit_tb
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


module ALU_control_unit_tb;

// Inputs
reg [1:0] ALUOp;
reg [2:0] funct3;
reg bit_30;

// Outputs
wire [3:0] ALU_selection;

// Instantiate the Unit Under Test (UUT)
ALU_control_unit uut (
    .ALUOp(ALUOp), 
    .funct3(funct3), 
    .bit_30(bit_30), 
    .ALU_selection(ALU_selection)
);

initial begin
    // Initialize Inputs
    ALUOp = 0;
    funct3 = 0;
    bit_30 = 0;

    // Wait 100 ns for global reset to finish
    #20;
      
    // Add stimulus here
    ALUOp = 2'b00; funct3 = 3'b000; bit_30 = 0; #10;
    ALUOp = 2'b01; funct3 = 3'b000; bit_30 = 1; #10;
    ALUOp = 2'b10; funct3 = 3'b000; bit_30 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b000; bit_30 = 1; #10;
    ALUOp = 2'b10; funct3 = 3'b111; bit_30 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b111; bit_30 = 1; #10;
    ALUOp = 2'b10; funct3 = 3'b110; bit_30 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b110; bit_30 = 1; #10;

    // Complete the test
    $finish;
end

endmodule
