module DataMemory(address, write_data, MemRead, MemWrite, clk, read_data);
  input [31:0] address, write_data;
  input MemRead, MemWrite, clk;
  output wire [31:0] read_data;

  reg [7:0] mem [0:4096];

  parameter [1:0]
    WORD = 2'b11,
    HALFWORD = 2'b10,
    BYTE = 2'b01;

  assign #200 read_data = (MemRead)? {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} : 32'bz;
  

  always @ (negedge clk) begin
    if(MemWrite) begin
      #100 {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} = write_data;
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

    #200
    
    MemRead = 1;
    MemWrite = 0;

    for(i = 0; i < 4; i = i + 1) begin
      #100 address <= i << 2;
    end

    #200 $finish;
  end
endmodule
