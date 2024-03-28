`timescale 1ns / 1ps

module n_bit_4_x_1_MUX #(parameter N = 32)(
    input [N-1:0] a,
    input [N-1:0] b,
    input [N-1:0] c,
    input [N-1:0] d,
    input [1:0] s,
    output reg [N-1:0] o
    );

 always @ ( a or b or c or d or s)
	begin
		case(s)
		  2'b00: o <= a;
		  2'b01: o <= b;
		  2'b10: o <= c;
		  2'b11: o <= d;
		endcase
	end
endmodule