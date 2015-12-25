module MIPS;
  reg clk;
  initial begin
    clk <= 0;
    #350
    forever #350 clk <= ~clk;
  end

  wire [31:0] pc, next_pc, pc_plus_4;
  wire [31:0] instruction;
  wire [5:0] opcode, funct;
  wire [4:0] rs, rt, rd, shamt;
  wire [15:0] shift;
  wire [25:0] jump_address;
  wire Branch, Bne, MemRead, MemWrite, ALUSrc, RegWrite, Jump, MemDataSign;
  wire [1:0] RegDst, MemtoReg, MemDataSize;
  wire [2:0] ALUOp;
  wire SignExtend;
  wire [4:0] reg_file_write_reg;
  wire [31:0] reg_file_write_data;
  wire [31:0] reg_file_read_data1, reg_file_read_data2;
  wire [3:0] alu_control;
  wire [31:0] alu_input_b;
  wire [31:0] alu_output;
  wire alu_zero;
  wire [31:0] sign_extended_shift;
  wire [31:0] data_mem_output;
  wire [31:0] branch_offset;
  wire [31:0] taken_branch_pc;
  wire [31:0] branch_mux_pc;
  wire take_beq;
  wire take_bne;
  wire take_branch;
  wire RegWrite_unless_jr;
  wire not_jr;
  wire [31:0] jump_pc;
  wire [31:0] jump_mux_pc;

  assign jump_pc = {pc_plus_4[31], pc_plus_4[30], pc_plus_4[29], pc_plus_4[28], jump_address, 2'b00};
  and g1(take_beq, Branch, alu_zero);
  and g4(take_bne, Bne, !alu_zero);
  or g5(take_branch, take_beq, take_bne);
  not g2(not_jr, jr);
  and g3(RegWrite_unless_jr, RegWrite, not_jr);

  PC pc_module(next_pc, clk, pc);
  
  Adder adder_module(pc, 4, pc_plus_4);
  
  InstructionMemory instruction_memory_module(pc, instruction);
  
  Decoder decoder_module(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);
  
  Control control_module(opcode, RegDst, Branch, Bne, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, MemDataSize, MemDataSign, SignExtend);

  Mux4_5b reg_dst_mux(reg_file_write_reg, RegDst, rt, rd, 31, 4'bx);
  
  RegisterFile register_file_module(rs, rt, reg_file_write_reg, reg_file_write_data, RegWrite_unless_jr, clk, reg_file_read_data1, reg_file_read_data2);
  ALUControl alu_control_module(alu_control, jr, ALUOp, funct);

  Sign_extend sign_extend_module(shift, SignExtend,sign_extended_shift);

  Mux2_32b alu_src_mux(alu_input_b, ALUSrc, reg_file_read_data2, sign_extended_shift);
  
  ALU alu_module(reg_file_read_data1, alu_input_b, alu_control, shamt, alu_output, alu_zero);
  
  DataMemory data_memory_module(alu_output, reg_file_read_data2, MemRead, MemWrite, MemDataSize, MemDataSign, clk, data_mem_output);
  
  Mux4_32b mem_to_reg_mux(reg_file_write_data, MemtoReg, alu_output, data_mem_output, pc_plus_4, 32'bx);
  
  ShiftLeft2 shift_left_2_module(sign_extended_shift, branch_offset);
  
  Adder branch_adder_module(pc_plus_4, branch_offset, taken_branch_pc);

  Mux2_32b branch_mux(branch_mux_pc, take_branch, pc_plus_4, taken_branch_pc);
  
  Mux2_32b jump_mux(jump_mux_pc, Jump, branch_mux_pc, jump_pc);
  
  Mux2_32b jr_mux(next_pc, jr, jump_mux_pc, reg_file_read_data1);
endmodule

module Mux2_32b(out, select, in0, in1);
  input select;
  input [31:0] in0, in1;
  output wire [31:0] out;

  assign #10 out = select == 0? in0 : in1;
endmodule

module Mux4_32b(out, select, in0, in1, in2, in3);
  input [1:0] select;
  input [31:0] in0, in1, in2, in3;
  output wire [31:0] out;

  assign #10 out = (select == 2'd0)? in0 : (select == 2'd1)? in1 : (select == 2'd2)? in2 : (select == 2'd3)? in3 : 32'bx;
endmodule

module Mux4_5b(out, select, in0, in1, in2, in3);
  input [1:0] select;
  input [4:0] in0, in1, in2, in3;
  output wire [4:0] out;

  assign #10 out = (select == 2'd0)? in0 : (select == 2'd1)? in1 : (select == 2'd2)? in2 : (select == 2'd3)? in3 : 4'bx;
endmodule
