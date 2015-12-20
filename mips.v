module MIPS;
  reg clk;
  initial begin
    clk <= 0;
    forever #100 clk <= ~clk;
  end

  wire [31:0] pc, next_pc;

  PC pc_module(.in(next_pc), .clk(clk), .out(pc));
  Adder adder_module(.a(pc), .b(4), .result(next_pc));
endmodule
