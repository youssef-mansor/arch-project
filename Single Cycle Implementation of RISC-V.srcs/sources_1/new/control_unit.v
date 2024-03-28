`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 09:19:04 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(input [4:0]      Inst_6_2, //represet instruction[6:2]
                    input Inst_20,
                    output reg [1:0] Branch,
                    output reg       MemRead,
                    output reg       MemtoReg,
                    output reg [3:0] ALUOp,
                    output reg       MemWrite,
                    output reg       ALUsrc,
                    output reg       RegWrite
                    output reg       pc_halt
                    );

   always @(*) begin
      case(Inst_6_2)
        5'b01100: begin
           Branch = 2'b00;
           MemRead <= 0;
           MemtoReg <= 0;
           ALUOp = 4'b0010;
           MemWrite <= 0;
           ALUsrc <= 0;
           RegWrite <= 1;
           pc_halt <= 0;
        end
        5'b00000:begin
           Branch <= 2'b00;
           MemRead <= 1;
           MemtoReg <= 1;
           ALUOp <= 4'b0000;
           MemWrite <= 0;
           ALUsrc <= 1;
           RegWrite <= 1;
           pc_halt <= 0;
        end//
        5'b01000: begin
           Branch <= 2'b00;
           MemRead <= 0;
           MemtoReg <= 1'bx;//don't care
           ALUOp <= 4'b0000;
           MemWrite <= 1;
           ALUsrc <= 1;
           RegWrite <= 0;
           pc_halt <= 0;
        end//
        5'b00100: begin
           Branch <= 2'b00;
           MemRead <= 0;
           MemtoReg <= 0;
           ALUOp <= 4'b0010;
           MemWrite <= 0;
           ALUsrc <= 1;
           RegWrite <= 1;
           pc_halt <= 0;
        end//
        5'b11000: begin
           Branch <= 2'b01;
           MemRead <= 0;
           MemtoReg <= 1'bx;//don't care
           ALUOp <= 4'b0001;
           MemWrite <= 0;
           ALUsrc <= 0;
           RegWrite <= 0;
           pc_halt <= 0;
        end//
        5'b11011: begin //JAL
           Branch <= 2'b10;
           MemRead <= 0;
           MemtoReg <= 1'bx;//don't care
           ALUOp <= 4'b0000;
           MemWrite <= 0;
           ALUsrc <= 1;
           RegWrite <= 1;
           pc_halt <= 0;
         end//
        5'b11001: begin//JALR
           Branch <= 2'b11;
           MemRead <= 0;
           MemtoReg <= 1'bx;//don't care
           ALUOp <= 4'b0000;
           MemWrite <= 0;
           ALUsrc <= 1;
           RegWrite <= 1;
           pc_halt <= 0;
         end//
         5'b00011: begin // fence
            Branch <= 2'b00;
            MemRead <= 0;
            MemtoReg <= 1'bx;//don't care
            ALUOp <= 4'b0000;
            MemWrite <= 0;
            ALUsrc <= 0;
            RegWrite <= 0;
            pc_halt <= 0;
         end
         5'b11100: begin // ecall or ebreak
            Branch <= 2'b00;
            MemRead <= 0;
            MemtoReg <= 1'bx;//don't care
            ALUOp <= 4'b0000;
            MemWrite <= 0;
            ALUsrc <= 0;
            RegWrite <= 0;

            if (Inst_20 == 1) begin
               pc_halt <= 0;
            end

            else begin
               pc_halt <= 1;
            end
         end
        endcase
    end
    
endmodule
