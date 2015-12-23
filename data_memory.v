module DataMemory(address, write_data, MemRead, MemWrite, DataSize, sign, clk, read_data);
  input [31:0] address, write_data;
  input MemRead, MemWrite, clk;
  output wire [31:0] read_data;
  input sign;
  input [1:0] DataSize;

  reg [7:0] mem [0:4096];

  parameter [1:0]
    WORD = 2'b11,
    HALFWORD = 2'b10,
    BYTE = 2'b01;

  wire [31:0] signed_data;
  wire [31:0] unsigned_data;

  assign signed_data = (DataSize == WORD)? {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} : (DataSize == HALFWORD)? {{16{mem[address][7]}}, mem[address], mem[address + 1]} : (DataSize == BYTE)? {{24{mem[address][7]}},mem[address]} : 32'bx;
  assign unsigned_data = (DataSize == WORD)? {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} : (DataSize == HALFWORD)? {{16{1'b0}}, mem[address], mem[address + 1]} : (DataSize == BYTE)? {{24{1'b0}},mem[address]} : 32'bx ;
  assign read_data = (sign == 1'b1)? signed_data : unsigned_data;
  

  always @ (negedge clk) begin
    if(MemWrite) begin
      if(DataSize == WORD)
        #100 {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]}= write_data;
      else if(DataSize == HALFWORD)
        #100 {mem[address], mem[address + 1]}= write_data[15:0];
      else if(DataSize == BYTE)
        #100 mem[address]= write_data[7:0];
    end
  end

  initial begin
    $readmemb("data-memory.mem", mem);
  end
endmodule

module DataMemory_testbench();
  reg [31:0] address, write_data;
  reg MemRead, MemWrite, clk;
  reg sign;
  reg [1:0] DataSize;
  wire [31:0] read_data;

  DataMemory mem(address, write_data, MemRead, MemWrite, DataSize, sign, clk, read_data);

  initial begin
    clk = 0;
    forever #50 clk = ~clk;
  end

  integer i;
  initial begin
    DataSize = 2'b01;
    sign = 0;
    address = 16;
    MemRead = 1;
    MemWrite = 0;

    #200

    sign = 1;
    MemWrite = 1;
    MemRead = 1;
    DataSize <= 2'b11;
    address <= 4;
    write_data <= 32'h01234567;

    #200

    DataSize = 2'b10;
    address <= 10;
    write_data <= 32'h00004567;

    #200

    DataSize = 2'b01;
    address <= 13;
    write_data <= 32'h00000067;

    #200    
    
    MemRead = 1;
    MemWrite = 0;

    DataSize = 2'b11;
    for(i = 0; i < 4; i = i + 1) begin
      #100 address <= i << 2;
    end

    #100

    DataSize = 2'b10;
    for(i = 0; i < 8; i = i + 1) begin
      #100 address <= i << 1;
    end

    #100

    DataSize = 2'b01;
    for(i = 0; i < 16; i = i + 1) begin
      #100 address <= i;
    end

    #200 $finish;
  end
endmodule
