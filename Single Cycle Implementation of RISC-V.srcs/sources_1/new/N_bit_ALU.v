`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 07:14:16 AM
// Design Name: 
// Module Name: N_bit_ALU
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

//module MUX(
//    input a,//input 0
//    input b,//input 1
//    input s,//selection
//    output o //output
//    );
    
//    assign o = (s)? a: b;
//endmodule

//module RippleCarryAdder #(parameter N = 4)( // Change N to your desired bit width
//    input [N-1:0] A,
//    input [N-1:0] B,
//    input cin,
//    output [N-1:0] Sum,
//    output cout
//);

//module n_bit_2_x_1_MUX #(N = 4)(//TODO potential error
//    input [N-1:0] a,
//    input [N-1:0] b,
//    input s,
//    output [N-1:0] o
//    );
    
module N_bit_ALU #(parameter N = 32)(
    input [N-1:0] A,
    input [N-1:0] B,
    input [3:0] sel,
    output reg [N-1:0] ALU_output,
    output ZeroFlag
    );
    
    assign ZeroFlag = (ALU_output == 0);
    
    wire [N-1:0] ALU_B_input; //either holds B or ~B depending on sel[2]
    wire [N-1:0] ripple_carry_adder_sum;
    wire ripple_carry_adder_cout;
    wire [N-1:0] AND_output; //holds A & B
    wire [N-1:0] OR_output; //holds A | B
    wire [N-1:0] SLL_output; //holds SLL or SLLI output
    wire [N-1:0] SRL_output; //holds SRL or SRLI output
    wire [N-1:0] SRA_output; //holds SRA or SRAI output
    wire [4:0] shift_amount = B[N-1:0] > N-1 ? N-1 : B[4:0];
    
    n_bit_2_x_1_MUX #(32) mux_B_or_not_B(.a(~B), .b(B), .s(sel[2]), .o(ALU_B_input)); //assign ALU_B_input
    
    //instatniate N bit ripple carry adder
    //TODO: potential erro
    RippleCarryAdder #(32) ripple_carry_adder(.A(A),
                                              .B(ALU_B_input),
                                              .cin(sel[2]), //if sel[2] (subtraction) carryin = 1
                                              .Sum(ripple_carry_adder_sum),
                                              .cout(ripple_carry_adder_cout));
    assign AND_output = A & B;
    assign OR_output = A | B;
    
    assign SLL_output = A << shift_amount;
    assign SRL_output = A >> shift_amount;
    assign SRA_output = A >>> shift_amount; //TODO, not working properly
   
    
   // MUX 16 * 1
   always @(*) begin
       case(sel)
           4'b0010: ALU_output = ripple_carry_adder_sum;//
           4'b0110: ALU_output = ripple_carry_adder_sum;//
           4'b0000: ALU_output = AND_output;//
           4'b0001: ALU_output = OR_output;//
           4'b0011: ALU_output = SLL_output;
           4'b0111: ALU_output = SRL_output;
           4'b0101: ALU_output = SRA_output;
           default: ALU_output = 0;//
       endcase
   end
     
endmodule
