module ALU (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] alu_control,
    output reg [31:0] result,
    output reg zero
);

    always @(*) begin
        case (alu_control)
            3'b000: result = a + b;
            3'b001: result = a | b;
            3'b010: result = a & b;
            3'b011: result = a << b[4:0];
            3'b100: result = a - b;
            default: result = 32'b0;
        endcase

        zero = (result == 32'b0) ? 1'b1 : 1'b0;
    end

endmodule
