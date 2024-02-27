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
	reg [31:0] inst;

	wire [31:0] gen_out;

	ImmGen uut (
		.inst(inst),
		.gen_out(gen_out)
	);

	initial begin
		inst = 32'b11111101000000000000000000000011;

		#100;
		inst = 32'b01101110000000000000000000100011;
		#100;
		inst = 32'b01111010000000000000111111100011;
		#100;
		$finish;
    end
    
endmodule

