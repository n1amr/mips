library IEEE;
use IEEE.std_logic_1164.ALL ;	  
entity control IS
		  port (opcode :in bit_vector (5 downto 0) ;
		  Branch, MemRead, MemWrite, ALUSrc, RegWrite : out bit  ;
		  ALUOp, RegDst, MemtoReg : out bit_vector(1 downto 0)  );
	  end control ;
	  architecture behave OF control IS						
	  begin 
      process (opcode)	
	  begin 
		   
  if (opcode = "000000"	)
  then  RegDst <= "01";
        ALUSrc <= '0';
        MemtoReg <= "00";
        RegWrite <= '1';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp <= "10";
  end if  ; 
		 
		 if (opcode = "001000"	)
			  then	 RegDst <= "00";
        ALUSrc <= '1';
        MemtoReg <= "00";
        RegWrite <= '1';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp <= "00";
		 end if  ;
		   
  if (opcode = "001100"	)
  then  RegDst <= "00";
        ALUSrc <= '1';
        MemtoReg <= "00";
        RegWrite <= '1';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp <= "11";
  end if  ;       
  
  if (opcode = "100011"	)
  then  RegDst <= "00";
        ALUSrc <= '1';
        MemtoReg <= "01";
        RegWrite <= '1';
        MemRead <= '1';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp <= "00";
  end if  ;  
  
  if (opcode = "101011"	)
  then  RegDst <= "xx";
        ALUSrc <= '1';
        MemtoReg <= "xx";
        RegWrite <= '0';
        MemRead <= '0';
        MemWrite <= '1';
        Branch <= '0';
        ALUOp <= "00";
  end if  ;	
  
  if (opcode = "000100"	)
  then  RegDst <= "xx";
        ALUSrc <= '0';
        MemtoReg <= "xx";
        RegWrite <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '1';
        ALUOp <= "01";
  end if  ;
  
  if (opcode = "000100"	)
  then  RegDst <= "10";
        ALUSrc <= 'x';
        MemtoReg <= "10";
        RegWrite <= '1';
        MemRead <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUOp <= "xx";
  end if  ;
  

 		   
			  end process;
		  end behave ;