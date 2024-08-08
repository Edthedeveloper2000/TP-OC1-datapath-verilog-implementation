`timescale 1ns / 1ps

module tb_program_counter;

    // Testbench signals
    reg clk;
    reg reset;
    reg [31:0] pc_next;
    reg pc_write;
    wire [31:0] pc;

    // Instantiate the Program Counter module
    program_counter uut (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_write(pc_write),
        .pc(pc)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period (100MHz)

    // Monitor setup
    initial begin
        // Log header with aligned columns
        $display("Time\tClk\tReset\tPcWrite\tPcNext\t\t\tPC");
        $display("--------------------------------------------------------------------");
        $monitor("%0t\t%b\t%b\t%b\t%h\t\t%h", $time, clk, reset, pc_write, pc_next, pc);
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        pc_next = 32'b0;
        pc_write = 0;

        // Wait for a few clock cycles
        #20;
        
        // Deassert reset and observe the PC
        reset = 0;
        #10;

        // Test 1: Write a value to the PC
        pc_next = 32'h0000_0004;
        pc_write = 1;
        #10;
        pc_write = 0;
        #10;

        // Test 2: Write another value to the PC
        pc_next = 32'h0000_0008;
        pc_write = 1;
        #10;
        pc_write = 0;
        #10;

        // Test 3: No write, PC should remain the same
        pc_next = 32'h0000_000C;
        pc_write = 0;
        #10;

        // Test 4: Reset the PC again
        reset = 1;
        #10;
        reset = 0;
        #10;

        // End of test
        $finish;
    end

endmodule
