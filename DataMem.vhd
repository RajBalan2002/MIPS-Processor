library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity DataMem is
    Port ( clk      : in std_logic;
           en     : in std_logic;
	       addr    : in  STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (31 downto 0);
           MemWrite   : in  STD_LOGIC;
           MemRead    : in  STD_LOGIC;
           ReadData  : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMem;

architecture Behavioral of DataMem is
type datamem1 is array (0 to 63) of std_logic_vector (31 downto 0);
    signal RAM: datamem1:=(
          x"00000000",--0x00
          x"FFFFFFFF",--0x04
          x"12345678",--0x08
          x"00000008",--0x0C
          x"00000001",--0x10
          x"00000003",--0x14
          x"00000000",--0x18
          x"00000000",--0x1C
          x"00000000",--0x20
          x"00000000",--0x24
          x"00000000",--0x28
          x"00000000",--0x2C
          x"00000000",--0x30
          x"00000000",--0x34
          x"00000000",--0x38
          x"00000000",--0x3C
          x"00000000",--0x40
          x"00000000",--0x44
          x"00000000",--0x48
          x"00000000",--0x4C
          x"00000000",--0x50
          x"00000000",--0x54
          x"00000000",--0x58
          x"00000000",--0x5C
          x"00000000",--0x60
          x"00000000",--0x64
          x"00000000",--0x68
          x"00000000",--0x6C
          x"00000000",--0x70
          x"00000000",--0x74
          x"00000000",--0x78
          x"00000000",--0x7C
          x"00000000",--0x80
          x"00000000",--0x84
          x"00000000",--0x88
          x"00000000",--0x8C
          x"00000000",--0x90
          x"00000000",--0x94
          x"00000000",--0x98
          x"00000000",--0x9C
          x"00000000",--0xA0
          x"00000000",--0xA4
          x"00000000",--0xA8
          x"00000000",--0xAC
          x"00000000",--0xB0
          x"00000000",--0xB4
          x"00000000",--0xB8
          x"00000000",--0xBC
          x"00000000",--0xC0
          x"00000000",--0xC4
          x"00000000",--0xC8
          x"00000000",--0xCC
          x"00000000",--0xD0
          x"00000000",--0xD4
          x"00000000",--0xD8
          x"00000000",--0xDC
          x"00000000",--0xE0
          x"00000000",--0xE4
          x"00000000",--0xE8
          x"00000000",--0xEC
          x"00000000",--0xF0
          x"00000000",--0xF4
          x"00000000",--0xF8
          x"00000000" --0xFF
         );	

signal RAM_integer : integer range 0 to 63;
							
begin

RAM_integer <= 	to_integer(unsigned(addr(6 downto 2)));

process(MemWrite,clk)
begin
    if(rising_edge(clk))then
        if(en = '1' and MemWrite = '1') then
             RAM(RAM_integer) <= WriteData;			         
         end if;
    end if;
end process;

ReadData  <=  RAM(RAM_integer) when memread='1' else x"00000000";
 
end  Behavioral;
