module Sign_extend (in , sign , out);
  input [15:0] in;
  input sign;
  output reg [31:0] out;
	
	always @ (sign or in) begin
    if (sign == 1'b0)  // to handle the "and" "andi" cases
     	out = {16'b0000_0000_0000_0000 , in};
    else if (sign == 1'b1)  // the other inst that need the sign extend
     	out = { {16{in[15]}}, in };
  end
endmodule

module SignExtend_testbench();
  reg [15:0] in;
  reg sign ;
  wire [31:0] out;

  Sign_extend try ( in , sign,out );

  initial begin
    in <= 16'b0000_0000_0000_0100;
    sign <= 0 ; 	
    #5 in <= 16'b 1000_1110_1111_0000;
    #5 sign <= 1;
    #5 in <= 16'b  1000_1110_1111_0000 ;
    #5 in <= 16'b0000_0000_0000_0100;
  end
endmodule
