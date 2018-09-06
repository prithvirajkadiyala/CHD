----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2017 06:25:29 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
            led : out std_logic_vector(15 downto 0);
           btnC : in STD_LOGIC);
end toplevel;

architecture Behavioral of toplevel is

TYPE sequence_detector_states IS (stIDLE, stA, stB, stC, stD);
SIGNAL current_state : sequence_detector_states;

begin

process(btnC)
begin

if rising_edge(btnC) then

    case current_state is 
        
        when stIDLE =>
                    if sw(0) = '1' then
                            current_state <= stA; 
                    else
                            current_state <= stIDLE;
                    end if;
    
                    led <= (others => '0');
        --1
        when stA =>
                    if sw(0) = '1' then
                            current_state <= stA; 
                    else
                            current_state <= stB;
                    end if;
    
                    led <= (others => '0');
        --10
        when stB =>
                    if sw(0) = '1' then
                            current_state <= stC; 
                    else
                            current_state <= stIDLE;
                    end if;
    
                    led <= (others => '0');
        --101
        when stC =>
                    if sw(0) = '1' then
                            current_state <= stD; 
                    else
                            current_state <= stB;
                    end if;
    
                    led <= (others => '1');
        --1011
        when stD =>
                    if sw(0) = '1' then
                            current_state <= stA; 
                    else
                            current_state <= stB;
                    end if;
    
                    led <= (others => '0');
        
        when others =>
            led <= (others => '0');
            current_state <= stIDLE;
            
    end case;

end if;

end process;




end Behavioral;
