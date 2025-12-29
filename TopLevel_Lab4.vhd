library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopLevel_Lab4 is
    Port ( CLK     : in  std_logic;
           BTN     : in  std_logic_vector(4 downto 0);
	       LED     : out std_logic_vector(7 downto 0);
	       SSEG_CA : out std_logic_vector(7 downto 0);
           SSEG_AN : out std_logic_vector(3 downto 0));
end TopLevel_Lab4;

architecture Behavioral of TopLevel_Lab4 is

    signal MCtr: unsigned (20 downto 0);
    
    -- buttons
    signal BTNL : std_logic;
        
    -- digit ROM
    type sseg_digits is array (0 to 15) of std_logic_vector(7 downto 0);
        constant digit_table: sseg_digits := (
            "11000000",  -- 0
            "11111001",  -- 1 
            "10100100",  -- 2 
            "10110000",  -- 3
            "10011001",  -- 4
            "10010010",  -- 5
            "10000010",  -- 6
            "11111000",  -- 7 
            "10000000",  -- 8
            "10011000",  -- 9 
            "10001000",  -- A
            "10000011",  -- b 
            "11000110",  -- C 
            "10100001",  -- d 
            "10000110",  -- E 
            "10001110"   -- F
        );
        
    -- SSEG RAM
    type SSEG_MEM is array(0 to 3) of integer;
        signal SSEGmem : SSEG_MEM;
    
    -- LED output
    signal LEDout : std_logic_vector(31 downto 0);
    
    -- TopLevel Wrapper signals
    signal rst      : std_logic;
    signal en       : std_logic;
    signal zero     : std_logic;
    signal overflow : std_logic;
    signal carryout : std_logic;
    signal pcout    : std_logic_vector(4 downto 0);
    signal dout     : std_logic_vector(31 downto 0);  

begin

-----DO NOT MODIFY ABOVE THIS LINE---------------------------
    Lab3_wrapper_inst : entity work.Lab3_wrapper 
        port map(
            clk      => clk,
            en       => en,
            pcout    => pcout,
            rst      => rst,
            zero     => zero,
            overflow => overflow,
            carryout => carryout,
            dout     => dout
        );        
-----DO NOT MODIFY BELOW THIS LINE------------------------------        
    
    --Button assignment
    BTNL <= BTN(1);
    
    --LED assignments
    LED(4 downto 0)  <= pcout;
    LED(5)           <= zero;
    LED(6)           <= overflow;
    LED(7)           <= carryout;
    
    -- write to SSEG display
    process(CLK)
    begin
        if(rising_edge(clk)) then
            --increments the master counter for the sseg display
            MCtr <= MCtr + 1;
        end if;    
    end process;
    
    SSEGmem(0) <= to_integer(unsigned(dout(31 downto 28))) when BTNL = '1' else
                  to_integer(unsigned(dout(15 downto 12)));
              
    SSEGmem(1) <= to_integer(unsigned(dout(27 downto 24))) when BTNL = '1' else
                  to_integer(unsigned(dout(11 downto 8)));
                  
    SSEGmem(2) <= to_integer(unsigned(dout(23 downto 20))) when BTNL = '1' else
                  to_integer(unsigned(dout(7 downto 4)));
                  
    SSEGmem(3) <= to_integer(unsigned(dout(19 downto 16))) when BTNL = '1' else
                  to_integer(unsigned(dout(3 downto 0)));
    
    -- output to SSEG display
    process(MCtr(18 downto 17), SSEGmem)
    begin
        case(MCtr(18 downto 17)) is
            when "00" =>
                 -- first segment  left
                 SSEG_AN <= "0111";
                 SSEG_CA <= digit_table(SSEGmem(0));
            when "01" =>
                 -- second segment
                 SSEG_AN <= "1011";
                 SSEG_CA <= digit_table(SSEGmem(1));
            when "10" =>
                 -- third segment
                 SSEG_AN <= "1101";
                 SSEG_CA <= digit_table(SSEGmem(2));
            when "11" =>
                 -- fourth segment    right
                 SSEG_AN <= "1110";
                 SSEG_CA <= digit_table(SSEGmem(3));
            when others =>
                 
        end case;
    end process;
    
    Inst_BTN_debounce : entity work.BTN_debounce 
        port map(
            btn => btn,
            clk => clk,
            rst => rst,
            en  => en
        );    
    
end Behavioral;
