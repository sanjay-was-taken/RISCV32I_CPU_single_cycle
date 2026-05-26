`timescale 1ns / 1ps
module register_file(
    input clk, write_en,
    input [4:0] write_addr,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [31:0] write_data,
    output reg [31:0] read_data1, read_data2
);
reg [31:0] registers[0:31];
always @(posedge clk) begin
    if(write_en && write_addr != 0)
        registers[write_addr] <= write_data;
end
always @(*) begin
    if(read_addr1 == 0)
        read_data1 = 0;
    else
        read_data1 = registers[read_addr1];
    if(read_addr2 == 0)
        read_data2 = 0;
    else
        read_data2 = registers[read_addr2];
end
initial begin
    registers[1] = 5;
    registers[2] = 1;
end
endmodule