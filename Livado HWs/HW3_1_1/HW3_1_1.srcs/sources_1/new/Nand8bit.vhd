----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2017 11:48:36 AM
-- Design Name: 
-- Module Name: Nand8bit - Behavioral
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

entity Nand8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           Nandoutput : out STD_LOGIC_VECTOR (7 downto 0));
end Nand8bit;

architecture Behavioral of Nand8bit is

component SinglebitNand is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           singleoutput : out STD_LOGIC);
end component;
signal Nandsiglebitoutput: std_logic_vector(7 downto 0);
begin


NAND0: SinglebitNand Port Map (x=> input1(0), y=> input2(0), singleoutput=> Nandsiglebitoutput(0));
NAND1: SinglebitNand Port Map (x=> input1(1), y=> input2(1), singleoutput=> Nandsiglebitoutput(1));
NAND2: SinglebitNand Port Map (x=> input1(2), y=> input2(2), singleoutput=> Nandsiglebitoutput(2));
NAND3: SinglebitNand Port Map (x=> input1(3), y=> input2(3), singleoutput=> Nandsiglebitoutput(3));
NAND4: SinglebitNand Port Map (x=> input1(4), y=> input2(4), singleoutput=> Nandsiglebitoutput(4));
NAND5: SinglebitNand Port Map (x=> input1(5), y=> input2(5), singleoutput=> Nandsiglebitoutput(5));
NAND6: SinglebitNand Port Map (x=> input1(6), y=> input2(6), singleoutput=> Nandsiglebitoutput(6));
NAND7: SinglebitNand Port Map (x=> input1(7), y=> input2(7), singleoutput=> Nandsiglebitoutput(7));

Nandoutput <= Nandsiglebitoutput;

end Behavioral;
