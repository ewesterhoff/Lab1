// ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"

module testALU();
    reg  [31:0] operandA, operandB;
    reg  [2:0]  command;
    wire [31:0] result;
    wire carryout, zero, overflow;

/*

    module ALU
        (
        output[31:0]  result,
        output        carryout,
        output        zero,
        output        overflow,
        input[31:0]   operandA,
        input[31:0]   operandB,
        input[2:0]    command
        );

*/

    ALU aluer (result, carryout, zero, overflow, operandA, operandB, command);

    /* Example of if statement
        command=3'b110; #4000
        if(result != 32'b11111111111111111111111111150001) $display("NOR Test Failed - result: %b%b%b%b", result[3], result[2], result[1], result[0]);
        if(zero != 0) $display("ZERO FAILED - was not 0");
*/

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars();

        $display("Starting ADD tests");
        // ADD test 1
        command=`ADD; operandA=32'h000A0000; operandB=32'h00000070; #5000   // carryout = 0
        if(result != 32'h000A0070) $display("ADD test 1 failed - result: %h, expected: 000A0070", result);
        if(carryout != 1'b0) $display("ADD test 1 failed - carryout: %h, expected: 0", carryout);
        if(zero != 1'b0) $display("ADD test 1 failed - zero: %h, expected: 0", zero);
        if(overflow != 1'b0) $display("ADD test 1 failed - overflow: %h, expected: 0", overflow);
        // ADD test 2
        command=`ADD; operandA=32'h7FFFFFFF; operandB=32'h7FFFFFFF; #5000
        if(result != 32'hFFFFFFFE) $display("ADD test 2 failed - result: %h, expected: FFFFFFFE", result);
        if(carryout != 1'b0) $display("ADD test 2 failed - carryout: %h, expected: 0", carryout);
        if(zero != 1'b0) $display("ADD test 2 failed - zero: %h, expected: 0", zero);
        if(overflow != 1'b1) $display("ADD test 2 failed - overflow: %h, expected: 1", overflow);
        // ADD test 3
        command=`ADD; operandA=32'h00000001; operandB=32'hFFFFFFFF; #5000
        if(result != 32'h00000000) $display("ADD test 3 failed - result: %h, expected: 00000000", result);
        if(carryout != 1'b1) $display("ADD test 3 failed - carryout: %h, expected: 1", carryout);
        if(zero != 1'b1) $display("ADD test 3 failed - zero: %h, expected: 1", zero);
        if(overflow != 1'b0) $display("ADD test 3 failed - overflow: %h, expected: 0", overflow);
        // ADD test 4
        command=`ADD; operandA=32'h80000000; operandB=32'h80000000; #5000
        if(result != 32'h00000000) $display("ADD test 4 failed - result: %h, expected: 00000000", result);
        if(carryout != 1'b1) $display("ADD test 4 failed - carryout: %h, expected: 1", carryout);
        if(zero != 1'b1) $display("ADD test 4 failed - zero: %h, expected: 1", zero);
        if(overflow != 1'b1) $display("ADD test 4 failed - overflow: %h, expected: 1", overflow);

        $display("Starting SUB tests");
        // SUB test 1
        command=`SUB; operandA=32'h000A0000; operandB=32'h00000070; #5000
        if(result != 32'h0009FF90) $display("SUB test 1 failed - result: %h, expected: 0009FF90", result);
        if(carryout != 1'b0) $display("SUB test 1 failed - carryout: %h, expected: 0", carryout);
        if(zero != 1'b0) $display("SUB test 1 failed - zero: %h, expected: 0", zero);
        if(overflow != 1'b0) $display("SUB test 1 failed - overflow: %h, expected: 0", overflow);
        // SUB test 2
        command=`SUB; operandA=32'h7FFFFFFF; operandB=32'h80000001; #5000
        if(result != 32'hFFFFFFFE) $display("SUB test 2 failed - result: %h, expected: FFFFFFFE", result);
        if(carryout != 1'b0) $display("SUB test 2 failed - carryout: %h, expected: 0", carryout);
        if(zero != 1'b0) $display("SUB test 2 failed - zero: %h, expected: 0", zero);
        if(overflow != 1'b1) $display("SUB test 2 failed - overflow: %h, expected: 1", overflow);
        // SUB test 3
        command=`SUB; operandA=32'h00000001; operandB=32'h00000001; #5000
        if(result != 32'h00000000) $display("SUB test 3 failed - result: %h, expected: 00000000", result);
        if(carryout != 1'b1) $display("SUB test 3 failed - carryout: %h, expected: 1", carryout);
        if(zero != 1'b1) $display("SUB test 3 failed - zero: %h, expected: 1", zero);
        if(overflow != 1'b0) $display("SUB test 3 failed - overflow: %h, expected: 0", overflow);
        //SUB test 4
        command=`SUB; operandA=32'h80000000; operandB=32'h80000000; #5000
        if(result != 32'h00000000) $display("SUB test 4 failed - result: %h, expected: 00000000", result);
        if(carryout != 1'b1) $display("SUB test 4 failed - carryout: %h, expected: 1", carryout);
        if(zero != 1'b1) $display("SUB test 4 failed - zero: %h, expected: 1", zero);
        if(overflow != 1'b1) $display("SUB test 4 failed - overflow: %h, expected: 1", overflow);

        $display("Starting XOR tests");
        // XOR test 1
        command=`Xor; operandA=32'h88888888; operandB=32'h11111111; #5000
        if(result != 32'h99999999) $display("XOR test 1 failed - result: %h, expected: 99999999", result);
        if(zero != 1'b0) $display("XOR test 1 failed - zero: %h, expected: 0", zero);
        // XOR test 2
        command=`Xor; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #5000
        if(result != 32'h00000000) $display("XOR test 2 failed - result: %h, expected: 00000000", result);
        if(zero != 1'b1) $display("XOR test 2 failed - zero: %h, expected: 1", zero);
        // XOR test 3
        command=`Xor; operandA=32'hBBBBBBBB; operandB=32'h55555555; #5000
        if(result != 32'hEEEEEEEE) $display("XOR test 3 failed - result: %h, expected: EEEEEEEE", result);
        if(zero != 1'b0) $display("XOR test 3 failed - zero: %h, expected: 0", zero);

        $display("Starting SLT tests");
        // SLT test 1
        command=`SLT; operandA=32'h00000001; operandB=32'h05000000; #5000                                   //positive numbers
        if(result != 32'h00000001) $display("SLT test 1 failed - result: %h, expected: 00000001", result);
        // SLT test 2
        command=`SLT; operandA=32'h05000000; operandB=32'h00000001; #5000
        if(result != 32'h00000000) $display("SLT test 2 failed - result: %h, expected: 00000000", result);
        // SLT test 3
        command=`SLT; operandA=32'h80000000; operandB=32'hF0000000; #5000                                   //negative numbers
        if(result != 32'h00000001) $display("SLT test 3 failed - result: %h, expected: 00000001", result);
        // SLT test 4
        command=`SLT; operandA=32'hF0000000; operandB=32'h80000000; #5000
        if(result != 32'h00000000) $display("SLT test 4 failed - result: %h, expected: 00000000", result);
        // SLT test 5
        command=`SLT; operandA=32'h80000000; operandB=32'h05000000; #5000                                   //positive and negative numbers
        if(result != 32'h00000001) $display("SLT test 5 failed - result: %h, expected: 00000001", result);
        // SLT test 6
        command=`SLT; operandA=32'h05000000; operandB=32'h80000000; #5000
        if(result != 32'h00000000) $display("SLT test 6 failed - result: %h, expected: 00000000", result);
        // SLT test 7
        command=`SLT; operandA=32'h00000000; operandB=32'h00000000; #5000                                   //zeros
        if(result != 32'h00000000) $display("SLT test 7 failed - result: %h, expected: 00000000", result);

        $display("Starting AND tests");
        // AND test 1
        command=`And; operandA=32'h88888888; operandB=32'h11111111; #5000
        if(result != 32'h00000000) $display("AND test 1 failed - result: %h, expected: 00000000", result);
        if(zero != 1'b1) $display("AND test 1 failed - zero: %h, expected: 1", zero);
        // AND test 2
        command=`And; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #5000
        if(result != 32'hCCCCCCCC) $display("AND test 2 failed - result: %h, expected: CCCCCCCC", result);
        if(zero != 1'b0) $display("AND test 2 failed - zero: %h, expected: 0", zero);
        // AND test 3
        command=`And; operandA=32'hBBBBBBBB; operandB=32'h55555555; #5000
        if(result != 32'h11111111) $display("AND test 3 failed - result: %h, expected: 11111111", result);
        if(zero != 1'b0) $display("AND test 3 failed - zero: %h, expected: 0", zero);

        $display("Starting NAND tests");
        // NAND test 1
        command=`Nand; operandA=32'h88888888; operandB=32'h11111111; #5000
        if(result != 32'hFFFFFFFF) $display("NAND test 1 failed - result: %h, expected: FFFFFFFF", result);
        if(zero != 1'b0) $display("NAND test 1 failed - zero: %h, expected: 0", zero);
        // NAND test 2
        command=`Nand; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #5000
        if(result != 32'h33333333) $display("NAND test 2 failed - result: %h, expected: 33333333", result);
        if(zero != 1'b0) $display("NAND test 2 failed - zero: %h, expected: 0", zero);
        // NAND test 3
        command=`Nand; operandA=32'hBBBBBBBB; operandB=32'h55555555; #5000
        if(result != 32'hEEEEEEEE) $display("NAND test 3 failed - result: %h, expected: EEEEEEEE", result);
        if(zero != 1'b0) $display("NAND test 3 failed - zero: %h, expected: 0", zero);

        $display("Starting NOR tests");
        // NOR test 1
        command=`Nor; operandA=32'h88888888; operandB=32'h11111111; #5000
        if(result != 32'h99999999) $display("NOR test 1 failed - result: %h, expected: 99999999", result);
        if(zero != 1'b0) $display("NOR test 1 failed - zero: %h, expected: 0", zero);
        // NOR test 2
        command=`Nor; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #5000
        if(result != 32'hCCCCCCCC) $display("NOR test 2 failed - result: %h, expected: CCCCCCCC", result);
        if(zero != 1'b0) $display("NOR test 2 failed - zero: %h, expected: 0", zero);
        // NOR test 3
        command=`Nor; operandA=32'hBBBBBBBB; operandB=32'h55555555; #5000
        if(result != 32'hFFFFFFFF) $display("NOR test 3 failed - result: %h, expected: FFFFFFFF", result);
        if(zero != 1'b0) $display("NOR test 3 failed - zero: %h, expected: 0", zero);

        $display("Starting OR tests");
        // OR test 1
        command=`Or; operandA=32'h88888888; operandB=32'h11111111; #5000
        if(result != 32'h66666666) $display("OR test 1 failed - result: %h, expected: 66666666", result);
        if(zero != 1'b0) $display("OR test 1 failed - zero: %h, expected: 0", zero);
        // OR test 2
        command=`Or; operandA=32'hCCCCCCCC; operandB=32'hCCCCCCCC; #5000
        if(result != 32'h33333333) $display("OR test 2 failed - result: %h, expected: 33333333", result);
        if(zero != 1'b0) $display("OR test 2 failed - zero: %h, expected: 0", zero);
        // OR test 3
        command=`Or; operandA=32'hBBBBBBBB; operandB=32'h55555555; #5000
        if(result != 32'h00000000) $display("OR test 3 failed - result: %h, expected: 00000000", result);
        if(zero != 1'b1) $display("OR test 3 failed - zero: %h, expected: 1", zero);

        $display("Done");
        $finish();
    end
endmodule
