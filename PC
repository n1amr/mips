
module PC(clk  , instruction ,  zero , branch , jump , pc );
input clk ;
input[31:0] instruction ;
reg[31:0] npc;
input zero ;
input jump ;
input branch ;
wire[31:0] pcInc;
wire[31:0] Branch1 ;
wire[15:0] address;
wire[31:0] branchAdd;
reg[31:0] mux1; 
wire select1 ;
wire[31:0] jumpAdd ;
output [31:0] pc ;
reg [31:0] pc ;


assign select1 = branch & zero ;
assign pcInc = pc + 4 ;
assign address = instruction[15:0];
assign Branch1 =  {{16{address[15]}},address[15:0]} ;   // sign extension
assign branchAdd = pcInc + ( branch << 2 ) ;

always@( branchAdd or pcInc or select1  ) 
begin
    if ( select1 == 1 )
        mux1 = branchAdd ;
    else
        mux1 = pcInc ;
end

assign jumpAdd = ( instruction[25:0] << 2 );

always@ ( jump or jumpAdd or mux1 )
begin
    if ( jump == 1 ) 
        npc = jumpAdd ;
    else
        npc = mux1;
end

always @(posedge clk )
    pc <= npc;
endmodule
