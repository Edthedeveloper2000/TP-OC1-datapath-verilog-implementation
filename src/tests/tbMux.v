module mux_tb;

    reg [31:0] in0;
    reg [31:0] in1;
    reg sel;
    wire [31:0] out;

    mux uut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Test case 1: sel = 0, out should be in0
        in0 = 32'hAAAAAAAA;
        in1 = 32'h55555555;
        sel = 0;
        #10;
        $display("Test case 1: sel = %b, out = %h (expected %h)", sel, out, in0);

        // Test case 2: sel = 1, out should be in1
        sel = 1;
        #10;
        $display("Test case 2: sel = %b, out = %h (expected %h)", sel, out, in1);

        // Test case 3: sel = 0, different values
        in0 = 32'h12345678;
        in1 = 32'h87654321;
        sel = 0;
        #10;
        $display("Test case 3: sel = %b, out = %h (expected %h)", sel, out, in0);

        // Test case 4: sel = 1, different values
        sel = 1;
        #10;
        $display("Test case 4: sel = %b, out = %h (expected %h)", sel, out, in1);

        $finish;
    end

endmodule
