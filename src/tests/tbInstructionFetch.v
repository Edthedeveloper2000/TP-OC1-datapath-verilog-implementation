module tb_InstructionFetch;
    reg clk;
    reg reset;
    wire [31:0] instruction;
    wire [31:0] pc;

    InstructionFetch uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        
        #10 reset = 0;

        #100;
        $stop;
    end
endmodule
