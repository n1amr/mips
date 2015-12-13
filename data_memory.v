module DataMemory(address, write_data, MemRead, MemWrite, read_data);
  input [31:0] address, write_data;
  input MemRead, MemWrite;
  output reg [31:0] read_data;

  reg [31:0] mem [0:255];

  always @ (address or write_data or MemWrite or MemRead) begin
    if(MemWrite) begin
      mem[address >> 2] = write_data;
    end else if(MemRead) begin
      read_data <= mem[address >> 2];
    end
  end

  initial begin
    $readmemb("data-memory.mem", mem);
  end
endmodule

module DataMemory_testbench();
  reg [31:0] address, write_data;
  reg MemRead, MemWrite;
  wire [31:0] read_data;

  DataMemory mem(address, write_data, MemRead, MemWrite, read_data);

  integer i;
  initial begin
    MemRead <= 0;
    MemWrite <= 1;
    address <= 4;
    write_data <= 32'hffffffff;

    #15
    
    MemRead = 1;
    MemWrite = 0;
    for(i = 0; i < 256; i = i + 1) begin
      #5 address <= i << 2;
    end
  end
endmodule
