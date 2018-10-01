// ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"

module testALU();
    reg  [31:0] operandA, operandB;
    reg  [2:0]  command;
    wire [31:0] result;
    wire carryout, zero, overflow;

    ALU aluer (result, carryout, zero, overflow, operandA, operandB, command);

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars();
        $display(" A    B   Command | Result Cout Zero   Over  | Eresult Ecout Ezero   Eover");
        // ADD test
        command=`ADD; operandA=32'h000A0000; operandB=32'h00000070; #1000
        $display("%b %b %b |  %b   %b  $b %b    | 0  0   0   0", operandA, operandB, command, result, carryout, zero, overflow);
        command=`ADD; operandA=32'h7FFFFFFF; operandB=32'h7FFFFFFF; #1000
        command=`ADD; operandA=32'h00000001; operandB=32'hFFFFFFFF; #1000
        command=`ADD; operandA=32'h80000000; operandB=32'h80000000; #1000
        // SUB test
        command=`SUB; operandA=32'h000A0000; operandB=32'hFFFFFF81; #1000
        command=`SUB; operandA=32'h7FFFFFFF; operandB=32'h80000001; #1000
        command=`SUB; operandA=32'h00000001; operandB=32'h00000001; #1000
        command=`SUB; operandA=32'h80000000; operandB=32'h80000000; #1000
        // XOR test
        // command=`XOR; operandA=32'h88888888; operandB=32'h11111111; #1000
        // command=`XOR; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #1000
        // command=`XOR; operandA=32'hBBBBBBBB; operandB=32'h55555555; #1000
        // SLT test
        command=`SLT; operandA=32'h00000001; operandB=32'h01000000; #1000   //positive numbers
        command=`SLT; operandA=32'h01000000; operandB=32'h00000001; #1000
        command=`SLT; operandA=32'h80000000; operandB=32'hF0000000; #1000   //negative numbers
        command=`SLT; operandA=32'hF0000000; operandB=32'h80000000; #1000
        command=`SLT; operandA=32'h80000000; operandB=32'h01000000; #1000   //positive and negative numbers
        command=`SLT; operandA=32'h01000000; operandB=32'h80000000; #1000
        command=`SLT; operandA=32'h00000000; operandB=32'h00000000; #1000   //zero
        // AND test
        // command=`AND; operandA=32'h88888888; operandB=32'h11111111; #1000
        // command=`AND; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #1000
        // command=`AND; operandA=32'hBBBBBBBB; operandB=32'h55555555; #1000
        // // NAND test
        // command=`NAND; operandA=32'h88888888; operandB=32'h11111111; #1000
        // command=`NAND; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #1000
        // command=`NAND; operandA=32'hBBBBBBBB; operandB=32'h55555555; #1000
        // // NOR test
        // command=`NOR; operandA=32'h88888888; operandB=32'h11111111; #1000
        // command=`NOR; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #1000
        // command=`NOR; operandA=32'hBBBBBBBB; operandB=32'h55555555; #1000
        // // OR test
        // command=`OR; operandA=32'h88888888; operandB=32'h11111111; #1000
        // command=`OR; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #1000
        // command=`OR; operandA=32'hBBBBBBBB; operandB=32'h55555555; #1000
        $finish();
    end
endmodule
