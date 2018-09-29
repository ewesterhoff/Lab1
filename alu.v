// Adder circuit
`define AND and #50
`define OR or #50
`define NAND nand #50
`define NOR nor #50
`define XOR xor #50
`define NOT not #50

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
	// Your code here

endmodule