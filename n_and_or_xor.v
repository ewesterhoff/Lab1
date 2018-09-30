// (N)AND, (N)OR, XOR circuit
`define NAND nand #10
`define NOR nor #10
`define NOT not #10

//------------------------------------------------------------------------------------------
// Basic one-bit gates
module nAnd
	(
	input a, 
	input b,
	output nab
		);

	`NAND nand1(nab, a, b);
endmodule

module And
	(	
	input a, 
	input b,
	output ab
		);
	wire nab;

	nAnd n_And(.a(a), .b(b), .nab(nab));
	`NOT not1(ab, nab);
endmodule	

module nOr
	(
	input a, 
	input b,
	output naorb
		);

	`NOR nor1(naorb, a, b);
endmodule

module Or
	(
	input a, 
	input b,
	output aorb
		);
	wire naorb;

	nOr n_Or(.a(a), .b(b), .naorb(naorb));
	`NOT not2(aorb, naorb);
endmodule

module xOr
	(
	input a, 
	input b,
	output x_or
		);
	wire nab;
	wire naorb;
	wire nab_and_aorb;

	nAnd n_And(.a(a), .b(b), .nab(nab));
	Or Or(.a(a), .b(b) , .aorb(aorb));

	`NAND nand1(nab_and_aorb, nab, aorb);
	`NOT not3(x_or, nab_and_aorb);
endmodule
// End basic one-bit gates
//------------------------------------------------------------------------------------------


// Forming n bit bitslices:
module NANDmod #( parameter n = 4)
	(
	input[n:0] a,
	input[n:0] b,
	input uselessCommand,
	output[n:0] nab
		);

	genvar m;
	generate for (m = 0; m < n + 1; m = m + 1) begin
		nAnd form_nAnd(.a(a[m]), .b(b[m]), .nab(nab[m]));
	end endgenerate
endmodule 

module ANDmod # (parameter n = 4)
	(
	input[n:0] a,
	input[n:0] b,
	input uselessCommand,
	output[n:0] ab
		);

	genvar m;
	generate for (m = 0; m < n + 1; m = m + 1) begin
		And form_And(.a(a[m]), .b(b[m]), .ab(ab[m]));
	end endgenerate
endmodule

module NORmod # (parameter n = 4)
	(
	input[n:0] a,
	input[n:0] b,
	input uselessCommand,
	output[n:0] naorb
		);

	genvar m;
	generate for (m = 0; m < n + 1; m = m + 1) begin
		nOr form_nOr(.a(a[m]), .b(b[m]), .naorb(naorb[m]));
	end endgenerate
endmodule

module ORmod # (parameter n = 4)
	(
	input[n:0] a,
	input[n:0] b,
	input uselessCommand,
	output[n:0] aorb
		);

	genvar m;
	generate for (m = 0; m < n + 1; m = m + 1) begin
		Or form_Or(.a(a[m]), .b(b[m]), .aorb(aorb[m]));
	end endgenerate
endmodule


module XORmod # (parameter n = 4)
	(
	input[n:0] a,
	input[n:0] b, 
	input uselessCommand, 
	output[n:0] x_or
		);
		
	genvar m;
	generate for (m = 0; m < n + 1; m = m + 1) begin
		xOr form_xOr(.a(a[m]), .b(b[m]), .x_or(x_or[m]));
	end endgenerate
endmodule


