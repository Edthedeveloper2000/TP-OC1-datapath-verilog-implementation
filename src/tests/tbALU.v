module tb_ALU;
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
        // ADD
        a = 32'h00000001;
        b = 32'h00000001;
        alu_control = 4'b0000;
        #10;

        // OR
        a = 32'h00000001;
        b = 32'h00000010;
        alu_control = 4'b0001;
        #10;

        // ANDI
        a = 32'h0000000F;
        b = 32'h00000001;
        alu_control = 4'b0010;
        #10;

        // SLL
        a = 32'h00000001;
        b = 32'h00000002;
        alu_control = 4'b0011;
        #10;

        #100;
        $stop;
    end
endmodule
