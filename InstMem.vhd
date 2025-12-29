library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity InstMem is
    Port ( addr : in  STD_LOGIC_VECTOR (31 downto 0);
           inst_out : out  STD_LOGIC_VECTOR (31 downto 0));
end InstMem;

architecture Behavioral of InstMem is

type Instruction_Memory is array (0 to 255) of std_logic_vector (7 downto 0);
    signal RAM: Instruction_Memory:=(
            x"8c",x"08",x"00",x"00",-- 0X00         lw $t0, 0($zero) 
            x"8c",x"09",x"00",x"04",-- 0X04         lw $t1, 4($zero) 
            x"8c",x"0a",x"00",x"08",-- 0X08         lw $t2, 8($zero) 
            x"8c",x"0b",x"00",x"0c",-- 0X0C         lw $t3, 12($zero) 
            x"8c",x"0c",x"00",x"10",-- 0X10         lw $t4, 16($zero) 
            x"8c",x"0d",x"00",x"14",-- 0X14         lw $t5, 20($zero) 
            x"21",x"08",x"00",x"01",-- 0X18  insts: addi $t0, $t0, 1 
            x"31",x"29",x"00",x"00",-- 0X1C         andi $t1, $t1, 0 
            x"35",x"4a",x"00",x"07",-- 0X20         ori $t2, $t2, 7 
            x"29",x"6b",x"00",x"09",-- 0X24         slti $t3, $t3, 9 
            x"2d",x"8c",x"00",x"00",-- 0X28         sltiu $t4, $t4, 0 
            x"01",x"a8",x"68",x"22",-- 0X2C         sub $t5, $t5, $t0 
            x"11",x"a0",x"00",x"01",-- 0X30         beq  $t5, $zero, store
            x"15",x"a0",x"ff",x"f8",-- 0X34         bne  $t5, $zero, insts
            x"ac",x"08",x"00",x"00",-- 0X38  store: sw $t0, 24($zero) 
            x"ac",x"09",x"00",x"04",-- 0X3C         sw $t1, 28($zero) 
            x"ac",x"0a",x"00",x"08",-- 0X40         sw $t2, 32($zero) 
            x"ac",x"0b",x"00",x"0c",-- 0X44         sw $t3, 36($zero) 
            x"ac",x"0c",x"00",x"10",-- 0x48         sw $t4, 40($zero) 
            x"ac",x"0d",x"00",x"14",-- 0x4C         sw $t5, 44($zero)
            x"00",x"00",x"00",x"00",-- 0x50: (empty location)
            x"00",x"00",x"00",x"00",-- 0x54: (empty location)
            x"00",x"00",x"00",x"00",-- 0x58: (empty location)
            x"00",x"00",x"00",x"00",-- 0x5C: (empty location)
            x"00",x"00",x"00",x"00",-- 0x60: (empty location)
            x"00",x"00",x"00",x"00",-- 0x64: (empty location)
            x"00",x"00",x"00",x"00",-- 0x68: (empty location)
            x"00",x"00",x"00",x"00",-- 0x6C: (empty location)
            x"00",x"00",x"00",x"00",-- 0x70: (empty location)
            x"00",x"00",x"00",x"00",-- 0x74: (empty location)
            x"00",x"00",x"00",x"00",-- 0x78: (empty location)
            x"00",x"00",x"00",x"00",-- 0x7C: (empty location)
            x"00",x"00",x"00",x"00",-- 0x80: (empty location)
            x"00",x"00",x"00",x"00",-- 0x84: (empty location)
            x"00",x"00",x"00",x"00",-- 0x88: (empty location)
            x"00",x"00",x"00",x"00",-- 0x8C: (empty location)
            x"00",x"00",x"00",x"00",-- 0x90: (empty location)
            x"00",x"00",x"00",x"00",-- 0x94: (empty location)
            x"00",x"00",x"00",x"00",-- 0x98: (empty location)
            x"00",x"00",x"00",x"00",-- 0x9C: (empty location)
            x"00",x"00",x"00",x"00",-- 0xA0: (empty location)
            x"00",x"00",x"00",x"00",-- 0xA4: (empty location)
            x"00",x"00",x"00",x"00",-- 0xA8: (empty location)
            x"00",x"00",x"00",x"00",-- 0xAC: (empty location)
            x"00",x"00",x"00",x"00",-- 0xB0: (empty location)
            x"00",x"00",x"00",x"00",-- 0xB4: (empty location)
            x"00",x"00",x"00",x"00",-- 0xB8: (empty location)
            x"00",x"00",x"00",x"00",-- 0xBC: (empty location)
            x"00",x"00",x"00",x"00",-- 0xC0: (empty location)
            x"00",x"00",x"00",x"00",-- 0xC4: (empty location)
            x"00",x"00",x"00",x"00",-- 0xC8: (empty location)
            x"00",x"00",x"00",x"00",-- 0xCC: (empty location)
            x"00",x"00",x"00",x"00",-- 0xD0: (empty location)
            x"00",x"00",x"00",x"00",-- 0xD4: (empty location)
            x"00",x"00",x"00",x"00",-- 0xD8: (empty location)
            x"00",x"00",x"00",x"00",-- 0xDC: (empty location)
            x"00",x"00",x"00",x"00",-- 0xE0: (empty location)
            x"00",x"00",x"00",x"00",-- 0xE4: (empty location)
            x"00",x"00",x"00",x"00",-- 0xE8: (empty location)
            x"00",x"00",x"00",x"00",-- 0xEC: (empty location)
            x"00",x"00",x"00",x"00",-- 0xF0: (empty location)
            x"00",x"00",x"00",x"00",-- 0xF4: (empty location)
            x"00",x"00",x"00",x"00",-- 0xF8: (empty location)
            x"00",x"00",x"00",x"00" -- 0xFF: (empty location)
            );

begin
    
    inst_out(31 downto 24)  <= RAM(to_integer(unsigned(addr)));
    inst_out(23 downto 16)  <= RAM(to_integer(unsigned(addr)+1));
    inst_out(15 downto 8)   <= RAM(to_integer(unsigned(addr)+2));
    inst_out(7 downto 0)    <= RAM(to_integer(unsigned(addr)+3));

end Behavioral;