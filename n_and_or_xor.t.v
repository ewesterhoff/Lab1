// Testbench for modules except Add/Sub and SLT
`timescale 1 ns / 1 ps
`include "n_and_or_xor.v"

/*
module testNANDmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] nab;
	wire cout, ovf, z;

	NANDmod nAnd(.a(a), .b(b), .result(nab), .carryout(cout), .overflow(ovf), .zero(z));

	initial begin
	$display("A     B     | Exp nAB");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 10110 %b", a, b, nab);
	end 

endmodule
*/

/*
module testANDmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] ab;
	wire cout, ovf, z;

	ANDmod And(.a(a), .b(b), .result(ab), .carryout(cout), .overflow(ovf), .zero(z));

	initial begin
	$display("A     B     | Exp  AB");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 01001 %b", a, b, ab);
	end 

endmodule
*/

/*
module testNORmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] naorb;
	wire cout, ovf, z;

	NORmod nOr(.a(a), .b(b), .result(naorb), .carryout(cout), .overflow(ovf), .zero(z));

	initial begin
	$display("A     B     | Exp  nAorB");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 00110 %b", a, b, naorb);
	end 

endmodule
*/


module testORmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] aorb;
	wire cout, ovf, z;

	ORmod nOr(.a(a), .b(b), .result(aorb), .carryout(cout), .overflow(ovf), .zero(z));

	initial begin
	$display("A     B     | Exp   AorB  | Exp 0");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 11001 %b | %b %b %b", a, b, aorb, cout, ovf, z);
	end 

endmodule


/*
module testXORmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] x_or;
	wire cout, ovf, z;

	XORmod nOr(.a(a), .b(b), .result(x_or), .carryout(cout), .overflow(ovf), .zero(z));

	initial begin
	$display("A     B     | Exp  xAorB  | Exp 0");
	a = 5'b10001; b = 5'b01001; #1000
	$display("%b %b | 11000 %b | %b %b %b", a, b, x_or, cout ,ovf, z);
	end 

endmodule
*/