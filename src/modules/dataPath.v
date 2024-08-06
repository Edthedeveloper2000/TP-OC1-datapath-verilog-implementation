module Datapath (
    input wire clk,
    input wire reset
);
    wire [31:0] instruction;
    wire [31:0] pc;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] read_data1, read_data2, write_data;
    wire [31:0] alu_result;
    wire [3:0] alu_control;
    wire reg_write;

    InstructionFetch IF (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .pc(pc)
    );

    RegisterFile RF (
        .clk(clk),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(alu_result),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    ALU ALU (
        .a(read_data1),
        .b(read_data2),
        .alu_control(alu_control),
        .result(alu_result)
    );

    ControlUnit CU (
        .opcode(instruction[6:0]),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );
endmodule
