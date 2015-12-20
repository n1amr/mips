module ALUControl(alucontrol, ALUOp, Funct);
  input [1:0] ALUOp;
  input [5:0] Funct;
  output reg [3:0] alucontrol;
  
  parameter [2:0]
    ADD = 2'b00,
    SUB = 2'b01,
    RFORMAT = 2'b10,
    AND = 2'b11;
  
  // Funct of R instructions
  parameter [5:0]
    ADD_FUNCT = 6'd32,
    AND_FUNCT = 6'd36,
    NOR_FUNCT = 6'd39,
    SLT_FUNCT = 6'd42,
    SLL_FUNCT = 6'd0;
  
  // alu control signals
  parameter [3:0]
    ALU_ADD = 4'b0010,
    ALU_SUB = 4'b0110,
    ALU_SLL = 4'b0011,
    ALU_AND = 4'b0000,
    ALU_NOR = 4'b1100,
    ALU_SLT = 4'b0111,
    ALU_OR = 4'b0001;

  
  always @(ALUOp or Funct) begin 
    case (ALUOp)
      ADD: begin
        alucontrol <= ALU_ADD;
      end

      SUB: begin
        alucontrol <= ALU_SUB;
      end

      RFORMAT: begin
        case(Funct)
          ADD_FUNCT: begin
             alucontrol <= ALU_ADD;
          end

          AND_FUNCT: begin
            alucontrol <= ALU_AND;
          end

          NOR_FUNCT: begin
            alucontrol <= ALU_NOR;
          end

          SLT_FUNCT: begin
            alucontrol <= ALU_SLT;
          end

          SLL_FUNCT: begin
            alucontrol <= ALU_SLL;
          end
        endcase
      end

      AND: begin
        alucontrol <= ALU_AND;
      end
      endcase
    end
endmodule

module ALUControl_testbench();
  reg [5:0] ALUOp, Funct;
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
