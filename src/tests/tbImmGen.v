`timescale 1ns/1ps

module immGen_tb;

    // Entradas
    reg clk;
    reg [31:0] instruction;

    // Saída
    wire signed [31:0] extImmediate;

    // Instanciando o módulo que estamos testando
    immGen uut (
        .clk(clk),
        .instruction(instruction),
        .extImmediate(extImmediate)
    );

    // Geração do clock
    always begin
        #5 clk = ~clk; // Gera um clock com período de 10ns
    end

    // Testes
    initial begin
        // Inicialização do clock
        clk = 0;

        // Teste para a instrução 'lh'
        instruction = 32'b000000000001_00010_010_00011_0000011; // opcode = 0000011, imm[31:20] = 000000000001
        #10; // Espera por 10ns
        $display("Test lh: extImmediate = %d", extImmediate);

        // Teste para a instrução 'sh'
        instruction = 32'b0000001_00110_00101_010_00100_0100011; // opcode = 0100011, imm[31:25] = 0000001, imm[11:7] = 00100
        #10; // Espera por 10ns
        $display("Test sh: extImmediate = %d", extImmediate);

        // Teste para a instrução 'andi'
        instruction = 32'b000000000001_00010_111_00011_0010011; // opcode = 0010011, imm[31:20] = 000000000001
        #10; // Espera por 10ns
        $display("Test andi: extImmediate = %d", extImmediate);

        // Teste para a instrução 'bne'
        instruction = 32'b1_000001_00001_00010_001_0_0001_1100011; // opcode = 1100011, imm[31] = 1, imm[7] = 0, imm[30:25] = 000001, imm[11:8] = 0001
        #10; // Espera por 10ns
        $display("Test bne: extImmediate = %d", extImmediate);

        // Teste para a instrução 'add' (não deve modificar extImmediate)
        instruction = 32'b0000000_00010_00001_000_00011_0110011; // opcode = 0110011 (tipo R)
        #10; // Espera por 10ns
        $display("Test add (Tipo R, sem imediato): extImmediate = %d", extImmediate);

        // Teste para a instrução 'sll' (não deve modificar extImmediate)
        instruction = 32'b0000000_00010_00001_001_00011_0110011; // opcode = 0110011 (tipo R)
        #10; // Espera por 10ns
        $display("Test sll (Tipo R, sem imediato): extImmediate = %d", extImmediate);

        // Finalizando a simulação
        $finish;
    end

endmodule