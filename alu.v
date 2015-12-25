module ALU (a, b, alu_control, shamt, result, zero);
  input [31:0] a, b;
  input [3:0] alu_control;
  input [4:0] shamt;
  output wire [31:0] result;
  output wire zero;
  
  reg [31:0] tmp;

  assign #100 result = tmp;
  assign #10 zero = (result == 32'b0)? 1 : 0;
  
  parameter [3:0]
    ADD = 4'b0010,
    SUB = 4'b0110,
    SLL = 4'b0011,
    AND = 4'b0000,
    NOR = 4'b1100,
    SLT = 4'b0111,
    OR = 4'b0001;

  always @ (a, b, alu_control, shamt) begin
    case(alu_control)
      ADD:
        tmp <= a + b;
      SUB:
        tmp <= a - b;
      SLL:
        tmp <= (a << shamt);
      AND:
        tmp <= a & b;
      NOR:
        tmp <= ~(a | b);
      SLT:
        tmp <= (a < b)? 32'b1 : 32'b0;
      OR:
        tmp <=  a | b;
    endcase
  end
endmodule

module ALU_testbench();
  reg [31:0] a, b;
  reg [3:0] alu_control;
  reg [4:0] shamt;
  wire [31:0] result;
  wire zero;

  parameter [3:0]
    ADD = 4'b0010,
    SUB = 4'b0110,
    SLL = 4'b0011,
    AND = 4'b0000,
    NOR = 4'b1100,
    SLT = 4'b0111,
    OR = 4'b0001;

  ALU alu(a, b, alu_control, shamt, result, zero);

  initial begin
    a <= 4;
    b <= 1;

    #5 alu_control = ADD;
    #5 alu_control = SUB;
    #5 alu_control = AND;
    #5 alu_control = NOR;
    #5 alu_control = SLT;
    #5 alu_control = OR;
    
    #5 alu_control = SLL;
    #5 shamt = 5'd3;
    #5 shamt = 5'd4;
    #5 shamt = 5'd5;
  end

  initial begin
    $dumpfile("ALU_testbench.vcd");
    $dumpvars(0, ALU_testbench);
  end
endmodule
