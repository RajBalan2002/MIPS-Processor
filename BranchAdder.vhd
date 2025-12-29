library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BranchAdder is
    port( pcadd, shifted : in std_logic_vector(31 downto 0);
          BranchAddr : out std_logic_vector(31 downto 0) );
end BranchAdder;

architecture behavior of BranchAdder is
begin
    BranchAddr <= std_logic_vector(unsigned(pcadd) + unsigned(shifted));
end behavior;
