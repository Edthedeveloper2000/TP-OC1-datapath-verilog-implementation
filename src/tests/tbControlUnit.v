module ControlUnit_tb;

    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire reg_write;
    wire [3:0] alu_control;

    ControlUnit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );

    initial begin
        // Test ADD operation
        opcode = 7'b0110011; // R-type
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $display("ADD: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        // Test OR operation
        opcode = 7'b0110011; // R-type
        funct3 = 3'b110;
        funct7 = 7'b0000000;
        #10;
        $display("OR: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        // Test ANDI operation
        opcode = 7'b0010011; // I-type
        funct3 = 3'b111;
        funct7 = 7'b0000000; // ignored for I-type
        #10;
        $display("ANDI: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        // Test SLL operation
        opcode = 7'b0110011; // R-type
        funct3 = 3'b001;
        funct7 = 7'b0000000;
        #10;
        $display("SLL: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        // Test BNE operation
        opcode = 7'b1100011; // B-type
        funct3 = 3'b001;
        funct7 = 7'b0000000; // ignored for B-type
        #10;
        $display("BNE: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        // Test SH operation
        opcode = 7'b0100011; // S-type
        funct3 = 3'b010; // ignored for this test, since we don't use funct3
        funct7 = 7'b0000000; // ignored for S-type
        #10;
        $display("SH: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        // Test LH operation
        opcode = 7'b0000011; // I-type
        funct3 = 3'b001; // ignored for this test, since we don't use funct3
        funct7 = 7'b0000000; // ignored for I-type
        #10;
        $display("LH: opcode = %b, funct3 = %b, funct7 = %b, reg_write = %b, alu_control = %b", opcode, funct3, funct7, reg_write, alu_control);

        $finish;
    end

endmodule
