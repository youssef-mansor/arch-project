module branch_control(input       branch_op, // TODO: this should be a 2-bit input from the CU to support JALR, JAL as well
                      input [2:0] funct3,
                      input       zeroFlag,
                      input       carryFlag,
                      input       negativeFlag,
                      input       overflowFlag,
                      output reg  PC_src // TODO: this should be a 2-bit output from the CU to support JALR, JAL as well
                      );

   always @(*) begin
      case(branch_op)
        1'b0: begin
           PC_src = 2'b00;
        end
        1'b1: begin
           case(funct3)
             3'b000: begin
                PC_src = zeroFlag ? 1'b1 : 1'b0;
             end
             3'b001: begin
                PC_src = ~zeroFlag ? 1'b1 : 1'b0;
             end
             3'b100: begin
                PC_src = (negativeFlag != overflowFlag) ? 1'b1 : 1'b0;
             end
             3'b101: begin
                PC_src = (negativeFlag == overflowFlag) ? 1'b1 : 1'b0;
             end
             3'b110: begin
                PC_src = ~carryFlag ? 1'b1 : 1'b0;
             end
             3'b111: begin
                PC_src = carryFlag ? 1'b1 : 1'b0;
             end
             default: PC_src = 2'b00;
           endcase
        end
         default: PC_src = 2'b00;
      endcase
   end
endmodule
