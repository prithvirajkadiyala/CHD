----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 06:08:54 PM
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
  Port (tx: out STD_LOGIC;
        rx: in STD_LOGIC;
        clk: in STD_LOGIC;
        led: out STD_LOGIC_vector(15 downto 0)
   );
end toplevel;

architecture Behavioral of toplevel is
signal clk_counter: std_logic_vector(9 downto 0);
signal clk_153600: std_logic;
type uart_rx_states IS (stIdle, stStartBit, stReadBits, stStopBit);
signal uart_rx_state : uart_rx_states;
signal half_bit_counter : std_logic_vector(2 downto 0);
signal full_bit_counter: std_logic_vector(3 downto 0);
signal byte_counter: std_logic_vector(2 downto 0);
signal rx_data : std_logic_vector(7 downto 0);

begin

tx <= '1';


--count to 651 1010001011
--326 high 101000110
--325 low  101000101
--generate 153600 clk rate
process(clk)
begin
 if rising_edge(clk) then
    if clk_counter="1010001011" then
        clk_counter <= (others=> '0');
    else
        clk_counter <= std_logic_vector(unsigned(clk_counter) + "1");
    end if;
    
    if clk_counter < "0101000110" then
        clk_153600 <= '1';
    else 
        clk_153600 <='0';
    end if;
    
 end if;
end process;

process(clk_153600)
begin
    if rising_edge(clk_153600) then
        case uart_rx_state is
        
        when stIdle =>
            if rx='0' then
                half_bit_counter <= "111";
                uart_rx_state <= stStartBit;
            else
                uart_rx_state <= stIdle;
            end if;
        when stStartBit =>
            if half_bit_counter = "000" then
                full_bit_counter <="1111";
                byte_counter <= "1000";
                uart_rx_state <= stReadBits;
            else
                half_bit_counter <= std_logic_vector(unsigned(half_bit_counter) - 1);
                uart_rx_state <= stStartBit;
            end if;
        when stReadBits =>
            if full_bit_counter= "0000" then
                rx_data <= rx_data(6 downto 0) & rx;
                
                if byte_counter="0000" then
                    full_bit_counter <= "0000";
                    uart_rx_state <= stStopBit;
                else
                    byte_counter <= std_logic_vector(unsigned(byte_counter) - 1);
                    full_bit_counter <= "1111";
                    uart_rx_state <= stReadBits;
                end if;
            else
                full_bit_counter <= std_logic_vector(unsigned(full_bit_counter) - 1);
                uart_rx_state <= stReadBits;
            end if;
        when stStopBit =>
            if full_bit_counter= "0000" then
                if rx ='1' then
                    led <= "00000000" & rx_data;
                else
                    led <= "1111111111111111";
                    
                end if;
            else
                uart_rx_state <= stStopBit;
            end if;
            end case;
       end if;
end process;











end Behavioral;
