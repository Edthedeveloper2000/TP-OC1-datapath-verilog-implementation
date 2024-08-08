`timescale 1ns / 1ps

module add_tb;

    // Testbench signals
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] out;

    // Expected output
    reg [31:0] expected;

    // Instantiate the DUT (Device Under Test)
    add uut (
        .a(a), 
        .b(b), 
        .out(out)
    );

    initial begin
        // Test case 1: Add two small numbers
        a = 32'd5;
        b = 32'd10;
        expected = 32'd15;
        #10;
        if (out == expected)
            $display("Test 1 Passed: %d + %d = %d", a, b, out);
        else
            $display("Test 1 Failed: %d + %d = %d, Expected = %d", a, b, out, expected);

        // Test case 2: Add two larger numbers
        a = 32'd1000;
        b = 32'd2000;
        expected = 32'd3000;
        #10;
        if (out == expected)
            $display("Test 2 Passed: %d + %d = %d", a, b, out);
        else
            $display("Test 2 Failed: %d + %d = %d, Expected = %d", a, b, out, expected);

        // Test case 3: Add a small and a large number
        a = 32'd123456;
        b = 32'd789;
        expected = 32'd124245;
        #10;
        if (out == expected)
            $display("Test 3 Passed: %d + %d = %d", a, b, out);
        else
            $display("Test 3 Failed: %d + %d = %d, Expected = %d", a, b, out, expected);

        // Test case 4: Test with zeros
        a = 32'd0;
        b = 32'd0;
        expected = 32'd0;
        #10;
        if (out == expected)
            $display("Test 4 Passed: %d + %d = %d", a, b, out);
        else
            $display("Test 4 Failed: %d + %d = %d, Expected = %d", a, b, out, expected);

        // Test case 5: Test overflow (32-bit addition)
        a = 32'hFFFFFFFF;
        b = 32'd1;
        expected = 32'd0;  // Since 0xFFFFFFFF + 1 = 0x00000000 with overflow
        #10;
        if (out == expected)
            $display("Test 5 Passed: %h + %d = %h", a, b, out);
        else
            $display("Test 5 Failed: %h + %d = %h, Expected = %h", a, b, out, expected);

        // Finish simulation
        $finish;
    end
endmodule
