----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2017 12:13:03 AM
-- Design Name: 
-- Module Name: PsuedoRandom - Behavioral
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

entity lfsr1 is
  port (
    reset   : in  std_logic;
    clk     : in  std_logic; 
    count   : out std_logic_vector (7 downto 0) -- lfsr output
  );
end entity;

architecture rtl of lfsr1 is
  signal count_i        : std_logic_vector (7 downto 0); 
  signal feedback     : std_logic;

begin
  feedback <= not(count_i(7) xor count_i(6));        -- LFSR size 4

  process (reset, clk) 
  begin
    if (reset = '1') then
      count_i <= (others=>'0');
    elsif (rising_edge(clk)) then
      count_i <= count_i(6 downto 0) & feedback;
    end if;
  end process;
  count <= count_i;

end architecture;
