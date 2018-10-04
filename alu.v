// ALU circuit
`define ADD  3'd0
`define SUB  3'd1
`define Xor  3'd2
`define SLT  3'd3
`define And  3'd4
`define Nand 3'd5
`define Nor  3'd6
`define Or   3'd7
`include "alu_function.v"

module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);
	wire[31:0] out0, out1, out2, out3, out4;
	wire cout0, cin0, over0;
	wire cout1, over1, cout2, over2, cout3, over3, cout4, over4;
	wire invert;
	wire[2:0] muxindex;
	// Your code here

	ALUcontrolLUT lut(.muxindex(muxindex), .invert(invert), .ALUcommand(command));
  assign cin0 = invert;

	genvar i;
	generate for (i = 0; i < 31; i = i + 1) begin
			AddSubN adder(.sum(out0[i]), .carryout(cout0), .overflow(over0), .a(operandA[i]), .b(operandB[i]), .carryin(cin0), .subtract(invert));
			assign cout0 = cin0;

			XORmod xorer(.out(out1[i]), .carryout(cout1), .overflow(over1), .a(operandA[i]), .b(operandB[i]));

			SLTmod slter (.slt(out2[i]), .carryout(cout2), .overflow(over2), .a(operandA[i]), .b(operandB[i]));

			NANDmod nander(.out(out3[i]), .carryout(cout3), .overflow(over3), .a(operandA[i]), .b(operandB[i]), .invert(invert));

			NORmod norer(.out(out3[i]), .carryout(cout3), .overflow(over3), .a(operandA[i]), .b(operandB[i]), .invert(invert));
  end
	endgenerate

	genvar n;
	generate for (n = 0; n < 31; n = n + 1) begin
			structuralMultiplexer5 mux (.out(result[n]), .command(muxindex), .in0(out0[n]), .in1(out1[n]), .in2(out2[n]), .in3(out3[n]), .in4(out4[n]));
  end
	endgenerate

endmodule


module ALUcontrolLUT
(
output reg[2:0] muxindex,
output reg	invert,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invert=0; end
      `SUB:  begin muxindex = 0; invert=1; end
      `Xor:  begin muxindex = 1; invert=0; end
      `SLT:  begin muxindex = 2; invert=0; end
      `And:  begin muxindex = 3; invert=0; end
      `Nand: begin muxindex = 3; invert=1; end
      `Nor:  begin muxindex = 4; invert=0; end
      `Or:   begin muxindex = 4; invert=1; end
    endcase
  end
endmodule
