`timescale 1ns / 1ps

module tb_data_memory;

    reg clk;
    reg mem_write;
    reg mem_read;
    reg [1:0] mem_size;
    reg [31:0] address;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate the data memory module
    data_memory uut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_size(mem_size),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Monitor and display
    initial begin
        $display("Time\tClk\tMemWrite\tMemRead\tMemSize\tAddress\t\tWriteData\tReadData");
        $display("----------------------------------------------------------------------------");
        $monitor("%0t\t%b\t%b\t\t%b\t%b\t%h\t%h\t%h", $time, clk, mem_write, mem_read, mem_size, address, write_data, read_data);
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        mem_write = 0;
        mem_read = 0;
        mem_size = 2'b00;
        address = 32'b0;
        write_data = 32'b0;

        #10;
        // Test 1: Write a word to address 0
        mem_write = 1;
        mem_size = 2'b10;
        address = 32'h00000000;
        write_data = 32'hDEADBEEF;
        #10;

        // Test 2: Read the word from address 0
        mem_write = 0;
        mem_read = 1;
        #10;

        // Test 3: Write a halfword to address 2
        mem_read = 0;
        mem_write = 1;
        mem_size = 2'b01;
        address = 32'h00000002;
        write_data = 32'h0000BEEF;
        #10;

        // Test 4: Read the halfword from address 2
        mem_write = 0;
        mem_read = 1;
        #10;

        // Test 5: Write a byte to address 1
        mem_read = 0;
        mem_write = 1;
        mem_size = 2'b00;
        address = 32'h00000001;
        write_data = 32'h000000AA;
        #10;

        // Test 6: Read the byte from address 1
        mem_write = 0;
        mem_read = 1;
        #10;

        $finish;
    end

endmodule
