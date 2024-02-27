`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 09:10:49 AM
// Design Name: 
// Module Name: Register_file_tb
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


module Register_file_tb;

// Parameters
reg clk;
reg rst;
reg [4:0] read_reg_1_indx;
reg [4:0] read_reg_2_indx;
reg [4:0] write_reg_indx;
reg [31:0] write_data;
reg reg_write;
wire [31:0] read_reg_1_data;
wire [31:0] read_reg_2_data;

// Instantiate the Unit Under Test (UUT)
Register_file UUT (
    .clk(clk),
    .rst(rst),
    .read_reg_1_indx(read_reg_1_indx),
    .read_reg_2_indx(read_reg_2_indx),
    .write_reg_indx(write_reg_indx),
    .write_data(write_data),
    .reg_write(reg_write),
    .read_reg_1_data(read_reg_1_data),
    .read_reg_2_data(read_reg_2_data)
);

initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    read_reg_1_indx = 0;
    read_reg_2_indx = 0;
    write_reg_indx = 0;
    write_data = 0;
    reg_write = 0;

    // Reset the system
    #100;
    rst = 0;

    // Write data to register 5
    #100;
    reg_write = 1;
    write_reg_indx = 5;
    write_data = 32'hA5A5A5A5;
    #10;
    reg_write = 0;

    // Read from register 5
    #100;
    read_reg_1_indx = 5;

    // Write data to register 10
    #100;
    reg_write = 1;
    write_reg_indx = 10;
    write_data = 32'h5A5A5A5A;
    #10;
    reg_write = 0;

    // Read from register 10
    #100;
    read_reg_2_indx = 10;

    // Complete the simulation
    #100;
    $finish;
end

// Clock generation
always #5 clk = ~clk;

// Monitor changes
initial begin
    $monitor("Time=%t, read_reg_1_data=%h, read_reg_2_data=%h", $time, read_reg_1_data, read_reg_2_data);
end

endmodule
