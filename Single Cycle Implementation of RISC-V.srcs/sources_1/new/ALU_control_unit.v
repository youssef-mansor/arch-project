`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 01:37:55 PM
// Design Name: 
// Module Name: ALU_control_unit
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


module ALU_control_unit(
    input [1:0] ALUOp,
    input [2:0] funct3, //instruction[14:12]
    input bit_30,
    output reg [3:0] ALU_selection
    );
   always @(*) begin
         case(ALUOp)
             2'b00: begin
                         ALU_selection = 4'b0010;
                    end
             2'b01: begin
                         ALU_selection = 4'b0110;
                    end
             2'b10: begin
                        case (funct3)
                            3'b000:  ALU_selection = bit_30 ? 4'b0110 : 4'b0010;
                            3'b111:  ALU_selection = bit_30 ? 4'bxxxx : 4'b0000;
                            3'b110:  ALU_selection = bit_30 ? 4'bxxxx : 4'b0001;
                            3'b100:  ALU_selection = bit_30 ? 4'bxxxx : 4'b1000;
                            3'b010:  ALU_selection = bit_30 ? 4'bxxxx : 4'b1001;
                            3'b011:  ALU_selection = bit_30 ? 4'bxxxx : 4'b1010;
                        endcase
                    end
             default: ALU_selection = 4'bxxxx;
        endcase
     end
endmodule
