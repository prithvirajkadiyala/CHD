----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 09:27:48 PM
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
    Port ( btnD : in STD_LOGIC;
           btnC: in std_logic;
           btnU : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           clk : in STD_LOGIC;
           an: out std_logic_vector(3 downto 0);
           seg: out std_logic_vector(6 downto 0);
           sw: in std_logic_vector(15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end toplevel;

architecture Behavioral of toplevel is
--New Components
component register8bit is
    Port ( d : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component BinaryToSevenSegment is
    Port ( binary_number : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;
component multiplier8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : out STD_LOGIC_VECTOR (15 downto 0);
           c_out : out STD_LOGIC);
end component;

component adder8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : out STD_LOGIC_VECTOR (7 downto 0);
           c_out : out STD_LOGIC);
end component;
component And8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Nand8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           Nandoutput : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Subtract8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Or8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Xor8bit is
    Port ( input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component lfsr1 is
  port (
    reset   : in  std_logic;
    clk     : in  std_logic; 
    count   : out std_logic_vector (7 downto 0)
  );
end component;
--Clock Counter
signal big_clock_counter : std_logic_vector(22 downto 0);
signal big_clock_counter_random: std_logic_vector(25 downto 0);
signal clk_slow : std_logic;
signal clk_random : std_logic;
signal rd_clk : std_logic;
signal wr_clk: std_logic;
signal command: std_logic_vector(3 downto 0);

--Addresses
signal store_src1 : std_logic_vector(3 downto 0);
signal store_src2 : std_logic_vector(3 downto 0);
signal src1_addr : std_logic_vector(3 downto 0);
signal src2_addr : std_logic_vector(3 downto 0);
signal dest_addr : std_logic_vector(3 downto 0);

--Register signals
signal sw_data_in: std_logic_vector(7 downto 0);
signal data_in: std_logic_vector(7 downto 0);
signal data_out1: std_logic_vector(7 downto 0);
signal data_out2: std_logic_vector(7 downto 0);
signal reg_mux1_out: std_logic_vector(7 downto 0);
signal reg_mux2_out: std_logic_vector(7 downto 0);
signal dest_enable: std_logic_vector(15 downto 0);

--Module Outputs
signal multiplier_out: std_logic_vector(15 downto 0);
signal multiplier_cout: std_logic;
signal get_module_outputs: std_logic_vector(7 downto 0);
signal adder_out: std_logic_vector(7 downto 0);
signal adder_cout: std_logic;
signal adderimm_out: std_logic_vector(7 downto 0);
signal adderimm_cout: std_logic;
signal andout: std_logic_vector(7 downto 0);
signal nandout: std_logic_vector(7 downto 0);
signal subout: std_logic_vector(7 downto 0);
signal orout : std_logic_vector(7 downto 0);
signal Pseudoout : std_logic_vector(7 downto 0);
signal xorout: std_logic_vector(7 downto 0);


--Registers
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

--Output to Seven Segment Display
signal binary_number : std_logic_vector(15 downto 0);

begin

sw_data_in <= sw(7 downto 0);

binary_number <= "00000000" & data_out1;

command <= sw(15 downto 12);

data_in <= sw_data_in when command="0000" else
           adder_out when command="0010" else
           adderimm_out when command="0011" else
           multiplier_out(7 downto 0) when command = "0100" else
           subout when command="0101" else
           nandout when command="0110" else
           andout when command="0111" else
           orout when command="1000" else
           Pseudoout when command="1001" else
           xorout when command="1010" else "00000000";
           
         
dest_addr <= sw(11 downto 8);

--Registers
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
                
SevenSegmentDriver: BinaryToSevenSegment Port Map (binary_number => binary_number, clk => clk, an => an,seg => seg);

Data_out_latch1:register8bit Port Map (d => reg_mux1_out, clk => rd_clk, en => '1', q => data_out1);

-- Data_out_latch2:register8bit Port Map (d => reg_mux2_out,clk => rd_clk,en => '1',q => data_out2);

Multiplier: multiplier8bit Port Map(a=>reg_mux1_out, b=>reg_mux2_out, c=> multiplier_out, c_out=> multiplier_cout);
Adder: adder8bit Port Map(a=>reg_mux1_out, b=>reg_mux2_out, c=>adder_out, c_out=>adder_cout);
AdderImm: adder8bit Port Map(a=>reg_mux1_out, b=>sw_data_in, c=>adderimm_out, c_out=>adderimm_cout);
Ander: And8bit Port Map(input1=>reg_mux1_out, input2=> reg_mux2_out, output=>andout);
Nander: Nand8bit Port Map(input1=>reg_mux1_out, input2=> reg_mux2_out, Nandoutput=>nandout);
Subtractor: Subtract8bit Port Map(input1=>reg_mux1_out, input2=> reg_mux2_out, output=>subout);
Orer: Or8bit Port Map(input1=>reg_mux1_out, input2=> reg_mux2_out, output=>orout);
Xorer: Xor8bit Port Map(input1=>reg_mux1_out, input2=> reg_mux2_out, output=>xorout);
Randomizer: lfsr1 Port Map (reset => btnC,clk => clk_random, count => Pseudoout);

wr_clk <= clk when command="0000" and btnC='1' else
          clk when command="0010" and btnC='1' else
          clk when command="0011" and btnC='1' else
          clk when command="0100" and btnC='1' else
          clk when command="0101" and btnC='1' else
          clk when command="0110" and btnC='1' else
          clk when command="0111" and btnC='1' else
          clk when command="1000" and btnC='1' else
          clk when command = "1001" else
          clk when command="1010" and btnC='1' else '0';
          
rd_clk <=   clk when command="0001" and btnC='1' else
            clk when command="0010" and btnC='1' else
            clk when command="0011" and btnC='1' else
            clk when command="0100" and btnC='1' else
            clk when command="0101" and btnC='1' else
            clk when command="0110" and btnC='1' else
            clk when command="0111" and btnC='1' else
            clk when command="1000" and btnC='1' else
            clk when command ="1001" else
            clk when command="1010" and btnC='1' else '0';          


led(15 downto 8) <= data_out1;

store_src1 <= src1_addr;

led(3 downto 0) <= store_src1;

store_src2 <= src2_addr;

led(7 downto 4) <= store_src2;

--Slow clock for Button click src addresses
process(clk)
begin
    if rising_edge(clk) then
        if big_clock_counter = "11011001111110111001001" then
            big_clock_counter <= (others => '0');
            clk_slow <= not clk_slow;
        else
            big_clock_counter <= std_logic_vector(unsigned(big_clock_counter) + "1");
        end if; 
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if big_clock_counter_random = "11011001111110111001001110" then
            big_clock_counter_random <= (others => '0');
            clk_random <= not clk_random;
        else
            big_clock_counter_random <= std_logic_vector(unsigned(big_clock_counter_random) + "1");
        end if; 
    end if;
end process;

--Procedure to access src addresses
process(clk_slow)
begin
    if rising_edge(clk_slow) then
        if btnU = '1' then
            if src1_addr<"1111" then
                src1_addr<= std_logic_vector(unsigned(src1_addr) + 1);
                store_src1 <=  src1_addr;
                led(3 downto 0)<= store_src1;
            elsif src1_addr="1111" then
                src1_addr <= "0000";
                store_src1 <= src1_addr;
                led(3 downto 0)<= store_src1;
            end if;
       elsif btnD = '1' then
            if src1_addr>"0000" then
               src1_addr <= std_logic_vector(unsigned(src1_addr) - 1);
               store_src1 <=  src1_addr;
               led(3 downto 0)<= store_src1;
           elsif src1_addr="0000" then
               src1_addr <= "1111";
               store_src1 <=  src1_addr;
               led(3 downto 0)<= store_src1;
           end if;
       elsif btnR = '1' then
            if src2_addr<"1111" then
                  src2_addr <= std_logic_vector(unsigned(src2_addr) + 1);
                  store_src2 <= src2_addr;
                  led(7 downto 4)<= store_src2;
              elsif src2_addr="1111" then
                  src2_addr <= "0000";
                  store_src2 <= src2_addr;
                  led(7 downto 4)<= store_src2;
              end if;
       elsif btnL = '1' then
            if src2_addr>"0000" then
                 src2_addr <= std_logic_vector(unsigned(src2_addr) - 1);
                 store_src2 <= src2_addr;
                 led(7 downto 4)<= store_src2;
             elsif src2_addr="0000" then
                 src2_addr <= "1111";
                 store_src2 <= src2_addr;
                 led(7 downto 4)<= store_src2;
             end if;
        end if;
      end if;
end process;

--Destination Select
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

--Source select1
reg_mux1_out <=  reg_out_0 when store_src1 = "0000" else
                reg_out_1 when store_src1 = "0001" else
                reg_out_2 when store_src1 = "0010" else
                reg_out_3 when store_src1 = "0011" else
                reg_out_4 when store_src1 = "0100" else
                reg_out_5 when store_src1 = "0101" else
                reg_out_6 when store_src1 = "0110" else
                reg_out_7 when store_src1 = "0111" else
                reg_out_8 when store_src1 = "1000" else
                reg_out_9 when store_src1 = "1001" else
                reg_out_10 when store_src1 = "1010" else
                reg_out_11 when store_src1 = "1011" else
                reg_out_12 when store_src1 = "1100" else
                reg_out_13 when store_src1 = "1101" else
                reg_out_14 when store_src1 = "1110" else
                reg_out_15 when store_src1 = "1111";

----Source Select2
reg_mux2_out <=  reg_out_0 when store_src2 = "0000" else
                reg_out_1 when store_src2 = "0001" else
                reg_out_2 when store_src2 = "0010" else
                reg_out_3 when store_src2 = "0011" else
                reg_out_4 when store_src2 = "0100" else
                reg_out_5 when store_src2 = "0101" else
                reg_out_6 when store_src2 = "0110" else
                reg_out_7 when store_src2 = "0111" else
                reg_out_8 when store_src2 = "1000" else
                reg_out_9 when store_src2 = "1001" else
                reg_out_10 when store_src2 = "1010" else
                reg_out_11 when store_src2 = "1011" else
                reg_out_12 when store_src2 = "1100" else
                reg_out_13 when store_src2 = "1101" else
                reg_out_14 when store_src2 = "1110" else
                reg_out_15 when store_src2 = "1111";
                
end Behavioral;
