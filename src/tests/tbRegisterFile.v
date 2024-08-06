module tb_RegisterFile;
    reg clk;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] write_data;
    reg reg_write;
    wire [31:0] read_data1, read_data2;

    RegisterFile uut (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        reg_write = 0;

        // escreve no registrador 1
        #10 reg_write = 1;
        rd = 5'd1;
        write_data = 32'hDEADBEEF;

        //Lê do registrador 1
        #10 reg_write = 0;
        rs1 = 5'd1;

        // escreve no registrador 2
        #10 reg_write = 1;
        rd = 5'd2;
        write_data = 32'hCAFEBABE;

        //Lê do registrador 2
        #10 reg_write = 0;
        rs2 = 5'd2;

        #100;
        $stop;
    end
endmodule
