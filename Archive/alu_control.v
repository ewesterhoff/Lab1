// Adder circuit
`define AND and #50
`define OR or #50
`define XOR xor #50
//`define n 5

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

module AddSubN #( parameter n = 9 )
(
    output[n:0] sum,  // 2's complement sum of a and b
    output carryout,  // Carry out of the summation of a and b
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

    // Determine overflow based on most significant bit.
    // Overflow occurrs when a[3]=b[3]=0 and sum[3]=1. OR a[3]=b[3]=1 and sum[3]=0
    `XOR ATEST(atest, sum[n], a[n]);
    `XOR BTEST(btest, sum[n], bsub[n]);
    `AND OVERFLOW(overflow, atest, btest);
    // shorter overflow calculation?
endmodule

module SLTmod #( parameter n = 9 )
(
    output slt,
    output[n:0] sub,
    output overflow,
    input[n:0] a, b,
    input uselessCommand
);
    wire[n:0] sub;
    wire overflow, carryout;

    AddSubN adder (sub, carryout, overflow, a, b, 1'b1);

    `XOR SLTXOR(slt, sub[n], overflow);
endmodule
