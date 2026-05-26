`timescale 1ns / 1ps
module alu(
    input [31:0] operanda, operandb,
    input [3:0] select,
    output reg [31:0] out,
    output reg zero,
    output reg less_than
);
always @(*) begin
    less_than = 0;
    case(select)
        4'b0000: out = operanda + operandb;
        4'b0001: begin
            out = operanda - operandb;
            less_than = (operanda < operandb);
        end
        4'b0010: out = operanda & operandb;
        4'b0011: out = operanda | operandb;
        4'b0100: out = operanda ^ operandb;
        4'b0101: begin
            if(operanda < operandb)
                out = 1;
            else
                out = 0;
        end
        4'b0110: out = operanda << operandb;
        4'b0111: out = operanda >> operandb;
        4'b1000: out = $signed(operanda) >>> operandb;
        default: out = 0;
    endcase
    if(out == 0)
        zero = 1;
    else
        zero = 0;
end
endmodule