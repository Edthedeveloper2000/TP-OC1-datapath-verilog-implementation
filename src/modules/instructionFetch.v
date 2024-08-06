module InstructionFetch (
    input clk,
    input reset,
    output reg [31:0] pc,
    output reg [31:0] instruction
);
    reg [31:0] memory [0:31]; // Define the memory array

    // Load memory from file
    initial begin
        $readmemh("src/modules/instructions.hex", memory);
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
        end else begin
            instruction <= memory[pc >> 2]; // Adjust for instruction memory alignment
            pc <= pc + 4;
        end
    end
endmodule
