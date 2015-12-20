module MIPS;
  reg clk;
  initial begin
    clk <= 0;
    forever #100 clk <= ~clk;
  end

  wire [31:0] pc, next_pc;

  PC pc_module(.in(next_pc), .clk(clk), .out(pc));
  Adder adder_module(.a(pc), .b(4), .result(next_pc));

  wire [31:0] instruction;
  InstructionMemory instruction_memory_module(.read_address(pc), .instruction(instruction));

  wire [6:0] opcode, funct;
  wire [5:0] rs, rt, rd, shamt;
  wire [15:0] shift;
  wire [25:0] jump_address;
  
  Decoder decoder(.instruction(instruction), .opcode(opcode), .rs(rs), .rt(rt), .rd(rd), .shamt(shamt), .funct(funct), .shift(shift), .jump_address(jump_address));


endmodule
