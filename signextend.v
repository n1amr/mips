module Sign_extend (in , out );
  input  [15:0]in ;
  output [31:0]out ;

  assign out = { {16{in[15]}}, in };
endmodule

module SignExtend_testbench();
  reg [15:0]a;
  wire [31:0] b;

  Sign_extend try (a, b);

  initial begin
    a <= 4;
    #5  a= 6;
    #5 a = 8;
    #5 a = 81;
    #5 a = -82;
  end
endmodule


