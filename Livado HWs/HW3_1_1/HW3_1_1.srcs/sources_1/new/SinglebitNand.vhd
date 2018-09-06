----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2017 11:53:36 AM
-- Design Name: 
-- Module Name: SinglebitNand - Behavioral
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

entity SinglebitNand is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           singleoutput : out STD_LOGIC);
end SinglebitNand;

architecture Behavioral of SinglebitNand is

begin
singleoutput <= x nand y;

end Behavioral;
