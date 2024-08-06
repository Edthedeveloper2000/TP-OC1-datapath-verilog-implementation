module ALU_tb;

    reg [31:0] a, b;
    reg [3:0] alu_control;
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
        // Test ADD operation
        a = 32'd10;
        b = 32'd15;
        alu_control = 4'b0000; // add
        #10;
        $display("ADD: a = %d, b = %d, result = %d, zero = %b", a, b, result, zero);

        // Test OR operation
        a = 32'hFF00FF00;
        b = 32'h00FF00FF;
        alu_control = 4'b0001; // or
        #10;
        $display("OR: a = %h, b = %h, result = %h, zero = %b", a, b, result, zero);

        // Test OR operation with both operands as 0
        a = 32'h00000000;
        b = 32'h00000000;
        alu_control = 4'b0001; // or
        #10;
        $display("OR with zeros: a = %h, b = %h, result = %h, zero = %b", a, b, result, zero);

        // Test ANDI operation
        a = 32'hA5A5A5A5;
        b = 32'h5A5A5A5A;
        alu_control = 4'b0010; // andi
        #10;
        $display("ANDI: a = %h, b = %h, result = %h, zero = %b", a, b, result, zero);

        // Test SLL operation
        a = 32'd1;
        b = 32'd4;
        alu_control = 4'b0011; // sll
        #10;
        $display("SLL: a = %d, b = %d, result = %d, zero = %b", a, b, result, zero);

        // Test BNE operation (result should be 1 if a != b)
        a = 32'd20;
        b = 32'd25;
        alu_control = 4'b0100; // bne
        #10;
        $display("BNE: a = %d, b = %d, result = %d, zero = %b", a, b, result, zero);

        // Test BNE operation (result should be 0 if a == b)
        a = 32'd30;
        b = 32'd30;
        alu_control = 4'b0100; // bne
        #10;
        $display("BNE: a = %d, b = %d, result = %d, zero = %b", a, b, result, zero);

        $finish;
    end

endmodule