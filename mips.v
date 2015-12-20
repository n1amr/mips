module MIPS;
  reg clk;
  initial begin
    clk <= 0;
    forever #500 clk <= ~clk;
  end

  wire [31:0] pc, next_pc;
  wire [31:0] instruction;
  wire [5:0] opcode, funct;
  wire [4:0] rs, rt, rd, shamt;
  wire [15:0] shift;
  wire [25:0] jump_address;
  wire Branch, MemRead, MemWrite, ALUSrc, RegWrite;
  wire [1:0] ALUOp, RegDst, MemtoReg;
  wire [4:0] reg_file_write_reg;
  wire [31:0] reg_file_write_data;
  wire [31:0] reg_file_read_data1, reg_file_read_data2;
  wire [3:0] alu_control;
  wire [31:0] alu_input_b;
  wire [31:0] alu_output;
  wire alu_zero;
  wire [31:0] sign_extended_shift;
  wire [31:0] data_mem_output;

  PC pc_module(next_pc, clk, pc);

  Adder adder_module(pc, 4, next_pc);

  InstructionMemory instruction_memory_module(pc, instruction);

  Decoder decoder_module(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);

  Control control_module(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

  Mux2_4b reg_dst_mux(reg_file_write_reg, RegDst, rt, rd);

  RegisterFile register_file_module(rs, rt, reg_file_write_reg, reg_file_write_data, RegWrite, clk, reg_file_read_data1, reg_file_read_data2);

  ALUControl alu_control_module(alu_control, ALUOp, funct);

  Sign_extend sign_extend_module(shift, sign_extended_shift);

  Mux2_32b alu_src_mux(alu_input_b, ALUSrc, reg_file_read_data2, sign_extended_shift);

  ALU alu_module(reg_file_read_data1, alu_input_b, alu_control, shamt, alu_output, alu_zero);

  DataMemory data_memory_module(alu_output, reg_file_read_data2, MemRead, MemWrite, clk, data_mem_output);

  Mux4_32b mem_to_reg_mux(reg_file_write_data, MemtoReg, alu_output, data_mem_output, 32'bx, 32'bx);
  

endmodule

module Mux2_4b(out, select, in0, in1);
  input select;
  input [4:0] in0, in1;
  output wire [4:0] out;

  assign out = select == 0? in0 : in1;
endmodule

module Mux2_32b(out, select, in0, in1);
  input select;
  input [31:0] in0, in1;
  output wire [31:0] out;

  assign out = select == 0? in0 : in1;
endmodule

module Mux4_32b(out, select, in0, in1, in2, in3);
  input [1:0] select;
  input [31:0] in0, in1, in2, in3;
  output wire [31:0] out;

  assign out = (select == 2'd0)? in0 : (select == 2'd1)? in1 : (select == 2'd2)? in2 : (select == 2'd3)? in3 : 32'bx;
endmodule

module mintest;
  reg [1:0] ALUOp;
  reg [5:0] Funct;
  wire [3:0] alucontrol;

  ALUControl aluControl(alucontrol, ALUOp, Funct);
  
  parameter [2:0]
    ADD = 2'b00,
    SUB = 2'b01,
    RFORMAT = 2'b10,
    AND = 2'b11;
  
  parameter [5:0]
    ADD_FUNCT = 6'd32,
    AND_FUNCT = 6'd36,
    NOR_FUNCT = 6'd39,
    SLT_FUNCT = 6'd42,
    SLL_FUNCT = 6'd0;
  
  initial begin
     ALUOp <= 2'b00;
       Funct <= ADD_FUNCT;

  end
endmodule
