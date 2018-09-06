----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2017 01:22:47 AM
-- Design Name: 
-- Module Name: Subtract8bit - Behavioral
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

entity Subtract8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end Subtract8bit;

architecture Behavioral of Subtract8bit is
component FullSubtract is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           Bin : in STD_LOGIC;
           D : out STD_LOGIC;
           Bout : out STD_LOGIC);
end component;

signal D: std_logic_vector(7 downto 0);
signal Bout: std_logic_vector(7 downto 0);
begin

FS0: FullSubtract Port Map (x=> input1(0), y=>input2(0), Bin=>'0', D=>D(0), Bout=>Bout(0));
FS1: FullSubtract Port Map (x=> input1(1), y=>input2(1), Bin=>Bout(0), D=>D(1), Bout=>Bout(1));
FS2: FullSubtract Port Map (x=> input1(2), y=>input2(2), Bin=>Bout(1), D=>D(1), Bout=>Bout(2));
FS3: FullSubtract Port Map (x=> input1(3), y=>input2(3), Bin=>Bout(2), D=>D(1), Bout=>Bout(3));
FS4: FullSubtract Port Map (x=> input1(4), y=>input2(4), Bin=>Bout(3), D=>D(1), Bout=>Bout(4));
FS5: FullSubtract Port Map (x=> input1(5), y=>input2(5), Bin=>Bout(4), D=>D(1), Bout=>Bout(5));
FS6: FullSubtract Port Map (x=> input1(6), y=>input2(6), Bin=>Bout(5), D=>D(1), Bout=>Bout(6));
FS7: FullSubtract Port Map (x=> input1(7), y=>input2(7), Bin=>Bout(6), D=>D(1), Bout=>Bout(7));

output <= D;

end Behavioral;
