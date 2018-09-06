----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2017 06:05:04 PM
-- Design Name: 
-- Module Name: and8bit - Behavioral
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

entity and8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end and8bit;

architecture Behavioral of and8bit is

component andtwo is
    Port ( in_1 : in STD_LOGIC;
           in_2 : in STD_LOGIC;
           outand : out STD_LOGIC);
end component;

signal output: std_logic_vector(7 downto 0);

begin

AND0: andtwo Port Map (in_1 => a(0), in_2 =>b (0),outand => output(0));
AND1: andtwo Port Map (in_1 => a(1), in_2 =>b (1),outand => output(1));
AND2: andtwo Port Map (in_1 => a(2), in_2 =>b (2),outand => output(2));
AND3: andtwo Port Map (in_1 => a(3), in_2 =>b (3),outand => output(3));
AND4: andtwo Port Map (in_1 => a(4), in_2 =>b (4),outand => output(4));
AND5: andtwo Port Map (in_1 => a(5), in_2 =>b (5),outand => output(5));
AND6: andtwo Port Map (in_1 => a(6), in_2 =>b (6),outand => output(6));
AND7: andtwo Port Map (in_1 => a(7), in_2 =>b (7),outand => output(7));

y <= output;


end Behavioral;
