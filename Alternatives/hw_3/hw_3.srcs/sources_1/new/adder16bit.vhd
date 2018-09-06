----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2017 01:10:59 PM
-- Design Name: 
-- Module Name: adder16bit - Behavioral
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

entity adder16bit is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           c_in : in STD_LOGIC;
           c : out STD_LOGIC_VECTOR (15 downto 0);
           c_out : out STD_LOGIC);
end adder16bit;

architecture Behavioral of adder16bit is

component FullAdder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           c_in : in STD_LOGIC;
           sum : out STD_LOGIC;
           c_out : out STD_LOGIC);
end component;

signal sum: std_logic_vector(15 downto 0);
signal carry: std_logic_vector(15 downto 0);

begin

FA0: FullAdder Port Map (x=>a(0), y=>b(0),c_in=>'0',sum=>sum(0), c_out=>carry(0));
FA1: FullAdder Port Map (x=>a(1), y=>b(1),c_in=>carry(0),sum=>sum(1), c_out=>carry(1));
FA2: FullAdder Port Map (x=>a(2), y=>b(2),c_in=>carry(1),sum=>sum(2), c_out=>carry(2));
FA3: FullAdder Port Map (x=>a(3), y=>b(3),c_in=>carry(2),sum=>sum(3), c_out=>carry(3));
FA4: FullAdder Port Map (x=>a(4), y=>b(4),c_in=>carry(3),sum=>sum(4), c_out=>carry(4));
FA5: FullAdder Port Map (x=>a(5), y=>b(5),c_in=>carry(4),sum=>sum(5), c_out=>carry(5));
FA6: FullAdder Port Map (x=>a(6), y=>b(6),c_in=>carry(5),sum=>sum(6), c_out=>carry(6));
FA7: FullAdder Port Map (x=>a(7), y=>b(7),c_in=>carry(6),sum=>sum(7), c_out=>carry(7));
FA8: FullAdder Port Map (x=>a(8), y=>b(8),c_in=>carry(8),sum=>sum(8), c_out=>carry(8));
FA9: FullAdder Port Map (x=>a(9), y=>b(9),c_in=>carry(9),sum=>sum(9), c_out=>carry(9));
FA10: FullAdder Port Map (x=>a(10), y=>b(10),c_in=>carry(10),sum=>sum(10), c_out=>carry(10));
FA11: FullAdder Port Map (x=>a(11), y=>b(11),c_in=>carry(11),sum=>sum(11), c_out=>carry(11));
FA12: FullAdder Port Map (x=>a(12), y=>b(12),c_in=>carry(12),sum=>sum(12), c_out=>carry(12));
FA13: FullAdder Port Map (x=>a(13), y=>b(13),c_in=>carry(13),sum=>sum(13), c_out=>carry(13));
FA14: FullAdder Port Map (x=>a(14), y=>b(14),c_in=>carry(14),sum=>sum(14), c_out=>carry(14));
FA15: FullAdder Port Map (x=>a(15), y=>b(15),c_in=>carry(15),sum=>sum(15), c_out=>carry(15));


c <= sum;
c_out <= carry(15);


end Behavioral;
