`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 07:05:50 AM
// Design Name: 
// Module Name: RippleCarryAdder_tb
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


module RippleCarryAdder_tb;

parameter N = 4; // Bit width of the adder, change as needed
reg [N-1:0] A, B; // Input vectors
reg cin; // Carry input
wire [N-1:0] Sum; // Sum output vector
wire cout; // Carry output

// Instantiate the RippleCarryAdder module
RippleCarryAdder #(N) UUT (
    .A(A),
    .B(B),
    .cin(cin),
    .Sum(Sum),
    .cout(cout)
);

initial begin
    // Initialize inputs
    A = 0; B = 0; cin = 0;

    // Display results
    $monitor("Time=%t | A=%b, B=%b, cin=%b -> Sum=%b, cout=%b", $time, A, B, cin, Sum, cout);

    // Test case 1
    #10 A = 4'b0001; B = 4'b0010; cin = 1'b0; // Expected Sum=0011, cout=0
    // Test case 2
    #10 A = 4'b0101; B = 4'b0011; cin = 1'b1; // Expected Sum=1001, cout=0
    // Test case 3
    #10 A = 4'b1111; B = 4'b0001; cin = 1'b1; // Expected Sum=0001, cout=1
    // Test case 4
    #10 A = 4'b1010; B = 4'b0101; cin = 1'b0; // Expected Sum=1111, cout=0
    // Test case 5
    #10 A = 4'b1111; B = 4'b1111; cin = 1'b1; // Expected Sum=1111, cout=1

    #10 $finish; // Terminate simulation
end

endmodule