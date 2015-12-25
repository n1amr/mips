entity sign_extend IS
		  port (input : in bit_vector (15 downto 0); sign :IN bit ; output : out bit_vector (31 downto 0 ));
	  end sign_extend ;
	  architecture behave OF sign_extend IS
	  begin 
		  process (input , sign)
		  begin
			  if (sign = '0') then 
				  output <= "0000000000000000" & input;
			 
			  end if ;
		  end process;
		  end behave ;
		  
				   