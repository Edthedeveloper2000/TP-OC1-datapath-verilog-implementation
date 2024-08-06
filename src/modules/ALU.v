module ALU (
    input wire [31:0] a, b,
    input wire [3:0] alu_control,
    output reg [31:0] result,
    output wire zero
);
    always @(*) begin
        case (alu_control)
            4'b0000: result = a + b;  // add
            4'b0001: result = a | b;  // or
            4'b0010: result = a & b;  // andi
            4'b0011: result = a << b; // sll
            4'b0100: result = (a != b) ? 1 : 0; // bne (branch if not equal)
            default: result = 0;
        endcase
    end

    assign zero = (result == 0);
endmodule

