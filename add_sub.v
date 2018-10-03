// Adder circuit
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50
//`define n 5

module mux
(
    output[31:0] out,
    input[2:0] command,
    input[31:0] resultBus[7:0]
  );
  wire[31:0] m0, m1, m2, m3, m4, m5, m6, m7;
	wire[2:0] ncommand;

  `NOT invA(ncommand[0], command[0]);
  `NOT invB(ncommand[1], command[1]);
  `NOT invC(ncommand[2], command[2]);

  //requires zero padding
  //assign result = { 16{a[15]}, a };
  //module SignExtension(a, result);

// input [15:0] a; // 16-bit input
// output [31:0] result; // 32-bit output
//
// assign result = { 16{a[31]}, a };
//
// endmodule
  `AND andgateA(m0,resultBus[0],ncommand[0],ncommand[1], ncommand[2]);
  `AND andgateB(m1,resultBus[0],command[0],ncommand[1], ncommand[2]);
  `AND andgateC(m2,resultBus[0],ncommand[0],command[1], ncommand[2]);
  `AND andgateD(m3,resultBus[0],command[0],command[1], ncommand[2]);
  `AND andgateE(m4,resultBus[0],ncommand[0],ncommand[1], command[2]);
  `AND andgateF(m5,resultBus[0],command[0],ncommand[1], command[2]);
  `AND andgateG(m6,resultBus[0],ncommand[0],command[1], command[2]);
  `AND andgateH(m7,resultBus[0],command[0],command[1], command[2]);

  `OR orgate(out,m0,m1,m2,m3,m4,m5,m6,m7);
  endmodule

module structuralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire axorb, ab, caxorb;
    `XOR AXORB(axorb, a, b);
    `AND AANDB(ab, a, b);
    `XOR SUM(sum, carryin, axorb);
    `AND CAXORB(caxorb, carryin, axorb);
    `OR  CARRYOUT(carryout, caxorb, ab);
endmodule

module AddSubN #( parameter n = 31 )
(
    output[n:0] sum,  // 2's complement sum of a and b
    output carryout,  // Carry out of the summation of a and b
    output zero,
    output overflow,  // True if the calculation resulted in an overflow
    input[n:0] a,     // First operand in 2's complement format
    input[n:0] b,      // Second operand in 2's complement format
    input subtract
);
    wire atest, btest;
    wire cout[n+1:0];
    wire[n:0] bsub;

    genvar m;
    generate for (m = 0; m < n+1; m = m + 1) begin
        `XOR SUBTEST(bsub[m], b[m], subtract);
    end endgenerate

    assign cout[0] = subtract;

    genvar i;
    generate for (i = 0; i < n+1; i = i + 1) begin
        structuralFullAdder adder(sum[i], cout[i+1], a[i], bsub[i], cout[i]);
    end endgenerate

    assign carryout = cout[n+1];
    assign zero = 0;

    // Determine overflow based on most significant bit.
    // Overflow occurrs when a[3]=b[3]=0 and sum[3]=1. OR a[3]=b[3]=1 and sum[3]=0
    `XOR ATEST(atest, sum[n], a[n]);
    `XOR BTEST(btest, sum[n], bsub[n]);
    `AND OVERFLOW(overflow, atest, btest);
    // shorter overflow calculation?
endmodule

module SLTmod #( parameter n = 31 )
(
    output[31:0] slt,
    output carryout,
    output zero,
    output overflow,
    input[n:0] a, b,
    input uselessCommand
);
    wire[n:0] sub;
    wire overflow0, carryout0;
    assign zero = 0;

    AddSubN adder (sub, carryout0, zero, overflow0, a, b, 1'b1);

    `XOR SLTXOR(slt[0], sub[n], overflow0);
    assign slt[31:1] = 0;

    assign carryout = 0;
    assign overflow = 0;
endmodule
