module immGen (
  input wire clk,
  input [31:0] instruction,
  output reg signed [31:0] extImmediate
);

  always @(posedge clk) begin
      case (instruction[6:0])
          7'b0000011: begin // lh (Load Halfword, I-type)
              extImmediate = {{21{instruction[31]}}, instruction[31:20]};
          end
          7'b0100011: begin // sh (Store Halfword, S-type)
              extImmediate = {{21{instruction[31]}}, instruction[31:25], instruction[11:7]};
          end
          7'b0010011: begin // andi (AND Immediate, I-type)
              extImmediate = {{21{instruction[31]}}, instruction[31:20]};
          end
          7'b1100011: begin // bne (Branch if Not Equal, B-type)
              extImmediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8]};
          end
          default: begin
              extImmediate = 32'b0; // Valor padrão, caso o opcode não seja reconhecido ou não precise de imediato
          end
      endcase
  end

endmodule
