`timescale 1ns / 1ps
module cpu_top_tb;
reg clk;
reg rst;
wire [31:0] pc;
wire [31:0] instruction;
wire [31:0] write_back_data;
wire mem_write;
wire mem_read;
wire branch_taken;
wire jal;

cpu_top DUT(clk, rst, pc, instruction, write_back_data,mem_write,mem_read,branch_taken,jal);

initial begin
    clk = 0;
    rst = 1;
    #10 rst = 0;
end

always #5 clk = ~clk;

endmodule