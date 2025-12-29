library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Write_reg_mux is
    port(    RD, RT     : in std_logic_vector(4 downto 0);
             S          : in std_logic;
             muxOut     : out std_logic_vector(4 downto 0)) ;
end Write_reg_mux;

architecture behavior of Write_reg_mux is
begin
    
muxOut <= RD when S = '0' else RT;
                  
end behavior; 