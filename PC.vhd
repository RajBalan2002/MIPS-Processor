library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
	port( clk, rst   : in std_logic;
		  en         : in std_logic;
		  NextAddr   : in std_logic_vector(31 downto 0);
		  CurrAddr 	 : out std_logic_vector(31 downto 0)
		 );
end PC;

architecture behavioral of PC is

signal addr_reg : STD_LOGIC_VECTOR(31 downto 0) := x"00000000";

begin
	
process(rst, clk, en)
begin	
    if(rising_edge(clk)) then
        if(rst = '1') then
            addr_reg <= x"00000000";
        elsif(en = '1') then
            addr_reg <= NextAddr;				
	    end if;
    end if;
end process;
    
CurrAddr <= addr_reg;
    
end behavioral;