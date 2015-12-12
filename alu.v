module ALU(a, b, alu_control, result, zero);
  input [31:0] a, b;
  input [1:0] alu_control;
  output reg [31:0] result;
  output reg zero;

  always @ (a or b or alu_control) begin
    case(alu_op)
      2'b00:
        result <= a + b;
      2'b01:
        result <= a - b;
      2'b10:
        result <= a & b;
      2'b11:
        result <= ~(a | b);
    endcase
  end
endmodule

module ALU_testbench();
  reg [31:0] a, b;
  wire [31:0] result;
  reg [1:0] alu_control;
  wire zero;

  ALU alu(a, b, alu_control, result, zero);

  initial begin
    a <= 1;
    b <= 3;

    alu_control <= 2'b00;
    #5 alu_control <= 2'b01;
    #5 alu_control <= 2'b10;
    #5 alu_control <= 2'b11;
  end
endmodule
