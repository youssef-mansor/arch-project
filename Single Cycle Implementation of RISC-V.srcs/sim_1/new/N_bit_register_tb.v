`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2024 09:31:42 AM
// Design Name: 
// Module Name: N_bit_register_tb
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

//module N_bit_register #(parameter N = 8)(
//    input load,
//    input clk,
//    input rst,
//    input [N-1:0] D,
//    output [N-1:0] Q
//    );

module N_bit_register_tb;
    //local parameters
    localparam N = 32;
    localparam period = 10;
    
    //ports connections
    reg load;
    reg clk;
    reg rst;
    reg [N-1:0] D;
    wire [N-1:0] Q;
    
    //clock handling
    initial begin
        clk = 1'b0;
        forever # (period /2) clk = ~clk;
    end
    
    //instantiate our test unit
    N_bit_register #(.N(N)) N_REG(.load(load),
                                  .clk(clk),
                                  .rst(rst),
                                  .D(D),
                                  .Q(Q));
    
    //Stimulus block
    initial begin
        rst = 1'b1;
        load = 1'b0;
        D = 0;
        #(period * 2) rst = 1'b0;
        
        #(period * 1) load = 1'b1;
        D = 2003;
        #(period * 1);
        
        if(Q == D)
            $display("Correct Operation");
        else
            $display("Wronger Operation");
            
        $finish;
    end
    
endmodule
