module DataMemory(address, write_data, MemRead, MemWrite, clk, read_data);
  input [31:0] address, write_data;
  input MemRead, MemWrite, clk;
  output reg [31:0] read_data;

  reg [31:0] mem [0:255];

  always @ (MemRead or address or mem[address]) begin
    #100 read_data = mem[address >> 2];
  end

  always @ (negedge clk) begin
    if(MemWrite) begin
      #100 mem[address >> 2] = write_data;
    end
  end

  initial begin
    $readmemb("data-memory.mem", mem);
  end
endmodule

module DataMemory_testbench();
  reg [31:0] address, write_data;
  reg MemRead, MemWrite, clk;
  wire [31:0] read_data;

  DataMemory mem(address, write_data, MemRead, MemWrite, clk, read_data);

  initial begin
    clk = 0;
    forever #50 clk = ~clk;
  end

  integer i;
  initial begin
    MemRead <= 0;
    MemWrite <= 1;
    address <= 4;
    write_data <= 32'hffffffff;

    #200
    
    MemRead = 1;
    MemWrite = 0;
    for(i = 0; i < 4; i = i + 1) begin
      #100 address <= i << 2;
    end

    #200 $finish;
  end

  initial begin
    $dumpfile("DataMemory_testbench.vcd");
    $dumpvars(0, DataMemory_testbench);
  end
endmodule
