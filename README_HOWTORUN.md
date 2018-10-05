# Test Bench

To run the main test bench, type the following into the terminal.

```
$ iverilog -o alu alu.t.v
$ ./alu
```

To run GTKWave:

```
$ gtkwave alu.vcd
```

# Other Tests

To test the most recent 2-bit version of our adder, drag alu_functions.t.v from archive into the main folder and run:

```
$ iverilog -o alu_functions alu_functions.t.v
$ ./alu_functions
```

To test our original add/sub/SLT modules, run the following from archive:

```
$ iverilog -o add_sub add_sub.t.v
$ ./add_sub
```

To test our original xor/and/nand/nor/or modules, run the following from archive:

```
$ iverilog -o n_and_or_xor n_and_or_xor.t.v
$ ./n_and_or_xor
```
