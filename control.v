module Control(opcode, RegDst, Branch, Bne, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, MemDataSize, MemDataSign, SignExtend);
  input [5:0] opcode;
  output wire RegWrite, Branch, Bne, ALUSrc, MemRead, MemWrite, Jump, MemDataSign, SignExtend;
  output wire [1:0] RegDst, MemtoReg, MemDataSize;
  output wire [2:0] ALUOp;
  
  parameter [5:0]
    RFORMAT = 6'd0,
    ADDI = 6'd8,
    ANDI = 6'd12,
    ORI = 6'b001101,
    LUI = 6'b001111,
    LW = 6'd35,
    LB = 6'b100000,
    LBU = 6'b100100,
    LH = 6'b100001,
    LHU = 6'b100101,
    SW = 6'd43,
    SB = 6'b101000,
    SH = 6'b101001,
    BEQ = 6'd5,
    BNE = 6'b000100,
    J = 6'b000010,
    JAL = 6'd3;

  wire LOAD = (opcode == LW || opcode == LB || opcode == LBU || opcode == LH || opcode == LHU);
  wire STORE = (opcode == SW || opcode == SB || opcode == SH);

  assign #10 Jump = (opcode == JAL);
  assign #10 Branch = (opcode == BEQ);
  assign #10 Bne = (opcode == BNE);
  assign #10 MemRead = LOAD;
  assign #10 MemWrite = STORE;
  assign #10 ALUSrc = (opcode == ADDI || opcode == ANDI || opcode == ORI || LOAD || STORE);
  assign #10 RegDst[1] = (opcode == JAL);
  assign #10 RegDst[0] = (opcode == RFORMAT);
  assign #10 MemtoReg[1] = (opcode == JAL || opcode == LUI);
  assign #10 MemtoReg[0] = LOAD || (opcode == LUI);
  assign #10 RegWrite = (opcode == RFORMAT || opcode == ADDI || opcode == ANDI || opcode == ORI || LOAD || opcode == JAL || opcode == LUI);
  assign #10 ALUOp[2] = (opcode == ORI);
  assign #10 ALUOp[1] = (opcode == RFORMAT || opcode == ANDI);
  assign #10 ALUOp[0] = (opcode == ANDI || opcode == BEQ);
  assign #10 MemDataSign = (opcode == LW || opcode == LB || opcode == LH || opcode == SW || opcode == SB || opcode == SH);
  assign #10 MemDataSize[1] = (opcode == LW || opcode == LH || opcode == LHU || opcode == SW || opcode == SH);
  assign #10 MemDataSize[0] = (opcode == LW || opcode == LB || opcode == LBU || opcode == SW || opcode == SB);
  assign #10 SignExtend = !(opcode == ANDI || opcode == ORI);

endmodule

module Control_testbench();
  reg [5:0] opcode;
  wire RegWrite, Branch, Bne, ALUSrc, MemRead, MemWrite, Jump, MemDataSign, SignExtend;
  wire [1:0] RegDst, MemtoReg, MemDataSize;
  wire [2:0] ALUOp;

  Control control(opcode, RegDst, Branch, Bne, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, MemDataSize, MemDataSign, SignExtend);

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

