module Control(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
  input [5:0] opcode;
  output reg Branch, MemRead, MemWrite, ALUSrc, RegWrite;
  output reg [1:0] ALUOp, RegDst, MemtoReg;
  
  parameter [5:0]
    RFORMAT = 6'd0,
    ADDI = 6'd8,
    ANDI = 6'd12,
    LW = 6'd35,
    SW = 6'd43,
    BEQ = 6'd4,
    JAL = 6'd3;


  always @(opcode) begin
    case (opcode)
      RFORMAT: begin
        RegDst <= 2'b01;
        ALUSrc <= 1'b0;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b10;
      end
      
      ADDI: begin
        RegDst <= 2'b00;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b00;            
      end
      
      ANDI: begin
        RegDst <= 2'b00;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b11;            
      end
      
      LW: begin 
        RegDst <= 2'b00;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'b01;
        RegWrite <= 1'b1;
        MemRead <= 1'b1;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b00;
      end
    
      SW: begin
        RegDst <= 2'bxx;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'bxx;
        RegWrite <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b1;
        Branch <= 1'b0;
        ALUOp <= 2'b00;
      end
    
      BEQ: begin
        RegDst <= 2'bxx;
        ALUSrc <= 1'b0;
        MemtoReg <= 2'bxx;
        RegWrite <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b1;
        ALUOp <= 2'b01;
      end
      
      JAL: begin
        RegDst <= 2'b10;
        ALUSrc <= 1'bx;
        MemtoReg <= 2'b10;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'bxx;
      end
    endcase
  end
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

