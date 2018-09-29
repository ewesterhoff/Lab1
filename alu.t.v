// ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"

module testALU();
    reg  [31:0] operandA, operandB;
    reg  [2:0]  command;
    wire [31:0] result;
    wire carryout, zero, overflow;

    ALU alu (result, carryout, zero, overflow, operandA, operandB, command);

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars();
        $display(" A    B   Command | Result Cout Zero   Over  | Eresult Ecout Ezero   Eover");
        // ADD test
        command=`ADD; operandA=32'h00000000; operandB=32'h00000000; #1000
        $display("%b %b %b |  %b   %b  $b %b    | 0  0   0   0", operandA, operandB, command, result, carryout, zero, overflow);
        // SUB test
        command=`SUB; operandA=32'h00000000; operandB=32'h00000000; #1000

        // XOR test
        command=`XOR; operandA=32'h00000000; operandB=32'h00000000; #1000

        // SLT test
        command=`SLT; operandA=32'h00000000; operandB=32'h00000000; #1000

        // AND test
        command=`AND; operandA=32'h00000000; operandB=32'h00000000; #1000

        // NAND test
        command=`NAND; operandA=32'h00000000; operandB=32'h00000000; #1000

        // NOR test
        command=`NOR; operandA=32'h00000000; operandB=32'h00000000; #1000

        // OR test
        command=`OR; operandA=32'h00000000; operandB=32'h00000000; #1000

        $finish();
    end
endmodule
