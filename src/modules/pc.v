module program_counter (
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    input wire [31:0] pc_next,  // Next PC value (input from branch logic)
    input wire pc_write,        // Control signal to update PC
    output reg [31:0] pc        // Current PC value
);

    // Initialize the PC with zero or some start address
    initial begin
        pc = 32'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;  // Reset the PC to zero
        end else if (pc_write) begin
            pc <= pc_next;  // Update the PC with the next value
        end
    end

endmodule
