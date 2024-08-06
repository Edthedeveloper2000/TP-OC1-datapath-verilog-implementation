module RegisterFile (
    input wire clk,
    input wire [4:0] rs1, rs2, rd,
    input wire [31:0] write_data,
    input wire reg_write,
    output wire [31:0] read_data1, read_data2
);
    reg [31:0] regfile [0:31]; // 32 registers, each 32 bits wide

    // Read data from registers
    assign read_data1 = (rs1 != 5'b0) ? regfile[rs1] : 32'b0; // Return 0 if rs1 is 0
    assign read_data2 = (rs2 != 5'b0) ? regfile[rs2] : 32'b0; // Return 0 if rs2 is 0

    // Write data to register on rising edge of clock
    always @(posedge clk) begin
        if (reg_write && rd != 5'b0) // Ensure rd is not 0
            regfile[rd] <= write_data;
    end
endmodule
