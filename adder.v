module Adder(a, b, result);
  input [31:0] a, b;
  output  [31:0] result;

  
   assign result = a + b;
 
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
