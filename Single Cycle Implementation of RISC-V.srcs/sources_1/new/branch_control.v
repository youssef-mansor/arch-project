module branch_control(input [1:0]      branch_op, // TODO: this should be a 2-bit input from the CU to support JALR, JAL as well
                      input [2:0] funct3,
                      input       zeroFlag,
                      input       carryFlag,
                      input       negativeFlag,
                      input       overflowFlag,
                      output reg [1:0] PC_src
                      );

   always @(*) begin
      case(branch_op)
        2'b00: begin
           PC_src = 2'b00;
        end
        2'b01: begin
           case(funct3)
             3'b000: begin
                PC_src = zeroFlag ? 2'b01 : 2'b00;
             end
             3'b001: begin
                PC_src = ~zeroFlag ? 2'b01 : 2'b00;
             end
             3'b100: begin
                PC_src = (negativeFlag != overflowFlag) ? 2'b01 : 2'b00;
             end
             3'b101: begin
                PC_src = (negativeFlag == overflowFlag) ? 2'b01 : 2'b00;
             end
             3'b110: begin
                PC_src = ~carryFlag ? 2'b01 : 2'b00;
             end
             3'b111: begin
                PC_src = carryFlag ? 2'b01 : 2'b00;
             end
             default: PC_src = 2'b00;
           endcase
        end
         2'b10: begin // JAL
             PC_src = 2'b01;
         end
         2'b11: begin // JALR
             PC_src = 2'b10;
         end
        default: PC_src = 2'b00;
        endcase
      end
endmodule
