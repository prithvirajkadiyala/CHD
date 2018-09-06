----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2017 04:26:16 PM
-- Design Name: 
-- Module Name: nandtwo - Behavioral
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

entity nandtwo is
    Port ( in_1 : in STD_LOGIC;
           in_2 : in STD_LOGIC;
           out1 : out STD_LOGIC);
end nandtwo;

architecture Behavioral of nandtwo is

begin

    out1 <= in_1 nand in_2;
    
end Behavioral;
