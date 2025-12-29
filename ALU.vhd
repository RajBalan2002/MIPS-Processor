library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port(A : in std_logic_vector(31 downto 0);
         B : in std_logic_vector(31 downto 0);
         Shamt : in std_logic_vector(4 downto 0);
         ALUCntl : in std_logic_vector(3 downto 0);
         Carryin : in std_logic;
         Zero, Overflow: out std_logic;
         Carryout : out std_logic;
         ALUout : out std_logic_vector(31 downto 0));
end alu;

architecture Behavioral of alu is

signal ALUresult, shift_r, shift_l, slt, sltu : std_logic_vector(31 downto 0);
signal temp_C : std_logic_vector(32 downto 0) := (others => '0');
signal add, sub, temp_A, temp_B : std_logic_vector(32 downto 0);

begin
----ALU Function Selection----------------------------    
    with ALUcntl select
        ALUresult <= A and B          	when "0000",
                     A or B           	when "0001",
                     A xor B          	when "0010",
                     A nor B          	when "0011",
                     add(31 downto 0)   when "0100",
                     sub(31 downto 0)   when "0101",
                     shift_l           	when "0110",
                     shift_r            when "0111",                     
					 slt 	            when "1000",
					 sltu    	        when "1001",
                     A                	when others;
    
    ALUout <= ALUresult;
-------------------------------------------------------
----Addition Operations--------------------------------
    temp_A    <= '0' & A;	-- zero padding of A, B, and Carryin so that we can get Carryout
    temp_B    <= '0' & B;
    temp_C(0) <= Carryin;   
    
    add <= std_logic_vector(signed(temp_A) + signed(temp_B) + signed(temp_C));
    sub <= std_logic_vector(signed(temp_A) - signed(temp_B));
------------------------------------------------------   
----Carryout, Overflow, and Zero Flag-----------------    
    Carryout <= add(32) when ALUCntl = "0010" else '0';
            
    Overflow <= (A(3)and B(31)       and (not ALUresult(31))) or ((not A(31))and (not B(31)) and ALUresult(31)) when ALUCntl = "0010" else
                (A(31)and (not B(31)) and (not ALUresult(31))) or ((not A(31))and B(31)       and ALUresult(31)) when ALUCntl = "0110" else
                '0';
    
    Zero     <= '1' when ALUresult = x"00000000" else '0';                
------------------------------------------------------
----Set On Less Than Operation------------------------    
	slt  <= x"00000001" when signed(A) < signed(B) else x"00000000";
	sltu <= x"00000001" when unsigned(A) < unsigned(B) else x"00000000";
------------------------------------------------------	
----Shift Operations----------------------------------    
    shift_r <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(Shamt)))); --needs to be unsigned otherwise it will be arithmetic shift instead of logical
    shift_l <= std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(Shamt))));
------------------------------------------------------    
 
    -- think about the logic for when overflow will occur using A32(31), B32(31), and ALUtemp(31) for both add & subtract
	-- the solution will take the form of:
	-- Overflow <= [some logic expression for addition overflow; sum of maxterms or the equivalent] when ALUCntl = add else
	--			   [some logic expression for subtraction overflow; sum of maxterms or the equivalent] when ALUCntl = subtract else
	--				'0';
end Behavioral;
