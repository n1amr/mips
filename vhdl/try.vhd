library IEEE;
use IEEE.std_logic_1164.ALL ;

entity tri_state_buffer IS
		  port (input :IN bit_vector(2 downto 0) ; enable :in bit ; output: out std_logic_vector (2 downto 0) );
	  end tri_state_buffer ;
	  architecture behave OF tri_state_buffer IS
	  begin 
		  
			 output <= input when (enable = '1')    else "ZZZ" ; 
			  
		
			
		  end behave ;
		  
				 