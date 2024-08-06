module InstructionFetch (
    input wire clk,
    input wire reset,
    output wire [31:0] instruction,
    output wire [31:0] pc
);
    reg [31:0] pc_reg;

    // Memoria de instrucao
    reg [31:0] instr_mem [0:255];

    assign pc = pc_reg;
    assign instruction = instr_mem[pc_reg >> 2];

    always @(posedge clk or posedge reset) begin
        if (reset) 
            pc_reg <= 0;
        else 
            pc_reg <= pc_reg + 4;
    end
endmodule
