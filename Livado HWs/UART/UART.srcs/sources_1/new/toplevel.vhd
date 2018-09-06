----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 06:13:28 PM
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
    Port ( --tx : out STD_LOGIC;
           rx : in STD_LOGIC;
           clk : in STD_LOGIC;
           sw: in std_logic_vector(15 downto 0);
           an: out std_logic_vector(3 downto 0);
           btnC : in std_logic;
           seg: out std_logic_vector(6 downto 0));
end toplevel;

architecture Behavioral of toplevel is
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
--Clock Divide Signals
signal clk_counter: std_logic_vector(9 downto 0);
signal clk_153600: std_logic;
signal big_clock_counter_random: std_logic_vector(25 downto 0);
signal clk_random : std_logic;




--UART Recieve Signals
type uart_rx_states IS (stIdle, stStartBit, stReadBits, stStopBit, stWrite);
signal uart_rx_state: uart_rx_states;

signal half_bit_counter: std_logic_vector(2 downto 0);
signal full_bit_counter_rx: std_logic_vector(3 downto 0);
signal byte_counter: std_logic_vector(2 downto 0);

signal rx_data: std_logic_vector(7 downto 0);

--Module Inputs and Outputs
signal input1: std_logic_vector(7 downto 0);
signal input2: std_logic_vector(7 downto 0);
signal output: std_logic_vector(7 downto 0);
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

--Instruction set
signal instruction : std_logic_vector(31 downto 0);


type register_file is array (0 to 15) of std_logic_vector(7 downto 0);
signal registers: register_file;

--Fifo Read States
type fifo_Read_states IS (stIdle, stRead, stCompute);
signal fifo_read_state: fifo_read_states;

--Fifo Transmit states
type uart_tx_states IS (stIdle, stLoopBytes, stWriteBits);
signal uart_tx_state: uart_tx_states;

signal full_bit_counter_tx: std_logic_vector(3 downto 0);
signal ten_bit_counter: std_logic_vector(3 downto 0);
signal tx_data: std_logic_vector(9 downto 0);

signal btnc_shift_reg: std_logic_vector(15 downto 0);

type fifo_write_states IS (stIdle, stWrite);
signal fifo_write_state: fifo_write_states;

signal display_value : std_logic_vector(15 downto 0);

COMPONENT fifo_generator_0
  PORT (
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;


signal fifo_din: std_logic_vector(7 downto 0);
signal fifo_we: std_logic;
signal fifo_full: std_logic;
signal fifo_dout: std_logic_vector(31 downto 0);
signal fifo_re: std_logic;
signal fifo_empty: std_logic;

signal four_byte_counter: std_logic_vector(2 downto 0);

begin

tx_fifo: fifo_generator_0 Port Map (wr_clk => clk_153600,
                                        rd_clk  => clk_153600,
                                        din  => fifo_din,
                                        wr_en  => fifo_we,
                                        rd_en  => fifo_re,
                                        dout  => fifo_dout,
                                        full  => fifo_full,
                                        empty  => fifo_empty);

display : BinaryToSevenSegment Port Map(binary_number=>display_value, clk=>clk, an=>an, seg=>seg);

Multiplier: multiplier8bit Port Map(a=>input1, b=>input2, c=> multiplier_out, c_out=> multiplier_cout);
Adder: adder8bit Port Map(a=>input1, b=>input2, c=>adder_out, c_out=>adder_cout);
AdderImm: adder8bit Port Map(a=>input1, b=>input2, c=>adderimm_out, c_out=>adderimm_cout);
Ander: And8bit Port Map(input1=>input1, input2=> input2, output=>andout);
Nander: Nand8bit Port Map(input1=>input1, input2=> input2, Nandoutput=>nandout);
Subtractor: Subtract8bit Port Map(input1=>input1, input2=> input2, output=>subout);
Orer: Or8bit Port Map(input1=>input1, input2=> input2, output=>orout);
Xorer: Xor8bit Port Map(input1=>input1, input2=> input2, output=>xorout);
Randomizer: lfsr1 Port Map (reset => btnC,clk => clk_random, count => Pseudoout);

-- count to 651 1010001011
--326 high 101000110
--325 low 101000101
-- generate 153600 Hz clk approx
process(clk)
begin
    if rising_edge(clk) then
    
        if clk_counter = "1010001011" then 
            clk_counter <= (others => '0');
        else
            clk_counter <= std_logic_vector(unsigned(clk_counter) + 1);
        end if;
        
        if clk_counter < "0101000110" then
            clk_153600 <= '1';
        else
            clk_153600 <= '0';
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


process(clk_153600)
begin
    if rising_edge(clk_153600) then
    
        case uart_rx_state is
        
            when stIdle =>
            
                fifo_we <= '0';
            
                if rx = '0' then
                    half_bit_counter <= "111";
                    uart_rx_state <= stStartBit;
                else
                    uart_rx_state <= stIdle;
                end if;
            
            when stStartBit =>
            
                if half_bit_counter = "000" then
                    rx_data <= "00000000";
                    full_bit_counter_rx <= "1111";
                    byte_counter <= "111";
                    uart_rx_state <= stReadBits;
                else
                    half_bit_counter <= std_logic_vector(unsigned(half_bit_counter) - 1);
                    uart_rx_state <= stStartBit;
                end if;
            
            when stReadBits =>
            
                if full_bit_counter_rx = "0000" then
                
                    rx_data <= rx & rx_data(7 downto 1);
                
                    full_bit_counter_rx <= "1111"; 
    
                    if byte_counter = "000" then
                        uart_rx_state <= stStopBit;
                    else
                        byte_counter <= std_logic_vector(unsigned(byte_counter) - 1);
                        uart_rx_state <= stReadBits;
                    end if;
                else
                    full_bit_counter_rx <= std_logic_vector(unsigned(full_bit_counter_rx) - 1);
                    uart_rx_state <= stReadBits;
                end if;
            
            when stStopBit =>
            
                if full_bit_counter_rx = "0000" then
                    if rx = '1' then
                        fifo_din <= rx_data;
                    else
                        null;
                    end if;
                    
                    uart_rx_state <= stWrite;
                else
                    full_bit_counter_rx <= std_logic_vector(unsigned(full_bit_counter_rx) - 1);
                    uart_rx_state <= stStopBit;
                end if;
                
            when stWrite =>
                            
                if fifo_full = '1' then
                    fifo_we <= '0';
                    uart_rx_state <= stWrite;             
                else
                    fifo_we <= '1';
                    uart_rx_state <= stIdle;
                end if;
            
        end case;
    
    end if;
end process;

process(clk)
variable src1 : std_logic_vector(3 downto 0);
variable src2 : std_logic_vector(3 downto 0);
variable dest : std_logic_vector(3 downto 0);
variable opcode : std_logic_vector(3 downto 0);
variable value: std_logic_vector(15 downto 0);

begin

    if rising_edge(clk) then
        case fifo_read_state is
            when stIdle =>
                fifo_re <= '0';
                
                if fifo_empty = '0' then
                    fifo_re <='1';
                    fifo_read_state <= stRead;
                else
                    fifo_read_state <= stIdle;
                end if;
             
             when stRead =>
                fifo_re <='0';
                instruction <= fifo_dout;
                fifo_read_state <= stCompute;
             
             when stCompute =>
    
                src1 := instruction(23 downto 20);
                src2 := instruction(19 downto 16);
                dest := instruction(27 downto 24);
                opcode := instruction(31 downto 28);
                value := instruction(15 downto 0);
                
                
                case opcode is   
                    
                    --Store Value
                    when "0000" =>
                        registers(to_integer(unsigned(dest))) <= value;
                        
                    --Read Value
                    when "0001" =>
                        display_value <= "00000000" & registers(to_integer(unsigned(src1)));
                    
                    --Add
                    when "0010" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= adder_out;
                    
                    --Add Immediate
                    when "0011" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= value(7 downto 0);
                        registers(to_integer(unsigned(dest))) <= adderimm_out;
                    
                    --Multiplier
                    when "0100" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= multiplier_out(7 downto 0); 
                    
                    --Subtract
                    when "0101" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= subout; 
                    
                    --NAND
                    when "0110" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= Nandout; 
                                            
                    --AND
                    when "0111" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= Andout; 
                    
                    --OR
                    when "1000" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= orout; 
                    
                    --PseudoRandom Number
                    when "1001" =>
                        display_value <=  "00000000" & Pseudoout;
                    
                    --XOR
                    when "1010" =>
                        input1 <= registers(to_integer(unsigned(src1)));
                        input2 <= registers(to_integer(unsigned(src2)));
                        registers(to_integer(unsigned(dest))) <= xorout;  
                                                                                                                          
                    when others =>
                        null;
                 end case;
                 fifo_read_state <= stIdle;
             end case;
                                    
    end if;
end process;

--process(clk_153600)
--begin
--    if rising_edge(clk_153600) then
    
--        case uart_tx_state is
        
--            when stIdle =>
            
--                tx <= '1';
--                fifo_re <= '0';
            
--                if fifo_empty = '0' then
--                    four_byte_counter <= "100";
--                    fifo_re <= '1';
--                    uart_tx_state <= stLoopBytes;
--                else
--                    uart_tx_state <= stIdle;
--                end if;

--            when stLoopBytes =>
           
--                fifo_re <= '0';
           
--                if four_byte_counter = "000" then
--                    uart_tx_state <= stIdle;
--                else
--                    if four_byte_counter = "100" then
--                        tx_data <= '1' & fifo_dout(31 downto 24) & '0';
--                    elsif four_byte_counter = "011" then
--                        tx_data <= '1' & fifo_dout(23 downto 16) & '0';  
--                    elsif four_byte_counter = "010" then
--                        tx_data <= '1' & fifo_dout(15 downto 8) & '0';
--                    elsif four_byte_counter = "001" then
--                        tx_data <= '1' & fifo_dout(7 downto 0) & '0';
--                    end if;
                    
--                    full_bit_counter_tx <= "1111";
--                    ten_bit_counter <= "1001";
--                    uart_tx_state <= stWriteBits;
--                end if;

--            when stWriteBits =>
                
--                fifo_re <= '0';
                
--                if full_bit_counter_tx = "0000" then
                
--                    tx <= tx_data(0);
--                    tx_data(8 downto 0) <= tx_data(9 downto 1);
                    
--                    full_bit_counter_tx <= "1111"; 
    
--                    if ten_bit_counter = "0000" then
--                        four_byte_counter <= std_logic_vector(unsigned(four_byte_counter) - 1);
--                        uart_tx_state <= stLoopBytes;
--                    else
--                        ten_bit_counter <= std_logic_vector(unsigned(ten_bit_counter) - 1);
--                        uart_tx_state <= stWriteBits;
--                    end if;
--                else
--                    full_bit_counter_tx <= std_logic_vector(unsigned(full_bit_counter_tx) - 1);
--                    uart_tx_state <= stWriteBits;
--                end if;

--        end case;
    
--    end if;
--end process;

end Behavioral;
