library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all
entity adder IS port ( 
a : in bit_vector (31 DOWNTO 0);
b : in bit_vector (31 DOWNTO 0) ;
result : out bit_vector (31 DOWNTO 0));
end adder;

architecture behave of adder is 
begin
result <= a+b;
end behave;
