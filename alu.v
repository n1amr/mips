module ALU(a, b, alu_control, shamt, result, zero);
  input [31:0] a, b;
  input [3:0] alu_control;
  input [4:0] shamt;
  output reg [31:0] result;
  output reg zero;

  parameter [3:0]
    ADD = 4'b0010,
    SUBTRACT = 4'b0110,
    AND = 4'b0000,
    NOR = 4'b0001,
    SLT = 4'b0111,
    SLL = 4'b1000;

  always @ (a or b or alu_control or shamt) begin
    case(alu_control)
      ADD:
        result <= a + b;
      SUBTRACT:
        result <= a - b;
      AND:
        result <= a & b;
      NOR:
        result <= ~(a | b);
      SLT:
        result <= a < b;
      SLL:
        result <= a << shamt;
    endcase
  end
endmodule

module ALU_testbench();
  reg [31:0] a, b;
  wire [31:0] result;
  reg [3:0] alu_control;
  reg [4:0] shamt;
  wire zero;

  parameter [3:0]
    ADD = 4'b0010,
    SUBTRACT = 4'b0110,
    AND = 4'b0000,
    NOR = 4'b0001,
    SLT = 4'b0111,
    SLL = 4'b1000;

  ALU alu(a, b, alu_control, shamt, result, zero);

  initial begin
    a <= 4;
    b <= 1;

    alu_control = ADD;
    #5 alu_control = SUBTRACT;
    #5 alu_control = AND;
    #5 alu_control = NOR;
    #5 alu_control = SLL;
    #5 shamt = 3;
    #5 shamt = 4;
    #5 shamt = 5;
  end
endmodule
