library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity delay_line is
    port 
    (
        clk    : in std_logic;
        pulse_in : in std_logic;

        pulse_out : out std_logic
    );
end entity delay_line;


architecture std of delay_line is
    
    signal counter : unsigned(9 downto 0) := to_unsigned(0,10);
    constant divider : unsigned(9 downto 0) := to_unsigned(867,10);

    type state_t is (Delaying,Idle);
    signal state : state_t := Idle;

begin -- architecture rtl

    delay_line_process : process (clk) is
    begin -- process main
        if rising_edge(clk) then --clk

            case state is
                
                when Idle =>

                    pulse_out <= '0';
                
                    if pulse_in = '1' then
                        state <= Delaying;
                        counter <= to_unsigned(0,10);        
                    end if;

                when Delaying =>
                    
                    counter <= counter + 1;
                    
                    if counter=divider/2 then
                        pulse_out <= '1';
                        state <= Idle;
                    end if;

                when others =>
                    null;

            end case;

                    
        end if; --clk
    end process delay_line_process;

    
end architecture std;

