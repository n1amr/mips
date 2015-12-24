	 	  entity decoder IS
		  port (instruction :IN bit_vector (31 downto 0 ) ;
		  opcode : out bit_vector (5 downto 0) ;
		  rs : out bit_vector (4 downto 0);
		  rt : out bit_vector (4 downto 0);
		  rd : out bit_vector (4 downto 0);	
		  shamt : out bit_vector (4 downto 0); 
		  funct : out bit_vector (5 downto 0);
		  shift : out bit_vector (15 downto 0);
		  jump_address : out bit_vector (25 downto 0) );
	  end decoder;
	  architecture behave OF decoder IS
	  begin 
		  process (instruction)
		  begin
					   opcode <= instruction(31 downto 26);
			  			   
   rs <= instruction(25 downto 21);
  rt <= instruction(20 downto 16);
   rd <= instruction(15 downto 11);
   shamt <= instruction(10 downto 6);
   funct <= instruction(5 downto 0);
  shift <= instruction(15 downto 0);
   jump_address <= instruction(25 downto 0);

		  end process;
		  end behave ;