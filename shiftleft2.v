module ShiftLeft (in , out );
input  [31:0]in ;
output [31:0]out ;

assign out = in * 4 ;

endmodule
module shiftleft_testbench();
 reg [31:0]a;
 wire [31:0] b;

  ShiftLeft try (a, b);

  initial begin
    a <= 4;
    #5  a= 6;
    #5 a = 8;
    #5 a = 81;
    #5 a = -82;
  end
endmodule


