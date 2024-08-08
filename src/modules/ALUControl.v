module alu_control (
    input wire [1:0] alu_op,
    input wire [2:0] funct3,
    output reg [2:0] alu_control
);

    always @(*) begin
        case (alu_op)
            2'b00: alu_control = 3'b000; // ADD (lh, sh)
            2'b01: alu_control = 3'b100; // SUB (bne)
            2'b10: begin
                case (funct3)
                    3'b000: alu_control = 3'b000; // ADD
                    3'b110: alu_control = 3'b001; // OR
                    3'b111: alu_control = 3'b010; // ANDI
                    3'b001: alu_control = 3'b011; // SLL
                    default: alu_control = 3'b000; // ADD
                endcase
            end
            default: alu_control = 3'b000;
        endcase
    end

endmodule
