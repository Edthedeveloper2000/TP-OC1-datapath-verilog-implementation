module DataPath (
    input wire clk,
    input wire reset,
    output wire [31:0] pc_current,
    output wire [31:0] instruction,
    output wire [31:0] alu_result,
    output wire zero_flag
);

    // Wires for connections
    wire [31:0] pc_next, pc_plus4, branch_target;
    wire [31:0] read_data1, read_data2, write_data;
    wire [31:0] alu_operand2, alu_operand1;
    wire [31:0] extImmediate;
    wire [31:0] data_memory_read;
    wire [2:0] alu_control;
    wire reg_write, alu_src, mem_write, mem_read;
    wire [1:0] alu_op, mem_size;
    wire pc_write, branch, mem_to_reg, pc_src;
    wire [4:0] rd, rs1, rs2;

    // Program Counter
    program_counter pc_module (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc(pc_current)
    );

    // Instruction Fetch
    InstructionFetch if_module (
        .clk(clk),
        .reset(reset),
        .pc(pc_current),
        .instruction(instruction)
    );

    // Register File
    RegisterFile rf_module (
        .clk(clk),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Immediate Generator
    immGen immGen_module (
        .clk(clk),
        .instruction(instruction),
        .extImmediate(extImmediate)
    );

    // ALU Control
    alu_control alu_control_module (
        .alu_op(alu_op),
        .funct3(instruction[14:12]),
        .alu_control(alu_control)
    );

    // ALU
    ALU alu_module (
        .a(read_data1),
        .b(alu_operand2),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero_flag)
    );

    // Adders
    add pc_plus_4 (
        .a(pc_current),
        .b(32'd4),
        .out(pc_plus4)
    );

    add branch_add (
        .a(pc_current),
        .b(extImmediate),
        .out(branch_target)
    );

    // Data Memory
    data_memory dm_module (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_size(mem_size),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(data_memory_read)
    );

    // Control Unit
    ControlUnit control_unit_module (
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );

    // Multiplexers
    mux alu_src_mux (
        .in0(read_data2),
        .in1(extImmediate),
        .sel(alu_src),
        .out(alu_operand2)
    );

    mux mem_to_reg_mux (
        .in0(alu_result),
        .in1(data_memory_read),
        .sel(mem_to_reg),
        .out(write_data)
    );

    mux pc_src_mux (
        .in0(pc_plus4),
        .in1(branch_target),
        .sel(pc_src),
        .out(pc_next)
    );

endmodule
