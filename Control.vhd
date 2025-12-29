library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is

    port( opcode : in STD_LOGIC_VECTOR(5 downto 0);
		  RegWrite, MemWrite, MemRead, ALUSrc, MemtoReg, RegDst : out STD_LOGIC;
          Branch  : out STD_LOGIC_VECTOR(1 downto 0);
		  ALUOp  : out STD_LOGIC_VECTOR(2 downto 0) );
		  
end Control;

architecture behavioral of Control is

signal hexcode : std_logic_vector(7 downto 0);

begin

    hexcode <= "00" & opcode;
    
    with hexcode select
        RegWrite <= '0' when x"2B",
                    '0' when x"04",
                    '0' when x"05",
                    '0' when x"02",
                    '1' when others;
    
    with hexcode select
        MemWrite <= '1' when x"2B",
                    '0' when others;
                    
    with hexcode select
        MemRead <= '1' when x"23",
                   '0' when others;
    
    with hexcode select              
        RegDst <=    '0' when x"00",
                     '1' when others;
                                          
     with hexcode select
        ALUSrc <= '0' when x"00",
                  '0' when x"04",
                  '0' when x"05",
                  '1' when others;
                  
     with hexcode select
        Branch <= "10" when x"04",
                  "11" when x"05",
                  "00" when others;
                  
    with hexcode select
        MemtoReg      <= '1' when x"23",
                         '0' when others;
   
    with hexcode select
        ALUOp  <=   "001" when x"08", -- 001000 addi
                    "001" when x"09", -- 001001 addiu
                    "001" when x"23", -- 100011 lw (uses add)
                    "001" when x"2B", -- 101011 sw (uses add)
                    "010" when x"04", -- 000100 beq (uses sub)
                    "010" when x"05", -- 000101 bne (uses sub)
                    "011" when x"0C", -- 001100 andi
                    "100" when x"0D", -- 001101 ori
                    "101" when x"0A", -- 001010 slti
                    "110" when x"0B", -- 001011 sltui
                    "000" when others;-- R-type or J-type instruction 
    
end behavioral;