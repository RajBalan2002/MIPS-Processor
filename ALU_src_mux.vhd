library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Src_mux is
    port(    read_data2, immediate : in std_logic_vector(31 downto 0);
             S                     : in std_logic;
             muxOut                : out std_logic_vector(31 downto 0)) ;
end ALU_Src_mux;

architecture behavior of ALU_Src_mux is
begin

muxOut <= read_data2 when S = '0' else immediate;

end behavior; 