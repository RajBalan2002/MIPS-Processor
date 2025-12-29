library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sign_Extension is
    port( SEin : in std_logic_vector(15 downto 0);
          SEout : out std_logic_vector(31 downto 0) );
end Sign_Extension;

architecture behavior of Sign_Extension is
begin   

     SEout <= x"0000" & SEin when SEin(15) = '0' else
              x"FFFF" & SEin;
                  
end behavior;
