----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2017 03:23:55 PM
-- Design Name: 
-- Module Name: Subtract - Behavioral
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
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : out STD_LOGIC_VECTOR (7 downto 0);
           b_out : out STD_LOGIC);
end Subtract8bit;

architecture Behavioral of Subtract8bit is

component FullSubtractor is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           b_in : in STD_LOGIC;
           diff : out STD_LOGIC;
           b_out : out STD_LOGIC);
end component;

signal diff: std_logic_vector(7 downto 0);
signal borrow: std_logic_vector(7 downto 0);

begin

FS0: FullSubtractor Port Map (x=>a(0), y=>b(0),b_in=>'0',diff=>diff(0), b_out=>borrow(0));
FS1: FullSubtractor Port Map (x=>a(1), y=>b(1),b_in=>borrow(0),diff=>diff(1), b_out=>borrow(1));
FS2: FullSubtractor Port Map (x=>a(2), y=>b(2),b_in=>borrow(1),diff=>diff(2), b_out=>borrow(2));
FS3: FullSubtractor Port Map (x=>a(3), y=>b(3),b_in=>borrow(2),diff=>diff(3), b_out=>borrow(3));
FS4: FullSubtractor Port Map (x=>a(4), y=>b(4),b_in=>borrow(3),diff=>diff(4), b_out=>borrow(4));
FS5: FullSubtractor Port Map (x=>a(5), y=>b(5),b_in=>borrow(4),diff=>diff(5), b_out=>borrow(5));
FS6: FullSubtractor Port Map (x=>a(6), y=>b(6),b_in=>borrow(5),diff=>diff(6), b_out=>borrow(6));
FS7: FullSubtractor Port Map (x=>a(7), y=>b(7),b_in=>borrow(6),diff=>diff(7), b_out=>borrow(7));


c <= diff;
b_out <= borrow(7);

end Behavioral;
