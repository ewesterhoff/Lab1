// ALU circuit
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

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
	wire
  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin AddSubN adder (result, carryout, overflow, operandA, operandB, 1'b0); end    
      `SUB:  begin AddSubN subber (result, carryout, overflow, operandA, operandB, 1'b1); end
      `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = ?; end    
      `SLT:  begin SLTMod SLTer (result, carryout, overflow, operandA, operandB, 1'b0); end
      `AND:  begin muxindex = 3; invertB=?; othercontrolsignal = ?; end    
      `NAND: begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
      `NOR:  begin muxindex = ?; invertB=?; othercontrolsignal = ?; end    
      `OR:   begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
    endcase
  end
endmodule

module structuralMultiplexer
(
    output out,
    output naddress0, naddress1,
    output out0, out1, out2, out3,
    input address0, address1,
    input in0, in1, in2, in3
);
    // Your multiplexer code here
    `NOT inv(naddress0, address0);
    `NOT inv(naddress1, address1);
    `AND andgate(out0, naddress0, naddress1, in0);
    `AND andgate(out1, address0, naddress1, in1);
    `AND andgate(out2, naddress0, address1, in2);
    `AND andgate(out3, address0, address1, in3);
    `OR  orgate(out, out0, out1, out2, out3);
endmodule

module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	invertB,
output reg	othercontrolsignal,
...
input[2:0]	ALUcommand
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin AddSubN adder (result, carryout, overflow, operandA, operandB, invertB=1'b0); end    
      `SUB:  begin AddSubN adder (result, carryout, overflow, operandA, operandB, invertB=1'b1); end
      `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = ?; end    
      `SLT:  begin SLTMod SLTer (result, carryout, overflow, operandA, operandB, invertB=1'b0); end
      `AND:  begin muxindex = 3; invertB=?; othercontrolsignal = ?; end    
      `NAND: begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
      `NOR:  begin muxindex = ?; invertB=?; othercontrolsignal = ?; end    
      `OR:   begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
    endcase
  end
endmodule