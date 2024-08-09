
module ALU (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] alu_control,
    output reg [31:0] result,
    output wire zero
);

    always @(*) begin
        case (alu_control)
            3'b000: result = a + b;              // Adição
            3'b001: result = a | b;              // OR
            3'b010: result = a & b;              // AND
            3'b011: result = a << b[4:0];        // Shift left lógico
            3'b100: result = a - b;              // Subtração
            default: result = 32'b0;             // Valor padrão para operações indefinidas
        endcase
    end

    // Zero flag para indicar resultado zero
    assign zero = (result == 32'b0);

endmodule

