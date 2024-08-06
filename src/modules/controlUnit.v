module ControlUnit (
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg reg_write,
    output reg [3:0] alu_control
);
    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type instructions (add, or, sll)
                reg_write = 1;
                case ({funct7, funct3})
                    10'b0000000_000: alu_control = 4'b0000; // add
                    10'b0000000_110: alu_control = 4'b0001; // or
                    10'b0000000_001: alu_control = 4'b0011; // sll
                    default: alu_control = 4'b0000;
                endcase
            end
            7'b0010011: begin // I-type instructions (andi)
                reg_write = 1;
                case (funct3)
                    3'b111: alu_control = 4'b0010; // andi
                    default: alu_control = 4'b0000;
                endcase
            end
            7'b1100011: begin // B-type instructions (bne)
                reg_write = 0;
                case (funct3)
                    3'b001: alu_control = 4'b0100; // bne
                    default: alu_control = 4'b0000;
                endcase
            end
            7'b0100011: begin // S-type instructions (sh)
                reg_write = 0;
                alu_control = 4'b0000; // sh (use ALU for address calculation)
            end
            7'b0000011: begin // I-type instructions (lh)
                reg_write = 1;
                alu_control = 4'b0000; // lh (use ALU for address calculation)
            end
            default: begin
                reg_write = 0;
                alu_control = 4'b0000;
            end
        endcase
    end
endmodule