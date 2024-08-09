module data_memory (
    input wire clk,                     // Clock signal
    input wire mem_write,               // Memory write enable
    input wire mem_read,                // Memory read enable
    input wire [1:0] mem_size,          // Memory access size (00: byte, 01: halfword, 10: word)
    input wire [31:0] address,          // Memory address
    input wire [31:0] write_data,       // Data to be written to memory
    output reg [31:0] read_data         // Data read from memory
);

    reg [7:0] memory [0:255]; // Byte-addressable memory array (256 bytes)

    always @(posedge clk) begin
        if (mem_write) begin
            case (mem_size)
                2'b00: memory[address] = write_data[7:0];                      // Write byte
                2'b01: {memory[address + 1], memory[address]} = write_data[15:0]; // Write halfword
                2'b10: {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]} = write_data; // Write word
                default: ; // No operation
            endcase
        end
    end

    always @(posedge clk) begin
        if (mem_read) begin
            case (mem_size)
                2'b00: read_data = {{24{memory[address][7]}}, memory[address]};  // Read byte and sign-extend
                2'b01: read_data = {{16{memory[address + 1][7]}}, memory[address + 1], memory[address]}; // Read halfword and sign-extend
                2'b10: read_data = {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]}; // Read word
                default: read_data = 32'b0; // No operation
            endcase
        end else begin
            read_data = 32'b0; // Default to zero if mem_read is not asserted
        end
    end

endmodule
