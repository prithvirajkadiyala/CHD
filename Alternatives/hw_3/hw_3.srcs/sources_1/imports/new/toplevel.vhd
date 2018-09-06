----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/26/2017 06:16:43 PM
-- Design Name: 
-- Module Name: toplevel - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           btnR : in STD_LOGIC;
           btnL : in STD_LOGIC;
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end toplevel;

architecture Behavioral of toplevel is

component BinaryToSevenSegment is
    Port ( binary_number : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component register8bit is
    Port ( d : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (7 downto 0));
end component;


signal rd_clk : std_logic;
signal data_out: std_logic_vector(7 downto 0);
signal sevenseginput: std_logic_vector(7 downto 0);
signal reg_mux_out: std_logic_vector(7 downto 0);

signal wr_clk: std_logic;
signal data_in: std_logic_vector(7 downto 0);
signal dest_enable: std_logic_vector(15 downto 0);

signal cmd: std_logic_vector(3 downto 0);
signal add1: std_logic_vector(3 downto 0);
signal add2: std_logic_vector(3 downto 0);
signal destadd: std_logic_vector(3 downto 0);

signal reg_out_0: std_logic_vector(7 downto 0);
signal reg_out_1: std_logic_vector(7 downto 0);
signal reg_out_2: std_logic_vector(7 downto 0);
signal reg_out_3: std_logic_vector(7 downto 0);
signal reg_out_4: std_logic_vector(7 downto 0);
signal reg_out_5: std_logic_vector(7 downto 0);
signal reg_out_6: std_logic_vector(7 downto 0);
signal reg_out_7: std_logic_vector(7 downto 0);
signal reg_out_8: std_logic_vector(7 downto 0);
signal reg_out_9: std_logic_vector(7 downto 0);
signal reg_out_10: std_logic_vector(7 downto 0);
signal reg_out_11: std_logic_vector(7 downto 0);
signal reg_out_12: std_logic_vector(7 downto 0);
signal reg_out_13: std_logic_vector(7 downto 0);
signal reg_out_14: std_logic_vector(7 downto 0);
signal reg_out_15: std_logic_vector(7 downto 0);

signal src_addr : std_logic_vector(3 downto 0);
signal dest_addr : std_logic_vector(3 downto 0);

signal binary_number : std_logic_vector(15 downto 0);

begin

add1 <= "0000";
add2 <= "0000";

binary_number <= "00000000" & sevenseginput;
sevenseginput <= "0000" & add1 when btnU='1'else
            "0000" & add1 when btnD='1' else
            "0000" & add2 when btnR ='1' else
            "0000" & add2 when btnL='1' else data_out;
            
SevenSegmentDriver: BinaryToSevenSegment Port Map (binary_number => binary_number,
                                                   clk => clk,
                                                   an => an,
                                                   seg => seg);

data_out_latch:register8bit Port Map (d => reg_mux_out,
                                      clk => rd_clk,
                                      en => '1',
                                      q => data_out);
process(clk)
    begin
      if btnU = '1' then
        add1(3 downto 0) <= std_logic_vector(unsigned(add1(3 downto 0)) + "1");  
            if add1="1111" then
                add1 <= "0000";
            end if;  
       elsif btnD = '1' then
                    add1(3 downto 0) <= std_logic_vector(unsigned(add1(3 downto 0)) - "1");  
                        if add1="0000" then
                            add1 <= "1111";
                        end if; 
        elsif btnR = '1' then
                    add2(3 downto 0) <= std_logic_vector(unsigned(add2(3 downto 0)) + "1");  
                        if add2="1111" then
                            add2 <= "0000";
                        end if; 
       elsif btnL = '1' then
                    add2(3 downto 0) <= std_logic_vector(unsigned(add2(3 downto 0)) - "1");  
                        if add2="0000" then
                            add2 <= "1111";
                        end if;  
      end if;
    end process;


cmd <= sw(15 downto 12);
dest_addr <= sw(11 downto 8);
data_in <= sw(7 downto 0);
--src_addr <= sw(15 downto 12);
--dest_addr <= sw(11 downto 8);
--cmd <= sw(15 downto 12);
--add1 <= sw(11 downto 8);
--add2 <= sw(7 downto 4);
--destadd <= sw(3 downto 0);

wr_clk <= '1';
rd_clk <= '1';
--wr_clk <= '1' when btnU='1' else
--          '1' when btnD='1' else
--          '1' when btnL='1' else '0';
--            btnU when sw(15 downto 12) = "0010" else '0';
--dest_addr <= sw(11 downto 8) when sw(15 downto 12) = "0001" else "0000";

--rd_clk <= '1' when btnR='1' else
--          '1' when btnD='1' else '0';
--          '1' when btnL='1' else '0';
--rd_clk <= btnC when sw(15 downto 12) = "0010" else '0';
--src_addr <= sw(11 downto 8) when sw(15 downto 12) = "0010" else "0000";

--data_in <= "00000000" when btnL = '1' else
--           reg_mux_out when btnD = '1' else sw(7 downto 0); 

reg0:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(0),q => reg_out_0);      
reg1:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(1),q => reg_out_1);
reg2:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(2),q => reg_out_2);      
reg3:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(3),q => reg_out_3);
reg4:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(4),q => reg_out_4);      
reg5:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(5),q => reg_out_5);
reg6:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(6),q => reg_out_6);      
reg7:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(7),q => reg_out_7);
reg8:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(8),q => reg_out_8);      
reg9:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(9),q => reg_out_9);
reg10:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(10),q => reg_out_10);      
reg11:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(11),q => reg_out_11);
reg12:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(12),q => reg_out_12);      
reg13:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(13),q => reg_out_13);
reg14:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(14),q => reg_out_14);      
reg15:register8bit Port Map (d => data_in,clk => wr_clk,en => dest_enable(15),q => reg_out_15);                      

dest_enable <=  "0000000000000001" when dest_addr = "0000" else
                "0000000000000010" when dest_addr = "0001" else
                "0000000000000100" when dest_addr = "0010" else
                "0000000000001000" when dest_addr = "0011" else
                "0000000000010000" when dest_addr = "0100" else
                "0000000000100000" when dest_addr = "0101" else
                "0000000001000000" when dest_addr = "0110" else
                "0000000010000000" when dest_addr = "0111" else
                "0000000100000000" when dest_addr = "1000" else
                "0000001000000000" when dest_addr = "1001" else
                "0000010000000000" when dest_addr = "1010" else
                "0000100000000000" when dest_addr = "1011" else
                "0001000000000000" when dest_addr = "1100" else
                "0010000000000000" when dest_addr = "1101" else
                "0100000000000000" when dest_addr = "1110" else
                "1000000000000000" when dest_addr = "1111";

reg_mux_out <=  reg_out_0 when src_addr = "0000" else
                reg_out_1 when src_addr = "0001" else
                reg_out_2 when src_addr = "0010" else
                reg_out_3 when src_addr = "0011" else
                reg_out_4 when src_addr = "0100" else
                reg_out_5 when src_addr = "0101" else
                reg_out_6 when src_addr = "0110" else
                reg_out_7 when src_addr = "0111" else
                reg_out_8 when src_addr = "1000" else
                reg_out_9 when src_addr = "1001" else
                reg_out_10 when src_addr = "1010" else
                reg_out_11 when src_addr = "1011" else
                reg_out_12 when src_addr = "1100" else
                reg_out_13 when src_addr = "1101" else
                reg_out_14 when src_addr = "1110" else
                reg_out_15 when src_addr = "1111";
end Behavioral;