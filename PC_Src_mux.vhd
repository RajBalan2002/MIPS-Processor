----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2023 06:22:27 PM
-- Design Name: 
-- Module Name: PC_Src_mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_Src_mux is
    port(    PCAdder, BranchAdder : in std_logic_vector(31 downto 0);
             S                      : in std_logic;
             muxOut                 : out std_logic_vector(31 downto 0)) ;
end PC_Src_mux;

architecture behavior of PC_Src_mux is
begin
    
muxOut <= PCAdder when S = '0' else BranchAdder;
                  

end behavior;
