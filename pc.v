module PC(in, clk, out);
  input [31:0] in;
  input clk;
  output reg [31:0] out;

  always @ (posedge clk) begin
    out <= #10 in;
  end

  initial begin
    out = 32'h0000_0000;
  end
endmodule

module PC_testbench();
  reg [31:0] in;
  reg clk;
  wire [31:0] out;

  PC pc(in, clk, out);

  initial begin
    clk = 0;
    forever #50 clk = ~clk;
  end

  integer i;
  initial begin
    in = 32'h1010_1010;
    #100
    in = 32'h1010_1014;
    #100
    in = 32'h1010_ffff;
    
    #200 $finish;
  end

  initial begin
    $dumpfile("PC_testbench.vcd");
    $dumpvars(0, PC_testbench);
  end
endmodule
