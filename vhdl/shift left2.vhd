  	  entity shift_left2 IS
		  port (input :IN bit_vector (31 downto 0) ; output: out bit_vector (31 downto 0));
	  end shift_left2  ;
	  architecture behave OF shift_left2 IS
	  
	  begin 
		  process (input)
		  begin
			output <= input sll 2 ;  		  
	  end process;
	  end behave ;		
	  
	