`timescale 1ns / 1ps

module N_bit_ALU #(parameter N = 32)(input [N-1:0]      A,
                                     input [N-1:0]      B,
                                     input [3:0]        sel,
                                     output reg [N-1:0] ALU_output,
                                     output             ZeroFlag,
                                     output             NegativeFlag,
                                     output             OverflowFlag,
                                     output             CarryFlag
                                     );

   wire [N-1:0] add;
   wire [N-1:0] not_b;
   
   assign not_b = ~B;

   assign ZeroFlag = (ALU_output == 0);
   assign NegativeFlag = add[N-1];

   assign {CarryFlag, add} = sel[0] ? (A + (~B) + 1'b1) : (A + B);
   assign OverflowFlag = A[N-1] ^ not_b[N-1] ^ add[N-1] ^ CarryFlag;

   always @(*) begin
      case(sel)
        4'b00_00: ALU_output = add;
        4'b00_01: ALU_output = add;
        4'b00_11: ALU_output = B;

        4'b01_00: ALU_output = A | B;
        4'b01_01: ALU_output = A & B;
        4'b01_11: ALU_output = A ^ B;

        4'b10_11: ALU_output = B;

        4'b00_10: ALU_output = A * B;
        4'b01_10: ALU_output = A / B;
        4'b11_10: ALU_output = A % B;

        4'b1001:  ALU_output = {31'b0,(NegativeFlag != OverflowFlag)};
        4'b1010:  ALU_output = {31'b0, (~CarryFlag)};
        default: ALU_output = 0;
      endcase
   end

endmodule
