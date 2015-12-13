module InstructionMemory(read_address, instruction);
  input [31:0] read_address;
  output [31:0] instruction;

  reg [7:0] mem [0:255];
  assign instruction = mem[read_address];

  integer i;

  // Initialize memory
  initial begin
    for(i = 0; i < 256; i = i + 1) begin
      mem[i] = 8'b0000_0000;
    end
  end
endmodule

module InstructionMemory_testbench();
  reg [31:0] read_address;
  wire [31:0] instruction;

  InstructionMemory mem(read_address, instruction);

  initial begin
    #5 read_address <= 0;
    #5 read_address <= 10;
    #5 read_address <= 2;
    #5 read_address <= 8;
  end
endmodule
