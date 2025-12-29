library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Write_back_mux is
    port(    ALU, MEM   : in std_logic_vector(31 downto 0);
             S          : in std_logic;
             muxOut     : out std_logic_vector(31 downto 0)) ;
end Write_back_mux;

architecture behavior of Write_back_mux is
begin

muxOut <= ALU when S = '0' else MEM;

end behavior;