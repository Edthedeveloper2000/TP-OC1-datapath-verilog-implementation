module tbDataPath;

    reg clk;
    reg reset;
    wire [31:0] pc_current;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire zero_flag;

    // Instantiate the DataPath module
    DataPath uut (
        .clk(clk),
        .reset(reset),
        .pc_current(pc_current),
        .instruction(instruction),
        .alu_result(alu_result),
        .zero_flag(zero_flag)
    );

    // Generate clock signal
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Monitor output
        $monitor("Time = %0t | PC = %h | Instruction = %h | ALU Result = %h | Zero Flag = %b",
                 $time, pc_current, instruction, alu_result, zero_flag);

        // Reset the system
        #10 reset = 0;

        // Run for a specific time period (enough to observe a few instructions)
        #1000 $finish;  // Stop the simulation after 1000 time units
    end

endmodule
