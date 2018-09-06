----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2017 06:29:28 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end toplevel;

architecture Behavioral of toplevel is

component BinaryToSevenSegment is
    Port ( binary_number : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component adder8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : out STD_LOGIC_VECTOR (7 downto 0);
           c_out : out STD_LOGIC);
end component;

signal adder_out: std_logic_vector(7 downto 0);
signal binary_number: std_logic_vector(15 downto 0);

begin

binary_number <= "00000000" & adder_out;

SevenSegmentDriver: BinaryToSevenSegment Port Map (binary_number => binary_number,
                                                   clk => clk,
                                                   an => an,
                                                   seg => seg);

ADDER: adder8bit Port Map ( a => sw(15 downto 8),
                            b => sw(7 downto 0),
                            c => adder_out,
                            c_out => led(15));
                          
led(14 downto 0) <= (others => '0');

end Behavioral;
