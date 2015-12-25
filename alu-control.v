module ALUControl(alucontrol, jr, sign, ALUOp, Funct);
  input [1:0] ALUOp;
  input [5:0] Funct;
  output wire [3:0] alucontrol;
  output wire jr, sign;
  
  reg [3:0] tmp;

  parameter [2:0]
    ADD = 2'b00,
    SUB = 2'b01,
    RFORMAT = 2'b10,
    AND = 2'b11;
  
  // Funct of R instructions
  parameter [5:0]
    ADD_FUNCT = 6'd32,
    SUB_FUNCT = 6'b100010,
    MUL_FUNCT = 6'b011000,
    AND_FUNCT = 6'd36,
    NOR_FUNCT = 6'd39,
    SLT_FUNCT = 6'd42,
    SLL_FUNCT = 6'd0,
    JR_FUNCT = 6'd8;
  
  // alu control signals
  parameter [3:0]
    ALU_ADD = 4'b0010,
    ALU_SUB = 4'b0110,
    ALU_SLL = 4'b0011,
    ALU_AND = 4'b0000,
    ALU_NOR = 4'b1100,
    ALU_SLT = 4'b0111,
    ALU_OR = 4'b0111,
    ALU_MUL = 4'b1111;

  assign #10 jr = (ALUOp == RFORMAT) && (Funct == JR_FUNCT);
  assign #10 sign = !(ALUOp == AND);
  assign #10 alucontrol = tmp;
  
  always @(ALUOp or Funct) begin
    case (ALUOp)
      ADD: begin
        tmp <= ALU_ADD;
      end

      SUB: begin
        tmp <= ALU_SUB;
      end

      RFORMAT: begin
        case(Funct)
          ADD_FUNCT: begin
            tmp <= ALU_ADD;
          end

          SUB_FUNCT: begin
            tmp <= ALU_SUB;
          end

          MUL_FUNCT: begin
            tmp <= ALU_MUL;
          end

          AND_FUNCT: begin
            tmp <= ALU_AND;
          end

          NOR_FUNCT: begin
            tmp <= ALU_NOR;
          end

          SLT_FUNCT: begin
            tmp <= ALU_SLT;
          end

          SLL_FUNCT: begin
            tmp <= ALU_SLL;
          end

          JR_FUNCT: begin
            tmp <= 2'bxx;
          end
        endcase
      end

      AND: begin
        tmp <= ALU_AND;
      end
    endcase
  end
endmodule

module ALUControl_testbench();
  reg [1:0] ALUOp;
  reg [5:0] Funct;
  wire [3:0] alucontrol;
  wire jr;
  
  ALUControl mALUControl(alucontrol, jr, sign, ALUOp, Funct);
  
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
    #10 ALUOp <= ADD;
    
    #10 ALUOp <= SUB;
    
    #10 ALUOp <= RFORMAT;
    #10 Funct <= ADD_FUNCT;
    #10 Funct <= AND_FUNCT;
    #10 Funct <= NOR_FUNCT;
    #10 Funct <= SLT_FUNCT;
    #10 Funct <= SLL_FUNCT;    
    
    #10 ALUOp <= AND;
    
    #10 $finish;    
  end
  
  // for sumulation
  initial begin
    $dumpfile("ALUControl_testbench.vcd");
    $dumpvars(0, ALUControl_testbench);
  end
endmodule
