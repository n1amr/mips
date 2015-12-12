module Adder(a, b, result);
  input [31:0] a, b;
  output reg [31:0] result;

  always @ (a or b) begin
    result <= a + b;
  end
endmodule

module Adder_testbench();
  reg [31:0] a, b;
  wire [31:0] result;

  Adder adder(a, b, result);

  initial begin
    a <= 4;
    b <= 1;
    #5 b = 4;
    #5 b = 8;
    #5 a = -4;
  end
endmodule
