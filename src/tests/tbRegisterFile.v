module tbRegisterFile;
    reg clk;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] write_data;
    reg reg_write;
    wire [31:0] read_data1, read_data2;

    // Instantiate the RegisterFile module
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

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rs1 = 5'b0;
        rs2 = 5'b0;
        rd = 5'b0;
        write_data = 32'h0;
        reg_write = 1;

        // Log header with aligned columns
        $display("Time\tClk\tRs1\tRs2\tRd\tWriteData\t\tRegWrite\tReadData1\t\tReadData2");
        $display("-------------------------------------------------------------------------------------");

        // Apply test vectors
        #10;
        rs1 = 5'd0;
        rs2 = 5'd3;
        rd = 5'd3;
        write_data = 32'hABCD1234;
        reg_write = 1;
        #10;

        reg_write = 0;
        #10

        #10;
        rs1 = 5'd3;
        rs2 = 5'd0;
        #10

         $monitor("At time %t: rs1 = %d, rs2 = %d, rd = %d, write_data = %h, reg_write = %b, read_data1 = %h, read_data2 = %h",
                 $time, rs1, rs2, rd, write_data, reg_write, read_data1, read_data2);

        #20;
        $finish;
    end

    initial begin
        $monitor("At time %t: rs1 = %d, rs2 = %d, rd = %d, write_data = %h, reg_write = %b, read_data1 = %h, read_data2 = %h",
                 $time, rs1, rs2, rd, write_data, reg_write, read_data1, read_data2);
    end
endmodule
