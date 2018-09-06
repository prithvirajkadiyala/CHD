----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2017 06:28:55 PM
-- Design Name: 
-- Module Name: toplevel - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR(6 downto 0);
           an : out STD_LOGIC_VECTOR(3 downto 0));
end toplevel;

architecture Behavioral of toplevel is

signal digit4 : std_logic_vector(3 downto 0);
signal digit3 : std_logic_vector(3 downto 0);
signal digit2 : std_logic_vector(3 downto 0);
signal digit1 : std_logic_vector(3 downto 0);
signal digit0 : std_logic_vector(3 downto 0);

signal big_clock_counter : std_logic_vector(25 downto 0);
signal two_bit_counter : std_logic_vector(1 downto 0);
signal clk_1hz : std_logic_vector(1 downto 0);
signal bcd_digit : STD_LOGIC_VECTOR(3 downto 0);

begin

process(sw(15 downto 0))
variable big_shift_register : std_logic_vector(35 DOWNTO 0);
begin

led <= sw;
big_shift_register := "00000000000000000000" & sw;

for i in 0 to 15 loop

    if big_shift_register(35 DOWNTO 32) > "0100" then
        big_shift_register(35 DOWNTO 32) := std_logic_vector(unsigned(big_shift_register(35 DOWNTO 32))+"0011");
    end if;
    if big_shift_register(31 DOWNTO 28) > "0100" then
        big_shift_register(31 DOWNTO 28) := std_logic_vector(unsigned(big_shift_register(31 DOWNTO 28))+"0011");
    end if;
    if big_shift_register(27 DOWNTO 24) > "0100" then
        big_shift_register(27 DOWNTO 24) := std_logic_vector(unsigned(big_shift_register(27 DOWNTO 24))+"0011");
    end if;
    if big_shift_register(23 DOWNTO 20) > "0100" then
        big_shift_register(23 DOWNTO 20) := std_logic_vector(unsigned(big_shift_register(23 DOWNTO 20))+"0011");
    end if;
    if big_shift_register(19 DOWNTO 16) > "0100" then
            big_shift_register(19 DOWNTO 16) := std_logic_vector(unsigned(big_shift_register(19 DOWNTO 16))+"0011");
        end if;
      
    big_shift_register := big_shift_register(34 DOWNTO 0) & "0";

end loop;

if sw > "0010011100001111" then
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

--led(3 downto 0) <= digit0;
--led(7 downto 4) <= digit1;
--led(11 downto 8) <= digit2;
--led(15 downto 12) <= digit3;

process(clk)
begin
    if rising_edge(clk) then
        if big_clock_counter = "00000000001100001101001111" then
            big_clock_counter <= (others => '0');
            two_bit_counter <= std_logic_vector(unsigned(two_bit_counter) + "1");
        else
            big_clock_counter <=std_logic_vector(unsigned(big_clock_counter) + "1");
        end if;
    end if;
end process;

--led(1 downto 0) <= big_clock_counter(1 downto 0);

--process(clk_1hz)
--begin
--    if rising_edge(clk) then
--        two_bit_counter <= std_logic_vector(unsigned(two_bit_counter) + "1");
--    end if;
--end process;

an <= "1110" when two_bit_counter(1 downto 0) = "00" else
    "1101" when two_bit_counter(1 downto 0) = "01" else 
    "1011" when two_bit_counter(1 downto 0) = "10" else
    "0111" when two_bit_counter(1 downto 0) = "11";

bcd_digit <= digit0 when two_bit_counter(1 downto 0) = "00" else
    digit1 when two_bit_counter(1 downto 0) = "01" else 
    digit2 when two_bit_counter(1 downto 0) = "10" else
    digit3 when two_bit_counter(1 downto 0) = "11";
 
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
