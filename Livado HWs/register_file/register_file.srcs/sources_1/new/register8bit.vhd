----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/26/2017 06:29:34 PM
-- Design Name: 
-- Module Name: register8bit - Behavioral
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

entity register8bit is
    Port ( d : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (7 downto 0));
end register8bit;

architecture Behavioral of register8bit is

begin

process(clk)
begin
    if rising_edge(clk) then
        if en = '1' then
            q <= d;
        end if;
    end if;
end process;

end Behavioral;
