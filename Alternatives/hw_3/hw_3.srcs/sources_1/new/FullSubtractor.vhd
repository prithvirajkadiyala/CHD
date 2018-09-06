----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2017 03:15:40 PM
-- Design Name: 
-- Module Name: FullSubtractor - Behavioral
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

entity FullSubtractor is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           b_in : in STD_LOGIC;
           diff : out STD_LOGIC;
           b_out : out STD_LOGIC);
end FullSubtractor;

architecture Behavioral of FullSubtractor is

begin

    diff <= x xor y xor b_in;
    b_out <= (not(x) and b_in) or (not(x) and y) or (y and b_in);

end Behavioral;
