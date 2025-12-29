library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity RegFile is
    Port ( clk       : in  STD_LOGIC;
           en        : in  std_logic;
           write_en  : in  STD_Logic;
           read_reg1 : in  std_Logic_vector(4 downto 0);
           read_reg2 : in  Std_Logic_vector(4 downto 0);
           write_reg : in  Std_Logic_vector(4 downto 0);
           write_data: in  Std_Logic_vector(31 downto 0);
           read_data1: out Std_Logic_vector(31 downto 0);
           read_data2: out Std_Logic_vector(31 downto 0)
         );
           
end RegFile;

architecture Behavioral of RegFile is

type initial is array (0 to 31) of std_logic_vector(31 downto 0);
    signal RAM : initial :=(
            x"00000000", --$zero
            x"00000000", --$at
            x"00000000", --$v0
            x"00000000", --$v1
            x"00000000", --$a0
            x"00000000", --$a1
            x"00000000", --$a2
            x"00000000", --$a3
            x"00000009", --$t0
            x"0000000A", --$t1
            x"0000000B", --$t2
            x"0000000C", --$t3
            x"0000000D", --$t4
            x"0000000E", --$t5
            x"0000000F", --$t6
            x"00000010", --$t7
            x"00000011", --$s0
            x"00000012", --$s1
            x"00000013", --$s2
            x"00000014", --$s3
            x"00000015", --$s4
            x"00000016", --$s5
            x"00000017", --$s6
            x"00000018", --$s7
            x"00000019", --$t8
            x"0000001A", --$t9
            x"00000000", --$k0
            x"00000000", --$k1
            x"00000000", --$gp
            x"00000000", --$sp
            x"00000000", --$fp
            x"00000000"  --$ra
     );

begin

--Process to write data
process(clk) begin
    if(rising_edge(clk)) then     
        if(en = '1' and write_en = '1') then
            RAM(to_integer(unsigned(write_reg)))<= write_data;
        end if;
    end if;
end process;

read_data1<=RAM(to_integer(unsigned(read_reg1)));
read_data2<=RAM(to_integer(unsigned(read_reg2)));

end Behavioral;
