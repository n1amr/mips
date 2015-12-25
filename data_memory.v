module DataMemory(address, write_data, MemRead, MemWrite, clk, read_data);
  input [31:0] address, write_data;
  input MemRead, MemWrite, clk;
  output wire [31:0] read_data;

  reg [7:0] mem [0:4096];

  assign #200 read_data = (MemRead)? {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} : 32'bz;
  
  always @ (posedge clk) begin
    if(MemWrite)
      #100 {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]}= write_data;
  end

  initial begin
    $readmemb("data-memory.mem", mem);
  end
endmodule

module DataMemory_testbench();
  reg [31:0] address, write_data;
  reg MemRead, MemWrite, clk;
  reg MemDataSign;
  reg [1:0] MemDataSize;
  wire [31:0] read_data;

  DataMemory mem(address, write_data, MemRead, MemWrite, MemDataSize, MemDataSign, clk, read_data);

  initial begin
    clk = 0;
    forever #500 clk = ~clk;
  end

  integer i;
  initial begin
    address = 16;
    MemRead = 1;
    MemWrite = 0;

    #200

    MemWrite = 1;
    MemRead = 1;
    address <= 4;
    write_data <= 32'h01234567;

    #200 $finish;
  end
endmodule
