----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2017 03:54:38 PM
-- Design Name: 
-- Module Name: nand8bits - Behavioral
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

entity nand8bits is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end nand8bits;

architecture Behavioral of nand8bits is

component nandtwo is
    Port ( in_1 : in STD_LOGIC;
           in_2 : in STD_LOGIC;
           out1 : out STD_LOGIC);
end component;

signal output: std_logic_vector(7 downto 0);

begin

NAND0: nandtwo Port Map (in_1 => a(0), in_2 =>b (0),out1 => output(0));
NAND1: nandtwo Port Map (in_1 => a(1), in_2 =>b (1),out1 => output(1));
NAND2: nandtwo Port Map (in_1 => a(2), in_2 =>b (2),out1 => output(2));
NAND3: nandtwo Port Map (in_1 => a(3), in_2 =>b (3),out1 => output(3));
NAND4: nandtwo Port Map (in_1 => a(4), in_2 =>b (4),out1 => output(4));
NAND5: nandtwo Port Map (in_1 => a(5), in_2 =>b (5),out1 => output(5));
NAND6: nandtwo Port Map (in_1 => a(6), in_2 =>b (6),out1 => output(6));
NAND7: nandtwo Port Map (in_1 => a(7), in_2 =>b (7),out1 => output(7));

y <= output;

end Behavioral;
