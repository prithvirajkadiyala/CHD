----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2017 06:26:58 PM
-- Design Name: 
-- Module Name: multiplier8bit - Behavioral
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

entity multiplier8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : out STD_LOGIC_VECTOR (15 downto 0);
           c_out : out STD_LOGIC);
end multiplier8bit;

architecture Behavioral of multiplier8bit is

component adder8bit is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           c_in : in STD_LOGIC;
           c : out STD_LOGIC_VECTOR (15 downto 0);
           c_out : out STD_LOGIC);
end component;

signal t0: std_logic_vector(15 downto 0);
signal t1: std_logic_vector(15 downto 0);
signal t2: std_logic_vector(15 downto 0);
signal t3: std_logic_vector(15 downto 0);
signal t4: std_logic_vector(15 downto 0);
signal t5: std_logic_vector(15 downto 0);
signal t6: std_logic_vector(15 downto 0);
signal t7: std_logic_vector(15 downto 0);

signal sum_01: std_logic_vector(15 downto 0);
signal sum_23: std_logic_vector(15 downto 0);
signal sum_45: std_logic_vector(15 downto 0);
signal sum_67: std_logic_vector(15 downto 0);

signal sum_0123: std_logic_vector(15 downto 0);
signal sum_4567: std_logic_vector(15 downto 0);

signal cout_01: std_logic;
signal cout_23: std_logic;
signal cout_45: std_logic;
signal cout_67: std_logic;

signal cout_0123: std_logic;
signal cout_4567: std_logic;

begin

t0 <=  "00000000" & (a and (b(0) & b(0) & b(0) & b(0) & b(0) & b(0) & b(0) & b(0)));
t1 <=  "0000000" & (a and (b(1) & b(1) & b(1) & b(1) & b(1) & b(1) & b(1) & b(1))) & "0";
t2 <=  "000000" & (a and (b(2) & b(2) & b(2) & b(2) & b(2) & b(2) & b(2) & b(2))) & "00";
t3 <=  "00000" & (a and (b(3) & b(3) & b(3) & b(3) & b(3) & b(3) & b(3) & b(3))) & "000";
t4 <=  "0000" & (a and (b(4) & b(4) & b(4) & b(4) & b(4) & b(4) & b(4) & b(4))) & "0000";
t5 <=  "000" & (a and (b(5) & b(5) & b(5) & b(5) & b(5) & b(5) & b(5) & b(5))) & "00000";
t6 <=  "00" & (a and (b(6) & b(6) & b(6) & b(6) & b(6) & b(6) & b(6) & b(6))) & "000000";
t7 <=  "0" & (a and (b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7))) & "0000000";


adder_01: adder8bit Port Map (a=>t0, b=>t1, c_in=>'0', c=>sum_01, c_out=>cout_01);
adder_23: adder8bit Port Map (a=>t2, b=>t3, c_in=>'0', c=>sum_23, c_out=>cout_23);
adder_45: adder8bit Port Map (a=>t4, b=>t5, c_in=>'0', c=>sum_45, c_out=>cout_45);
adder_67: adder8bit Port Map (a=>t6, b=>t7, c_in=>'0', c=>sum_67, c_out=>cout_67);

adder_0123: adder8bit Port Map (a=>sum_01, b=>sum_23, c_in=>'0', c=>sum_0123, c_out=>cout_0123);
adder_4567: adder8bit Port Map (a=>sum_45, b=>sum_67, c_in=>'0', c=>sum_4567, c_out=>cout_4567);

adder_01234567: adder8bit Port Map (a=>sum_0123, b=>sum_4567, c_in=>cout_4567, c=>c, c_out=>c_out);




end Behavioral;
