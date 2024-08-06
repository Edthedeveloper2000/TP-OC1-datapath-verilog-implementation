module tb_ControlUnit;
    reg [6:0] opcode;
    wire reg_write;
    wire [3:0] alu_control;

    ControlUnit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );

    initial begin
        // ADD
        opcode = 7'b0110011;
        #10;

        // ANDI
        opcode = 7'b0010011;
        #10;

        // BNE
        opcode = 7'b1100011;
        #10;

        // SH
        opcode = 7'b0100011;
        #10;

        // LH
        opcode = 7'b0000011;
        #10;

        #100;
        $stop;
    end
endmodule
