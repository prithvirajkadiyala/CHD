----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2017 12:48:29 AM
-- Design Name: 
-- Module Name: FullSubtract - Behavioral
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

entity FullSubtract is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           Bin : in STD_LOGIC;
           D : out STD_LOGIC;
           Bout : out STD_LOGIC);
end FullSubtract;

architecture Behavioral of FullSubtract is

begin

D <= (x xor y) xor Bin;
Bout <= ((not x) and y) or ((x xnor y) and Bin);

end Behavioral;
