----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2017 03:36:37 PM
-- Design Name: 
-- Module Name: or8bit - Behavioral
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

entity or8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end or8bit;

architecture Behavioral of or8bit is

component ortwo is
    Port ( in_1 : in STD_LOGIC;
           in_2 : in STD_LOGIC;
           outor : out STD_LOGIC);
end component;

signal output: std_logic_vector(7 downto 0);

begin

OR0: ortwo Port Map (in_1 => a(0), in_2 =>b (0),outor => output(0));
OR1: ortwo Port Map (in_1 => a(1), in_2 =>b (1),outor => output(1));
OR2: ortwo Port Map (in_1 => a(2), in_2 =>b (2),outor => output(2));
OR3: ortwo Port Map (in_1 => a(3), in_2 =>b (3),outor => output(3));
OR4: ortwo Port Map (in_1 => a(4), in_2 =>b (4),outor => output(4));
OR5: ortwo Port Map (in_1 => a(5), in_2 =>b (5),outor => output(5));
OR6: ortwo Port Map (in_1 => a(6), in_2 =>b (6),outor => output(6));
OR7: ortwo Port Map (in_1 => a(7), in_2 =>b (7),outor => output(7));

y <= output;

end Behavioral;
