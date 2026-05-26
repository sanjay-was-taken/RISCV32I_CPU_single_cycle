`timescale 1ns / 1ps
module pc(
    input clk, rst,
    input [31:0] next_pc,
    output reg [31:0] pc
);
always @(posedge clk) begin
    if(rst == 1)
        pc <= 0;
    else
        pc <= next_pc;
end
endmodule