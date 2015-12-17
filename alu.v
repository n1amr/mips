module ALU(result, zero, a, b, alu_control,clk);
  input [31:0] a, b;
  input [3:0] alu_control;
  input clk;
  output reg [31:0] result;
  output reg zero;

always @ (a,b,alu_control) begin
      zero<=1'b0;
      case(alu_control)
      //add    
      4'b0000:       result <= a + b;
      //addi
      4'b0001:       result <= a + b; 
      //lw
       4'b0010:      result <= a + b; 
      //sw
       4'b0011:      result <= a + b; 
      //sll
       4'b0100:      result <= a << b; 
      //and
       4'b0101:      result <= a & b;
      //andi
       4'b0110:      result <=  a & b ;   
      //nor
       4'b0111:      result <= ~(a | b) ; 
       //beq
       4'b1000:     
          if(a==b) begin zero<=1'b1; result<=32'b0; end
       //jal
       4'b1001:        result<=32'b0;
       //jr
       4'b1010:          result <=32'b0;     
      //slt 
       4'b1011:         
	 if(a<b) 
		result <= 32'b00000000_00000000_00000000_00000001; 
	else begin result<=32'b0; 
end
endcase
  end
endmodule
