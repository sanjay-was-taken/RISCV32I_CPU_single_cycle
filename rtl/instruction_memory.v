`timescale 1ns / 1ps
module instruction_memory(
    input [31:0] pc,
    output reg [31:0] instruction
);
reg [31:0] memory[0:255];
always @(*) begin
    instruction = memory[pc/4];
end
initial begin
    $readmemh("program.mem", memory);
end
endmodule