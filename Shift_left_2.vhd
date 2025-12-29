library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Left_2 is
    port( sign_ext : in std_logic_vector(31 downto 0);
          shifted  : out std_logic_vector(31 downto 0) );
   
end Shift_Left_2;

architecture behavior of Shift_Left_2 is
begin
    shifted <= sign_ext(29 downto 0) & "00";
end behavior;
