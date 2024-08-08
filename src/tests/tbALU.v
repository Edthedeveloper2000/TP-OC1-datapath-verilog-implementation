`timescale 1ns / 1ps

module tb_alu;

    reg [31:0] a, b;
    reg [2:0] alu_control;
    wire [31:0] result;
    wire zero;

    ALU uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    initial begin
        $display("Time\tA\t\t\tB\t\tALUCtrl\tResult\tZero");
        $display("------------------------------------------------------------");
        $monitor("%0t\t%h\t%h\t%b\t%h\t%b", $time, a, b, alu_control, result, zero);
    end

    initial begin
        // Test 1: ADD
        a = 32'h00000003;
        b = 32'h00000002;
        alu_control = 3'b000; // ADD
        #10;

        // Test 2: OR
        a = 32'h00000003;
        b = 32'h00000002;
        alu_control = 3'b001; // OR
        #10;

        // Test 3: ANDI
        a = 32'h0000000F;
        b = 32'h00000003;
        alu_control = 3'b010; // ANDI
        #10;

        // Test 4: SLL
        a = 32'h00000001;
        b = 32'h00000002;
        alu_control = 3'b011; // SLL
        #10;

        // Test 5: SUB (BNE)
        a = 32'h00000005;
        b = 32'h00000005;
        alu_control = 3'b100; // SUB (BNE)
        #10;

        $finish;
    end

endmodule
