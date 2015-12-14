module RegisterFile(read_reg1, read_reg2, write_reg, write_data, RegWrite, clk, read_data1, read_data2);
  input [5:0] read_reg1, read_reg2, write_reg;
  input [31:0] write_data;
  input RegWrite, clk;
  output reg [31:0] read_data1, read_data2;

  reg [31:0] registers [0:31];

  always @(read_reg1 or registers[read_reg1]) begin
    #100 read_data1 = registers[read_reg1];
  end

  always @(read_reg2 or registers[read_reg2]) begin
    #100 read_data2 = registers[read_reg2];
  end

  always @(posedge clk) begin
    if(RegWrite && write_reg != 5'b00000) begin
      #100 registers[write_reg] = write_data;
    end
  end

  // Initialization for simulation (TODO remove later)
  integer i;
  initial begin
    for(i = 0; i < 32; i = i + 1) begin
      registers[i] = i;
    end    
  end
endmodule

module RegisterFile_testbench;
  reg [5:0] read_reg1, read_reg2, write_reg;
  reg [31:0] write_data;
  reg RegWrite, clk;
  wire [31:0] read_data1, read_data2;

  RegisterFile regs(read_reg1, read_reg2, write_reg, write_data, RegWrite, clk, read_data1, read_data2);

  initial begin
    clk <= 0;
    forever #500 clk <= ~clk;
  end

  initial begin
    read_reg1 <= 1;
    read_reg2 <= 3;
    write_reg <= 3;

    RegWrite = 0;

    #1000
    #100 read_reg1 = 2;

    #100 write_data <= 32'habcdef12;
    #100 RegWrite <= 1;

    #1000 RegWrite <= 0;

    #500 $finish;
  end

  initial begin
    $dumpfile("RegisterFile_testbench.vcd");
    $dumpvars(0, RegisterFile_testbench);
  end
endmodule
