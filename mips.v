module MIPS;
  reg clk;
  initial begin
    clk <= 0;
    forever #500 clk <= ~clk;
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
  
  Decoder decoder_module(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);

  wire Branch, MemRead, MemWrite, ALUSrc, RegWrite;
  wire [1:0] ALUOp, RegDst, MemtoReg;
  Control control_module(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);


  wire [4:0] write_reg;
  wire [31:0] write_data;
  wire [31:0] read_data1, read_data2;

  Mux2_4b reg_dst_mux(write_reg, RegDst, rt, rd);
  RegisterFile register_file_module(rs, rt, write_reg, write_data, RegWrite, clk, read_data1, read_data2);



endmodule

module Mux2_4b(out, select, in0, in1);
  input select;
  input [4:0] in0, in1;
  output wire [4:0] out;

  assign out = select? in0 : in1;
endmodule

module Mux2_32b(out, select, in0, in1);
  input select;
  input [31:0] in0, in1;
  output wire [31:0] out;

  assign out = select == 0? in0 : in1;
endmodule

module Mux4_32b(out, select, in0, in1, in2, in3);
  input [2:0] select;
  input [31:0] in0, in1, in2, in3;
  output wire [31:0] out;

  assign out = select == 0? in0 :
                select == 1? in1 :
                select == 2? in2 :
                select == 3? in3 : 31'bx;
endmodule
