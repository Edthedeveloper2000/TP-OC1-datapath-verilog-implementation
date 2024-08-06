module RegisterFile (
    input wire clk,
    input wire [4:0] rs1, rs2, rd,
    input wire [31:0] write_data,
    input wire reg_write,
    output wire [31:0] read_data1, read_data2
);
    reg [31:0] regfile [0:31];

    assign read_data1 = regfile[rs1];
    assign read_data2 = regfile[rs2];

    always @(posedge clk) begin
        if (reg_write) 
            regfile[rd] <= write_data;
    end
endmodule
