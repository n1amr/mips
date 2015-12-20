module Control(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jal);
  input [5:0] opcode;
  output wire RegWrite, Branch, ALUSrc, MemRead, MemWrite, Jal;
  output wire [1:0] ALUOp, RegDst, MemtoReg;
  
  parameter [5:0]
    RFORMAT = 6'd0,
    ADDI = 6'd8,
    ANDI = 6'd12,
    LW = 6'd35,
    SW = 6'd43,
    BEQ = 6'd5,
    JAL = 6'd3;

  assign Jal = (opcode == JAL);
  assign Branch = (opcode == BEQ);
  assign MemRead = (opcode == LW);
  assign MemWrite = (opcode == SW);
  assign ALUSrc = (opcode == ADDI || opcode == ANDI || opcode == LW || opcode == SW);
  assign RegDst[1] = (opcode == JAL);
  assign RegDst[0] = (opcode == RFORMAT);
  assign MemtoReg[1] = (opcode == JAL);
  assign MemtoReg[0] = (opcode == LW);
  assign RegWrite = (opcode == RFORMAT || opcode == ADDI || opcode == ANDI || opcode == LW || opcode == JAL);
  assign ALUOp[1] = (opcode == RFORMAT || opcode == ANDI);
  assign ALUOp[0] = (opcode == ANDI || opcode == BEQ);

endmodule

module Control_testbench();
  reg [5:0] opcode;

  wire Branch, MemRead, MemWrite, ALUSrc, RegWrite;
  wire [1:0] ALUOp, RegDst, MemtoReg;

  Control control(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

  parameter [5:0]
    RFORMAT = 6'd0,
    ADDI = 6'd8,
    ANDI = 6'd12,
    LW = 6'd35,
    SW = 6'd43,
    BEQ = 6'd4,
    JAL = 6'd3;

  initial begin
    # 10 opcode = RFORMAT;
    # 10 opcode = ADDI;
    # 10 opcode = ANDI;
    # 10 opcode = LW;
    # 10 opcode = SW;
    # 10 opcode = BEQ;
    # 10 opcode = JAL;
    # 10 $finish;
  end

  initial begin
    $dumpfile("Control_testbench.vcd");
    $dumpvars(0, Control_testbench);
  end
endmodule

