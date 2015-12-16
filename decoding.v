module Decoding (in , opcode , rt , rs , rd , shamt , shift ,fn);
input  [31:0]in ;
output [5:0]opcode;  
output [4:0]rs  ;
output [4:0]rt ;
output [4:0]rd;
output [15:0]shift;
output [4:0]shamt ;
output [5:0]fn ;


assign opcode = in[31:26];
assign rs = in[25:21];
assign rt = in[20:16];
assign rd = in[15:11];
assign shamt = in[10:6] ;
assign fn = in[5:0];
assign shift = in[15:0];
endmodule
module Decoding_testbench();
  reg [31:0] x;
  wire[5:0]opcode ;  
wire [4:0]rs  ;
wire [4:0]rt ;
wire  [4:0]rd;
wire   [15:0]shift;
wire  [4:0]shamt ;
wire  [5:0]fn ;

Decoding decoding( x, opcode , rt , rs , rd , shamt , shift ,fn);
  initial begin
    x <= 32'b001000_00000_10001_0000000000000101;
    
    #5 x= 32'b001000_00000_10001_0101000000000101;
    #5 x= 32'b001000_11111_10001_0000000000000101;
    #5 x=32'b0010100_1100_10001_0000000000000101;
  end
endmodule