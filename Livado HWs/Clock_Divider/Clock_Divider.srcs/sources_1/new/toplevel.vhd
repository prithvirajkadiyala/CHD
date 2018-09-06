----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2017 06:14:59 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
 Port (clk : in std_logic;
        led : out std_logic_vector(15 downto 0) );
end toplevel;

architecture Behavioral of toplevel is

signal counter : std_logic_vector(20 downto 0);
signal other_counter : std_logic_vector(26 downto 0);

begin

process(clk)
begin

if rising_edge(clk) then
    --If Else 1
    if counter="1111111001010000001010101" then 
        counter<= (others=> '0');
    else
        counter<= std_logic_vector(unsigned(counter) + 1);
    end if;
    --If Else 2
    if counter > "111111100101000000101011" then
        led(15) <= '1';
    else
        led(15) <= '0';
    end if;
    
end if;
end process;
process(clk)
begin

if rising_edge(clk) then
    --If Else 1
    if counter="111011100110101100101000000000" then 
        counter<= (others=> '0');
    else
        counter<= std_logic_vector(unsigned(counter) + 1);
    end if;
    --If Else 2
    if counter > "11101110011010110010100000000" then
        led(15) <= '1';
    else
        led(15) <= '0';
    end if;
    
end if;
end process;

led(14 downto 0) <= (others => '0');



end Behavioral;
