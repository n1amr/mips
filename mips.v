module MIPS;
  reg clk;
  initial begin
    clk <= 0;
    forever #100 clk <= ~clk;
  end

  wire [31:0] pc, next_pc;

  PC pc_module(next_pc, clk, pc);
  Adder adder_module(pc, 4, next_pc);

  wire [31:0] instruction;
  InstructionMemory instruction_memory_module(pc, instruction);

  wire [5:0] opcode, funct;
  wire [4:0] rs, rt, rd, shamt;
  wire [15:0] shift;
  wire [25:0] jump_address;
  
  Decoder decoder(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);

  wire [4:0] write_reg;
  RegDstMux reg_dst_mux(write_reg, RegDst, rt, rd);

endmodule

module RegDstMux(out, RegDst, rt, rd);
  input RegDst;
  input [4:0] rt, rd;
  output wire [4:0] out;

  assign out = RegDst? rd : rt;
endmodule
