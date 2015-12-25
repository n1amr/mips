module Decoder(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);
  input  [31:0] instruction;
  output [5:0] opcode;
  output [4:0] rs;
  output [4:0] rt;
  output [4:0] rd;
  output [4:0] shamt;
  output [5:0] funct;
  output [15:0] shift;
  output [25:0] jump_address;

  assign #10 opcode = instruction[31:26];
  assign #10 rs = instruction[25:21];
  assign #10 rt = instruction[20:16];
  assign #10 rd = instruction[15:11];
  assign #10 shamt = instruction[10:6];
  assign #10 funct = instruction[5:0];
  assign #10 shift = instruction[15:0];
  assign #10 jump_address = instruction[25:0];
endmodule

module Decoder_testbench();
  reg  [31:0] instruction;
  wire [5:0] opcode;
  wire [4:0] rs;
  wire [4:0] rt;
  wire [4:0] rd;
  wire [4:0] shamt;
  wire [5:0] funct;
  wire [15:0] shift;
  wire [25:0] jump_address;

  Decoder decoder(instruction, opcode, rs, rt, rd, shamt, funct, shift, jump_address);

  initial begin
    instruction <= 32'b001000_00000_10001_0000000000000101;

    #5 instruction <= 32'b001000_00000_10001_0101000000000101;
    #5 instruction <= 32'b001000_11111_10001_0000000000000101;
    #5 instruction <= 32'b0010100_1100_10001_0000000000000101;
  end
endmodule
