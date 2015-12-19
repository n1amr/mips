module Control(opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
  input [5:0] opcode;
  output reg Branch, MemRead, MemWrite, ALUSrc, RegWrite;
  output reg [1:0] ALUOp, RegDst, MemtoReg;
  
  always @(opcode) begin
    case (opcode)
      // Rformat
      6'b000000: begin
        RegDst <= 2'b01;
        ALUSrc <= 1'b0;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b10;
      end
      
      // addi              
      6'b001000: begin
        RegDst <= 2'b00;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b00;            
      end
      
      //andi
      6'b001100: begin
        RegDst <= 2'b00;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'b00;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b11;            
      end
      
      // lw 
      6'b100011: begin 
        RegDst <= 2'b00;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'b01;
        RegWrite <= 1'b1;
        MemRead <= 1'b1;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b00;
      end
    
      // sw
      6'b101011: begin
        RegDst <= 2'bxx;
        ALUSrc <= 1'b1;
        MemtoReg <= 2'bxx;
        RegWrite <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b1;
        Branch <= 1'b0;
        ALUOp <= 2'b00;
      end
    
      // beq
      6'b000100: begin
        RegDst <= 2'bxx;
        ALUSrc <= 1'b0;
        MemtoReg <= 2'bxx;
        RegWrite <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b1;
        ALUOp <= 2'b01;
      end
      
      // jal
      6'b000011: begin
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

  initial begin
    # 10 opcode = 6'd0; // Rformat
    # 10 opcode = 6'd8; // addi
    # 10 opcode = 6'd12; // andi
    # 10 opcode = 6'd35; // lw
    # 10 opcode = 6'd43; // sw
    # 10 opcode = 6'd4; // beq
    # 10 opcode = 6'd3; // jal
    # 10 $finish;
  end

  initial begin
    $dumpfile("Control_testbench.vcd");
    $dumpvars(0, Control_testbench);
  end
endmodule

