// Adder circuit
`define AND and #30
`define AND4 and #50
`define OR or #30
`define XOR xor #100
`define NOT not #10
`define NAND nand #10
`define NOR nor #10
`define OR5 or #60

module structuralMultiplexer5
(
    output out,
    input[2:0] command,
    input in0, in1, in2, in3, in4
);
    wire[2:0] ncommand;
    wire m0,m1,m2,m3,m4;

    `NOT invA(ncommand[0], command[0]);
    `NOT invB(ncommand[1], command[1]);
    `NOT invC(ncommand[2], command[2]);

    `AND4 andgateA(m0,in0,ncommand[0],ncommand[1], ncommand[2]);
    `AND4 andgateB(m1,in1,command[0],ncommand[1], ncommand[2]);
    `AND4 andgateC(m2,in2,ncommand[0],command[1], ncommand[2]);
    `AND4 andgateD(m3,in3,command[0],command[1], ncommand[2]);
    `AND4 andgateE(m4,in4,ncommand[0],ncommand[1], command[2]);

    `OR5 orgate(out,m0,m1,m2,m3,m4);
endmodule

module structuralFullAdder
(
    output sum, carryout,
    input a, b,
    input carryin
);
    wire axorb, ab, caxorb;

    xor AXORB(axorb, a, b);
    `AND AANDB(ab, a, b);
    xor SUM(sum, carryin, axorb);
    `AND CAXORB(caxorb, carryin, axorb);
    `OR  CARRYOUT(carryout, caxorb, ab);
endmodule

module AddSubN
(
    output sum,  // 2's complement sum of a and b
    output carryout,  // Carry out of the summation of a and b
    output overflow,  // True if the calculation resulted in an overflow
    input a,     // First operand in 2's complement format
    input b,      // Second operand in 2's complement format
    input carryin,
    input subtract
);
    wire atest, btest;
    wire bsub;

    `XOR subtest(bsub, b, subtract);

    structuralFullAdder adder (sum, carryout, a, bsub, carryin);
endmodule

module SLTmod #( parameter n = 31 )
(
    output[n:0] slt,
    output carryout,
    output overflow,
    input[n:0] a, b
);
    wire[n:0] sub;
    wire carryout0;
    wire subtract;

    wire[32:0] carryin0;

    assign subtract = 1'b1;
    assign carryin0[0] = subtract;

   	genvar i;
   	generate for (i = 0; i < 32; i = i + 1) begin
   			AddSubN adder(.sum(sub[i]), .carryout(carryin0[i+1]), .a(a[i]), .b(b[i]), .carryin(carryin0[i]), .subtract(subtract));
     end
   	endgenerate

    //calculate overflow for adder; overflow if final carryout is not equal to carryin of most significant bit
    //used only to calculate SLT, not actual overflow output
  	`XOR OVERFLOW(over, carryin0[32], carryin0[31]);
    `XOR SLTXOR(slt[0], sub[n], over);

    assign slt[31:1] = 0;
    assign carryout = 0;
    assign overflow = 0;
endmodule

module XORmod
(
    output out,
    output carryout,
    output overflow,
    input a, b
);
    `XOR xorgate(out, a, b);
    assign carryout = 0;
    assign overflow = 0;
endmodule

module NANDmod
(
    output out,
    output carryout,
    output overflow,
    input a, b,
    input invert
);
    wire interim_out;
    `NAND nandgate(interim_out, a, b);
    `XOR xorgate(out, interim_out, invert);
    assign carryout = 0;
    assign overflow = 0;
endmodule

module NORmod
(
    output out,
    output carryout,
    output overflow,
    input a, b,
    input invert
);
    wire interim_out;
    `NOR norgate(interim_out, a, b);
    `XOR xorgate(out, interim_out, invert);
    assign carryout = 0;
    assign overflow = 0;
endmodule
