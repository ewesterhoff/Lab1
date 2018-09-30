// Testbench for modules except Add/Sub and SLT
`timescale 1 ns / 1 ps
`include "n_and_or_xor.v"

/*
module testNANDmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] nab;

	NANDmod nAnd(.a(a), .b(b), .nab(nab), .uselessCommand(useless));

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

	ANDmod And(.a(a), .b(b), .ab(ab), .uselessCommand(useless));

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

	NORmod nOr(.a(a), .b(b), .naorb(naorb), .uselessCommand(useless));

	initial begin
	$display("A     B     | Exp  nAorB");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 00110 %b", a, b, naorb);
	end 

endmodule
*/

/*
module testORmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] aorb;

	ORmod nOr(.a(a), .b(b), .aorb(aorb), .uselessCommand(useless));

	initial begin
	$display("A     B     | Exp  AorB");
	a = 5'b11001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 11001 %b", a, b, aorb);
	end 

endmodule
*/


module testXORmod();
	reg [4:0] a, b;
	reg useless;
	wire [4:0] x_or;

	XORmod nOr(.a(a), .b(b), .x_or(x_or), .uselessCommand(useless));

	initial begin
	$display("A     B     | Exp  xAorB");
	a = 5'b10001; b = 5'b01001; useless = 0; #1000
	$display("%b %b | 11000 %b", a, b, x_or);
	end 

endmodule
