`timescale 1ns / 1ps
module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] select,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg beq,
    output reg bne,
    output reg blt,
    output reg bge,
    output reg jal,
    output reg jalr,
    output reg lui,
    output reg auipc
);
always @(*) begin
    alu_src = 0;
    mem_read = 0;
    mem_write = 0;
    reg_write = 0;
    beq = 0;
    bne = 0;
    blt = 0;
    bge = 0;
    jal = 0;
    jalr = 0;
    auipc = 0;
    lui = 0;
    select = 4'b0000;
    if(opcode == 7'b0110011) begin
        reg_write = 1;
        alu_src = 0;
        if(funct3 == 3'b000) begin
            if(funct7 == 7'b0000000)
                select = 4'b0000;
            else if(funct7 == 7'b0100000)
                select = 4'b0001;
        end
        else if(funct3 == 3'b111)
            select = 4'b0010;
        else if(funct3 == 3'b110)
            select = 4'b0011;
        else if(funct3 == 3'b100)
            select = 4'b0100;
        else if(funct3 == 3'b010) begin
            if(funct7 == 7'b0000000)
                select = 4'b0101;
        end
        else if(funct3 == 3'b001)
            select = 4'b0110;
        else if(funct3 == 3'b101) begin
            if(funct7 == 7'b0000000)
                select = 4'b0111;
            else if(funct7 == 7'b0100000)
                select = 4'b1000;
        end
    end
    else if(opcode == 7'b0010011) begin
        alu_src = 1;
        reg_write = 1;
        if(funct3 == 3'b000)
            select = 4'b0000;
        else if(funct3 == 3'b100)
            select = 4'b0100;
        else if(funct3 == 3'b110)
            select = 4'b0011;
        else if(funct3 == 3'b111)
            select = 4'b0010;
        else if(funct3 == 3'b010)
            select = 4'b0101;
        else if(funct3 == 3'b001)
            select = 4'b0110;
        else if(funct3 == 3'b101) begin
            if(funct7 == 7'b0000000)
                select = 4'b0111;
            else if(funct7 == 7'b0100000)
                select = 4'b1000;
        end
    end
    else if(opcode == 7'b0000011) begin
        alu_src = 1;
        reg_write = 1;
        mem_read = 1;
        if(funct3 == 3'b010)
            select = 4'b0000;
    end
    else if(opcode == 7'b0100011) begin
        alu_src = 1;
        mem_write = 1;
        select = 4'b0000;
    end
    else if(opcode == 7'b1100011) begin
        alu_src = 0;
        select = 4'b0001;
        if(funct3 == 3'b000)
            beq = 1;
        else if(funct3 == 3'b001)
            bne = 1;
        else if(funct3 == 3'b100)
            blt = 1;
        else if(funct3 == 3'b101)
            bge = 1;
    end
    else if(opcode == 7'b1101111) begin
        jal = 1;
        reg_write = 1;
    end
    else if(opcode == 7'b1100111) begin
        jalr = 1;
        alu_src = 1;
        reg_write = 1;
        select = 4'b0000;
    end
    else if(opcode == 7'b0110111) begin
        lui = 1;
        reg_write = 1;
    end
    else if(opcode == 7'b0010111) begin
        auipc = 1;
        reg_write = 1;
    end
end
endmodule