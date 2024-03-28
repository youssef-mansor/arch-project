`timescale 1ns / 1ps

module ALU_control_unit(
    input [3:0] ALUOp,
    input [2:0] funct3,
    input bit_30,
    output reg [3:0] ALU_selection
    );
   always @(*) begin
         case(ALUOp)
            4'b0000: begin // R-type
               case(funct3)

                  3'b000: begin
                     if(bit_30 == 1'b0) begin
                        ALU_selection = 4'b0000; // ADD
                     end
                     else begin
                        ALU_selection = 4'b0001; // SUB
                     end
                  end

                  3'b010: ALU_selection = 4'b1001; // SLT
                  3'b011: ALU_selection = 4'b1010; // SLTU
                  3'b100: ALU_selection = 4'b0111; // XOR
                  3'b110: ALU_selection = 4'b0100; // OR
                  3'b111: ALU_selection = 4'b0101; // AND
                  default: ALU_selection = 4'b0000;
               endcase
            end
            4'b0001: begin // I-type
               case(funct3)

                  3'b000: begin
                     if(bit_30 == 1'b0) begin
                        ALU_selection = 4'b0000; // ADD
                     end
                     else begin
                        ALU_selection = 4'b0001; // SUB
                     end
                  end

                  3'b010: ALU_selection = 4'b1001; // SLT
                  3'b011: ALU_selection = 4'b1010; // SLTU
                  3'b100: ALU_selection = 4'b0111; // XOR
                  3'b110: ALU_selection = 4'b0100; // OR
                  3'b111: ALU_selection = 4'b0101; // AND
                  default: ALU_selection = 4'b0000;
               endcase
            end
            4'b0010: begin // branch
               ALU_selection = 4'b0001; // SUB
            end
            // 4'b0101: begin // LUI TODO

            // end
            4'b0110: begin // AUIPC
               ALU_selection = 4'b0000; // ADD
            end
            4'b0111: begin // JAL
               ALU_selection = 4'b0000; // ADD
            end
            4'b1000: begin // JALR
               ALU_selection = 4'b0000; // ADD
            end
        endcase
     end
endmodule
