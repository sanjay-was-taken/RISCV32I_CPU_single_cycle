`timescale 1ns / 1ps

module instruction_decoder(
    input [31:0] instruction,
    output [6:0] opcode,
    output [4:0] rd,
    output [2:0] funct3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [6:0] funct7,
    output [11:0] imm_i,
    output [11:0] imm_sw,
    output [12:0] imm_b,
    output  [21:0] imm_j,
    output [19:0] imm_u
    );
    assign opcode=instruction[6:0];
    assign rd=instruction[11:7];
    assign funct3=instruction[14:12];
    assign rs1=instruction[19:15];
    assign rs2=instruction[24:20];
    assign funct7=instruction[31:25];
    assign imm_i={funct7,rs2};
    assign imm_sw={funct7,rd};
    assign imm_b={funct7[6],rd[0],funct7[5:0],rd[4:1],1'b0};
    assign imm_j={funct7[6],rs1,funct3,rs2[0],funct7[5:0],rs2[4:1],1'b0};
    assign imm_u = instruction[31:12];
    endmodule
    