----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2017 06:13:08 PM
-- Design Name: 
-- Module Name: BinaryToSevenSegment - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BinaryToSevenSegment is
    Port ( binary_number : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end BinaryToSevenSegment;

architecture Behavioral of BinaryToSevenSegment is

signal digit4 : std_logic_vector(3 downto 0);
signal digit3 : std_logic_vector(3 downto 0);
signal digit2 : std_logic_vector(3 downto 0);
signal digit1 : std_logic_vector(3 downto 0);
signal digit0 : std_logic_vector(3 downto 0);

signal big_clock_counter : std_logic_vector(17 downto 0);
signal clk_1khz : std_logic;

signal bcd_digit : std_logic_vector(3 downto 0);

signal two_bit_counter : std_logic_vector(1 downto 0);

begin

process(binary_number)
variable big_shift_register : std_logic_vector(35 downto 0);
begin

big_shift_register := "00000000000000000000" & binary_number;

-- loop 16 times
for i in 0 to 15 loop

    -- if the result digits are >= 5 then add 3 to that digit
    if big_shift_register(35 downto 32) > "0100" then
        big_shift_register(35 downto 32) := std_logic_vector(unsigned(big_shift_register(35 downto 32)) + "0011");
    end if;
    
    if big_shift_register(31 downto 28) > "0100" then
        big_shift_register(31 downto 28) := std_logic_vector(unsigned(big_shift_register(31 downto 28)) + "0011");
    end if;
        
    if big_shift_register(27 downto 24) > "0100" then
        big_shift_register(27 downto 24) := std_logic_vector(unsigned(big_shift_register(27 downto 24)) + "0011");
    end if;
            
    if big_shift_register(23 downto 20) > "0100" then
        big_shift_register(23 downto 20) := std_logic_vector(unsigned(big_shift_register(23 downto 20)) + "0011");
    end if;
            
    if big_shift_register(19 downto 16) > "0100" then
        big_shift_register(19 downto 16) := std_logic_vector(unsigned(big_shift_register(19 downto 16)) + "0011");
    end if;
    
    -- shift the big shift register by one
    big_shift_register := big_shift_register(34 downto 0) & "0";
    
end loop;

-- assign variable to digits because variable is not avaialable outside process

if binary_number > "0010011100001111" then
    digit3 <= "1001";
    digit2 <= "1001";
    digit1 <= "1001";
    digit0 <= "1001";
else
    digit3 <= big_shift_register(31 downto 28);
    digit2 <= big_shift_register(27 downto 24);
    digit1 <= big_shift_register(23 downto 20);
    digit0 <= big_shift_register(19 downto 16);
end if;

end process;


process(clk)
begin
    if rising_edge(clk) then
        if big_clock_counter = "111101000010010000" then
            big_clock_counter <= (others => '0');
            clk_1khz <= not clk_1khz;
        else
            big_clock_counter <= std_logic_vector(unsigned(big_clock_counter) + "1");
        end if; 
    end if;
end process;

process(clk_1khz)
begin
    if rising_edge(clk_1khz) then
        two_bit_counter <= std_logic_vector(unsigned(two_bit_counter) + "1");
    end if;
end process;


an <= "1110" when two_bit_counter = "00" else
        "1101" when two_bit_counter = "01" else
        "1011" when two_bit_counter = "10" else
        "0111" when two_bit_counter = "11";
        
bcd_digit <= digit0 when two_bit_counter = "00" else 
            digit1 when two_bit_counter = "01" else 
            digit2 when two_bit_counter = "10" else 
            digit3 when two_bit_counter = "11";
        

seg <= "1000000" when bcd_digit = "0000" else
           "1111001" when bcd_digit = "0001" else
           "0100100" when bcd_digit = "0010" else
           "0110000" when bcd_digit = "0011" else
           "0011001" when bcd_digit = "0100" else
           "0010010" when bcd_digit = "0101" else
           "0000010" when bcd_digit = "0110" else
           "1111000" when bcd_digit = "0111" else
           "0000000" when bcd_digit = "1000" else
           "0010000" when bcd_digit = "1001" else "1111111";

end Behavioral;
