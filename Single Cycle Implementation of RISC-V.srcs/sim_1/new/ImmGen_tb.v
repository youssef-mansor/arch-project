`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2024 09:05:24 PM
// Design Name: 
// Module Name: ImmGen_tb
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


module ImmGen_tb;
	//Inputs
	reg [31:0] inst;

	//Outputs
	wire [31:0] gen_out;

	//Instantiation of Unit Under Test
	ImmGen uut (
		.inst(inst),
		.gen_out(gen_out)
	);

	initial begin
	//Inputs initialization
		inst = 32'b01111101000000000000000000000011; //2000

	//Wait for the reset
		#100;
		inst = 32'b01111110000000000000000000100011; //2016
		#100;
		inst = 32'b01111110000000000000111111100011; //4094
		#100;
		$finish;
    end
    
endmodule

