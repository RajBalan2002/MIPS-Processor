library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BranchLogic is
port( zero : in std_logic;
      branch : in std_logic_vector(1 downto 0);
      S : out std_logic );
end BranchLogic;

architecture behavior of BranchLogic is

begin

S <= '1' when (branch = "10" and zero = '1') else
     '1' when (branch = "11" and zero = '0') else 
     '0';

end behavior;
