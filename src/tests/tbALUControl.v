`timescale 1ns / 1ps

module tb_alu_control;

    // Testbench signals
    reg [1:0] alu_op;
    reg [2:0] funct3;
    wire [2:0] alu_control;

    // Instantiate the ALU Control module
    alu_control uut (
        .alu_op(alu_op),
        .funct3(funct3),
        .alu_control(alu_control)
    );

    // Monitor setup
    initial begin
        // Log header with aligned columns
        $display("Time\tALUOp\tFunct3\tALUCtrl");
        $display("---------------------------------");
        $monitor("%0t\t%b\t%b\t%b", $time, alu_op, funct3, alu_control);
    end

    // Test procedure
    initial begin
        // Test 1: ALUOp for lh/sh (ADD operation)
        alu_op = 2'b00;
        funct3 = 3'b000; // ADD
        #10;

        // Test 2: ALUOp for BNE (SUB operation)
        alu_op = 2'b01;
        funct3 = 3'b000; // SUB for BNE
        #10;

        // Test 3: ALUOp for ADD operation
        alu_op = 2'b10;
        funct3 = 3'b000; // ADD
        #10;

        // Test 4: ALUOp for OR operation
        alu_op = 2'b10;
        funct3 = 3'b110; // OR
        #10;

        // Test 5: ALUOp for ANDI operation
        alu_op = 2'b10;
        funct3 = 3'b111; // ANDI
        #10;

        // Test 6: ALUOp for SLL operation
        alu_op = 2'b10;
        funct3 = 3'b001; // SLL
        #10;

        $finish;
    end

endmodule
