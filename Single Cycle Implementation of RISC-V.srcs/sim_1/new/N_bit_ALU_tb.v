`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 08:01:04 AM
// Design Name: 
// Module Name: N_bit_ALU_tb
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


module N_bit_ALU_tb;

// Parameters of the ALU
parameter N = 32;

// Testbench signals
reg [N-1:0] A_tb;
reg [N-1:0] B_tb;
reg [3:0] sel_tb;
wire [N-1:0] ALU_output_tb;
wire ZeroFlag_tb;

// Instantiate the Unit Under Test (UUT)
N_bit_ALU #(.N(N)) uut (
    .A(A_tb),
    .B(B_tb),
    .sel(sel_tb),
    .ALU_output(ALU_output_tb),
    .ZeroFlag(ZeroFlag_tb)
);

initial begin
    // Initialize Inputs
    A_tb = 0;
    B_tb = 0;
    sel_tb = 0;

    // Wait for 100 ns for global reset
    #10;
    
    // Addition Test
    A_tb = 15; B_tb = 10; sel_tb = 4'b0000;
    #10; // Wait for the operation to be performed

    // Subtraction Test
    A_tb = 20; B_tb = 10; sel_tb = 4'b0001;
    #10; // Wait for the operation to be performed

    // AND Test
    A_tb = 15; B_tb = 10; sel_tb = 4'b0101;
    #10; // Wait for the operation to be performed

    // OR Test
    A_tb = 15; B_tb = 10; sel_tb = 4'b0100;
    #10; // Wait for the operation to be performed
    
    // SLL Test
    A_tb = 15; B_tb = 1; sel_tb = 4'b1000;
    #10; //Wait for the operation to be performed
    
    // SRL Test
    A_tb = -14; B_tb = 1; sel_tb = 4'b1001;
    #10
    
    //SRA Test
    A_tb = -14; B_tb = 1; sel_tb = 4'b1010;
    #10    

    //SLT Test
    A_tb = -3; B_tb = -2; sel_tb = 4'b1101; //output should be 0
    #10
    
    //SLT Test 2
    A_tb = 3; B_tb = -2; sel_tb = 4'b1101;
    #10
    
    //SLTU Test
    A_tb = -3; B_tb = -2; sel_tb = 4'b1111 ; //output should be 1
    #10
    
    //SLTU Test 2
    A_tb = 3; B_tb = -2; sel_tb = 4'b1111 ;
    #10
    
    //SLTU Test 2
    A_tb = -2; B_tb = -3; sel_tb = 4'b1111 ;
    #10
    
    //XOR Test
    A_tb = 3; B_tb = -2; sel_tb = 4'b1101;
    #10
    
    // Complete the simulation
    $finish;
end

endmodule
