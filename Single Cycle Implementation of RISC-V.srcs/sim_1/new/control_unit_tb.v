`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 09:35:36 AM
// Design Name: 
// Module Name: control_unit_tb
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


module control_unit_tb;

    // Inputs
    reg [4:0] Inst_6_2;
    
    // Outputs
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUsrc;
    wire RegWrite;
    
    // Instantiate the Unit Under Test (UUT)
    control_unit uut (
        .Inst_6_2(Inst_6_2), 
        .Branch(Branch), 
        .MemRead(MemRead), 
        .MemtoReg(MemtoReg), 
        .ALUOp(ALUOp), 
        .MemWrite(MemWrite), 
        .ALUsrc(ALUsrc), 
        .RegWrite(RegWrite)
    );
    
    initial begin
        // Initialize Inputs
        Inst_6_2 = 0;
    
        // Wait 100 ns for global reset to finish
        #50;
        
        // Add stimulus here
        Inst_6_2 = 5'b01100; // R-type instruction
        #10;
        
        Inst_6_2 = 5'b00000; // Load instruction
        #10;
        
        Inst_6_2 = 5'b01000; // Store instruction
        #10;
        
        Inst_6_2 = 5'b11000; // Branch instruction
        #10;
    
        // Test default behavior
        Inst_6_2 = 5'b11111;
        #10;
        
        $finish;
    end
    
    initial begin
        $monitor("Time=%t | Inst_6_2=%b | Branch=%b | MemRead=%b | MemtoReg=%b | ALUOp=%b | MemWrite=%b | ALUsrc=%b | RegWrite=%b", 
                 $time, Inst_6_2, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUsrc, RegWrite);
    end

endmodule
