module pc (
    input clk,
    input rst,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);
    always@(posedge clk) begin
        pc_out <= (reset) ? 32'b0 : pc_in;
    end
endmodule