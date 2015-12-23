module Control(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, MemDataSize, MemDataSign);
  input [5:0] opcode;
  output wire RegWrite, Branch, ALUSrc, MemRead, MemWrite, Jump, MemDataSign;
  output wire [1:0] ALUOp, RegDst, MemtoReg, MemDataSize;
  
  parameter [5:0]
    RFORMAT = 6'd0,
    ADDI = 6'd8,
    ANDI = 6'd12,
    LW = 6'd35,
    LB = 6'b100000,
    LBU = 6'b100100,
    LH = 6'b100001,
    LHU = 6'b100101,
    SW = 6'd43,
    SB = 6'b101000,
    SH = 6'b101001,
    BEQ = 6'd5,
    JAL = 6'd3;

  wire LOAD = (opcode == LW || opcode == LB || opcode == LBU || opcode == LH || opcode == LHU);
  wire STORE = (opcode == SW || opcode == SB || opcode == SH);

  assign Jump = (opcode == JAL);
  assign Branch = (opcode == BEQ);
  assign MemRead = LOAD;
  assign MemWrite = STORE;
  assign ALUSrc = (opcode == ADDI || opcode == ANDI || LOAD || STORE);
  assign RegDst[1] = (opcode == JAL);
  assign RegDst[0] = (opcode == RFORMAT);
  assign MemtoReg[1] = (opcode == JAL);
  assign MemtoReg[0] = LOAD;
  assign RegWrite = (opcode == RFORMAT || opcode == ADDI || opcode == ANDI || LOAD || opcode == JAL);
  assign ALUOp[1] = (opcode == RFORMAT || opcode == ANDI);
  assign ALUOp[0] = (opcode == ANDI || opcode == BEQ);
  assign MemDataSign = (opcode == LW || opcode == LB || opcode == LH || opcode == SW || opcode == SB || opcode == SH);
  assign MemDataSize[1] = (opcode == LW || opcode == LH || opcode == LHU || opcode == SW || opcode == SH);
  assign MemDataSize[0] = (opcode == LW || opcode == LB || opcode == LBU || opcode == SW || opcode == SB);

endmodule

module Control_testbench();
  reg [5:0] opcode;
  wire RegWrite, Branch, ALUSrc, MemRead, MemWrite, Jump, MemDataSign;
  wire [1:0] ALUOp, RegDst, MemtoReg, MemDataSize;

  Control control(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, MemDataSize, MemDataSign);

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

