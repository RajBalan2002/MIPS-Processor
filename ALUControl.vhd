library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is 
	port( funct   : in  STD_LOGIC_VECTOR(5 downto 0);
	      ALUOp   : in  STD_LOGIC_VECTOR(2 downto 0);
		  alucntl : out STD_LOGIC_VECTOR(3 downto 0) );
end ALUControl;

architecture behavioral of ALUControl is

signal temp1 : STD_LOGIC_VECTOR(3 downto 0);
signal temp2 : STD_LOGIC_VECTOR(3 downto 0);

begin
    
	 with funct select
         temp1 <=    "0000" when "100100", -- and
                     "0001" when "100101", -- or
                     "0010" when "100110", -- xor
                     "0011" when "100111", -- nor
                     "0100" when "100000", -- add
                     "0100" when "100001", -- addu
                     "0101" when "100010", -- sub
                     "0101" when "100011", -- subu
                     "0110" when "000000", -- sll                         
                     "0111" when "000010", -- srl
                     "1000" when "101010", -- slt
                     "1001" when "101011", -- sltu
                     "1111" when others;   -- defaults the ALU to output Rs
         
    with ALUOp select
        temp2  <=   "0100" when "001", -- add
	                "0101" when "010", -- sub
	                "0000" when "011", -- and
	                "0001" when "100", -- or
	                "1000" when "101", -- slt
	                "1001" when "110", -- sltu
	                "1111" when others;

alucntl <= temp1 when ALUOp = "000" else temp2;

end behavioral;
