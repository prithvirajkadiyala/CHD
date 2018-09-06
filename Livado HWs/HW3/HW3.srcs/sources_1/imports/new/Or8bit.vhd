----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2017 12:44:50 PM
-- Design Name: 
-- Module Name: And8bit - Behavioral
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

entity Or8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end Or8bit;

architecture Behavioral of Or8bit is

component OrSinleBit is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           z : out STD_LOGIC);
end component;
signal singlebitoutputs: std_logic_vector(7 downto 0);

begin

O0: OrSinleBit Port Map(x=>input1(0), y=>input2(0), z=> singlebitoutputs(0));
O1: OrSinleBit Port Map(x=>input1(1), y=>input2(1), z=> singlebitoutputs(1));
O2: OrSinleBit Port Map(x=>input1(2), y=>input2(2), z=> singlebitoutputs(2));
O3: OrSinleBit Port Map(x=>input1(3), y=>input2(3), z=> singlebitoutputs(3));
O4: OrSinleBit Port Map(x=>input1(4), y=>input2(4), z=> singlebitoutputs(4));
O5: OrSinleBit Port Map(x=>input1(5), y=>input2(5), z=> singlebitoutputs(5));
O6: OrSinleBit Port Map(x=>input1(6), y=>input2(6), z=> singlebitoutputs(6));
O7: OrSinleBit Port Map(x=>input1(7), y=>input2(7), z=> singlebitoutputs(7));

output <= singlebitoutputs;
end Behavioral;
