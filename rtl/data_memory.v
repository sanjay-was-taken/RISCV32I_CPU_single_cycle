`timescale 1ns / 1ps

module data_memory(
    input clk,mem_write,mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
    );
    reg [31:0] memory [0:255];
    always@(posedge clk)begin
    if(mem_write==1)
        memory[address/4]<=write_data;
    end
    always@(*)begin
    if(mem_read==1)
        read_data=memory[address/4];
    else
        read_data=0;
    end
endmodule
