library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity alu is port ( 
a,b : in bit_vector( 31 DOWNTO 0);
alu_control : in bit_vector (3 DOWNTO 0);
shamt :in bit_vector ( 4 DOWNTO 0);
result : out bit_vector(31 DOWNTO 0);
zero : out bit );
end alu;
architecture ALU of alu is
begin
      process ( a,b,alu_control,shamt)
      begin
      if(alu_control = "0010" ) then
              result <= to_bitvector(to_stdlogicvector(a) + to_stdlogicvector(b));
      elsif(alu_control = "0110" ) then
              result <= to_bitvector(to_stdlogicvector(a) - to_stdlogicvector(b));
	      if (a = b ) then
		zero= '1';
              else zero='0';
	      end if ;
      elsif(alu_control = "0011" ) then
             result <= a sll to_integer(unsigned(to_stdlogicvector((shamt)))); 
      elsif(alu_control = "0000" ) then
              result <= to_bitvector(to_stdlogicvector(a) and to_stdlogicvector(b));
      elsif(alu_control = "1100" ) then
              result <= to_bitvector( not (to_stdlogicvector(a) or to_stdlogicvector(b)));
      elsif(alu_control = "0111" ) then
             if( a < b )then 
                result <= "11111111111111111111111111111111";
                else
                 result <="00000000000000000000000000000000";
             end if;
      elsif(alu_control = "0001" ) then
              result <= to_bitvector(to_stdlogicvector(a) or to_stdlogicvector(b)) ;
      end if ;
      end process;
end ALU;     


  