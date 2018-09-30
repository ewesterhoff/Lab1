// Testbench for modules except Add/Sub and SLT
`timescale 1 ns / 1 ps
`include "n_and_or_xor.v"

module testNANDmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] nab;

	NANDmod nAnd(.a(a), .b(b), .nab(nab), .uselessCommand(useless));

	initial begin
	$display("A     B     | NAB");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | %b", a, b, nab);
	end 

endmodule

