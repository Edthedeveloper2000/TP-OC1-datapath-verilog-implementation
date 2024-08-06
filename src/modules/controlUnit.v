module ControlUnit (
    input wire [6:0] opcode,
    output reg reg_write,
    output reg [3:0] alu_control
);
    always @(*) begin
        case (opcode)
            7'b0110011: begin
                reg_write = 1;
                alu_control = 4'b0000; // add
            end
            7'b0010011: begin
                reg_write = 1;
                alu_control = 4'b0010; // andi
            end
            7'b1100011: begin
                reg_write = 0;
                alu_control = 4'b1111; // bne
            end
            7'b0100011: begin
                reg_write = 0;
                alu_control = 4'b0000; // sh
            end
            7'b0000011: begin load
                reg_write = 1;
                alu_control = 4'b0000; // lh
            end
            default: begin
                reg_write = 0;
                alu_control = 4'b0000;
            end
        endcase
    end
endmodule
