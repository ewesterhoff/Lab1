// ALU circuit
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7
`include "add_sub.v"
`include "n_and_or_xor.v"

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
	wire[31:0] resultBus[7:0];
	wire[0:0] carryoutBus[7:0];
	wire[0:0] zeroBus[7:0];
	wire[0:0] overflowBus[7:0];

	AddSubN adder (resultBus[0], carryoutBus[0], zeroBus[0], overflowBus[0], operandA, operandB, 1'b0);
	AddSubN subber (resultBus[1], carryoutBus[1], zeroBus[1], overflowBus[1], operandA, operandB, 1'b1);
	XORmod xorer (resultBus[2], carryoutBus[2], zeroBus[2], overflowBus[2], operandA, operandB, 1'b0);
	SLTmod slter (resultBus[3], carryoutBus[3], zeroBus[3], overflowBus[3], operandA, operandB, 1'b0);
	ANDmod ander (resultBus[4], carryoutBus[4], zeroBus[4], overflowBus[4], operandA, operandB, 1'b0);
	NANDmod nander (resultBus[5], carryoutBus[5], zeroBus[5], overflowBus[5], operandA, operandB, 1'b0);
	NORmod norer (resultBus[6], carryoutBus[6], zeroBus[6], overflowBus[6], operandA, operandB, 1'b0);
	ORmod orer (resultBus[7], carryoutBus[7], zeroBus[7], overflowBus[7], operandA, operandB, 1'b0);

	mux muxer (result, command, resultBus);

endmodule


// module ALUcontrolLUT
// (
// output reg[2:0] 	muxindex,
// output reg	invertB,
// output reg	othercontrolsignal,
// ...
// input[2:0]	ALUcommand
// )
//
//   always @(ALUcommand) begin
//     case (ALUcommand)
//       `ADD:  begin muxindex = 0; invertB=0; othercontrolsignal = ?; end
//       `SUB:  begin muxindex = 0; invertB=1; othercontrolsignal = ?; end
//       `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = ?; end
//       `SLT:  begin muxindex = 2; invertB=?; othercontrolsignal = ?; end
//       `AND:  begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
//       `NAND: begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
//       `NOR:  begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
//       `OR:   begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
//     endcase
//   end
// endmodule

// module structuralMultiplexer
// (
//     output[31:0]  result,
// 	output        carryout,
// 	output        zero,
// 	output        overflow,
//     input[2:0] command,
//     input[32:0] resultBus[7:0];
// 	input[0:0] carryoutBus[7:0];
// 	input[0:0] zeroBus[7:0];
// 	input[0:0] overflowBus[7:0];
// );
//     // Your multiplexer code here
//     wire[2:0] ncomm;
//     `NOT inv(ncomm[0], command[0]);
//     `NOT inv(ncomm[1], command[1]);
//     `NOT inv(ncomm[2], command[2]);
//
//     `AND andgate(out0, naddress0, naddress1, in0);
//     `AND andgate(out1, address0, naddress1, in1);
//     `AND andgate(out2, naddress0, address1, in2);
//     `AND andgate(out3, address0, address1, in3);
//     `OR  orgate(out, out0, out1, out2, out3);
// endmodule
