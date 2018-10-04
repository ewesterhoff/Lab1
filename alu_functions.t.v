// Adder testbench
`timescale 1 ns / 1 ps
`include "alu_function.v"

module testFullAdder();
    reg[1:0] a, b;
    reg carryin, subtract;
    wire[1:0] sum;
    wire carryout, overflow;
    wire[2:0] carryin0;

    assign carryin0[0] = carryin;

   	genvar i;
   	generate for (i = 0; i < 2; i = i + 1) begin
   			AddSubN adder(.sum(sum[i]), .carryout(carryin0[i+1]), .overflow(overflow), .a(a[i]), .b(b[i]), .carryin(carryin0[i]), .subtract(subtract));
     end
   	endgenerate

    assign carryout = carryin0[2];

    initial begin
    $display("A   B  Cin|  Sum Oflw Cyout| Expected Output");

    a=2'b00;b=2'b00;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 00 0 0", a, b, carryin, sum, overflow, carryout);
    a=2'b00;b=2'b01;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 01 0 0", a, b, carryin, sum, overflow, carryout);
    a=2'b00;b=2'b10;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 10 0 0", a, b, carryin, sum, overflow, carryout);
    a=2'b00;b=2'b11;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 11 0 0", a, b, carryin, sum, overflow, carryout);

    a=2'b01;b=2'b00;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 01 0 0", a, b, carryin, sum, overflow, carryout);
    a=2'b01;b=2'b01;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 10 1 0", a, b, carryin, sum, overflow, carryout);
    a=2'b01;b=2'b10;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 11 0 0 ", a, b, carryin, sum, overflow, carryout);
    a=2'b01;b=2'b11;carryin=0; subtract=0; #1000
    $display("%b  %b  %b |   %b  %b    %b   | 00 0 1 ", a, b, carryin, sum, overflow, carryout);

    end
endmodule
