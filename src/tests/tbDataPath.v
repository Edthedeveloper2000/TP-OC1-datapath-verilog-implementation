module tb_Datapath;
    reg clk;
    reg reset;

    Datapath uut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10 reset = 0;

        #200;
        $stop;
    end
endmodule
