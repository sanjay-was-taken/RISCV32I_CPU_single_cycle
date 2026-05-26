`timescale 1ns / 1ps
module cpu_top(
    input clk, rst,
    output [31:0] pc,
    output [31:0] instruction,
    output [31:0] write_back_data,
    output mem_write,
    output mem_read,
    output branch_taken,
    output jal
);
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [6:0] funct7;
wire [11:0] imm_i, imm_sw;
wire [12:0] imm_b;
wire [21:0] imm_j;
wire [19:0] imm_u;
wire [3:0] select;
wire [31:0] a, b, c, operand_b;
wire [31:0] imm_ext_i, imm_ext_s, imm_ext_b, imm_ext_j, imm_ext_u;
wire [31:0] mem_data, write_back_data, next_pc;
wire alu_src, mem_write, mem_read, reg_write;
wire beq, bne, blt, bge, jal, jalr, lui, auipc;
wire zero, less_than, branch_taken;

assign imm_ext_i = {{20{imm_i[11]}}, imm_i};
assign imm_ext_s = {{20{imm_sw[11]}}, imm_sw};
assign imm_ext_b = {{19{imm_b[12]}}, imm_b};
assign imm_ext_j = {{11{imm_j[20]}}, imm_j};
assign imm_ext_u = {imm_u, 12'b0};

assign write_back_data =
    (jal || jalr) ? pc + 4 :
    (lui) ? imm_ext_u :
    (auipc) ? pc + imm_ext_u :
    (mem_read) ? mem_data :
    c;

assign operand_b =
    (opcode == 7'b0100011) ? imm_ext_s :
    (alu_src) ? imm_ext_i : b;

assign branch_taken =
    (beq && zero) ||
    (bne && !zero) ||
    (blt && less_than) ||
    (bge && !less_than);

assign next_pc =
    (jalr) ? c :
    (jal) ? pc + imm_ext_j :
    (branch_taken) ? pc + imm_ext_b :
    pc + 4;

pc PC1(clk, rst, next_pc, pc);
instruction_memory IM1(pc, instruction);
instruction_decoder ID1(instruction, opcode, rd, funct3, rs1, rs2, funct7, imm_i, imm_sw, imm_b, imm_j, imm_u);
control_unit CU1(opcode, funct3, funct7, select, alu_src, mem_read, mem_write, reg_write, beq, bne, blt, bge, jal, jalr, lui, auipc);
register_file RF1(clk, reg_write, rd, rs1, rs2, write_back_data, a, b);
alu ALU1(a, operand_b, select, c, zero, less_than);
data_memory DM1(clk, mem_write, mem_read, c, b, mem_data);

endmodule