// Adder testbench
`timescale 1 ns / 1 ps
`include "add_sub.v"

module testFullAdder();
    reg [9:0] a, b;
    reg subtract;
    wire [9:0] sum, sub;
    wire carryout, overflow;
    wire slt;
    reg uselessCommand;

    //AddSubN adder (sum, carryout, overflow, a, b, subtract);
    SLTmod slter(slt, sub, overflow, a, b, uselessCommand);

    initial begin
      //  $display("A    B    | Cout Sum   Over  | Ecout Esum   Eover");
      //  a=10'b0100000000;b=10'b0000000001; subtract = 1; #1000
      //  $display("%b   %b   |  %b     %b    %b     | 0     000000   0", a, b, carryout, sum, overflow);

      $display("A    B   | SUB OVER | SLT | ESLT");
      a=10'b0000000000; b=10'b0111111111; uselessCommand = 0; #1000
      $display("%b    %b   | %b  %b | %b | 1", a, b, sub, overflow, slt);
    end
endmodule
