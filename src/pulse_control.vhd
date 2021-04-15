library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pulse_control is
    port 
    (
        clk              : in std_logic;
        UART_in          : in std_logic;
        pulse_feedback   : in std_logic;
        pulse_feedback_d : in std_logic; -- delayed pulse signal

        enable : out std_logic
    );
end entity pulse_control;


architecture std of pulse_control is

    type state_t is (Start, Bit_1, Bit_2, Bit_3, Bit_4, Bit_5, Bit_6, Bit_7, Bit_8, Stop, Idle);
    signal state : state_t := Idle;


begin -- architecture std

pulse_control_process : process (clk) is
    begin -- process main
        if rising_edge(clk) then --clk

            case state is

                when Idle =>

                    if UART_in = '0' then
                
                        enable <= '1';

                    end if;

                    -- controls if after a half baude period the signal is still low (avoid glitches)
                    if pulse_feedback_d = '1' and UART_in = '0' then
            
                        enable <= '1';
                        state <= Start;
                    
                    elsif pulse_feedback_d = '1' and UART_in = '1' then

                        enable <= '0';
                        state <= Idle;

                    end if;

                when Start =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_1;
                    
                    end if;

                when Bit_1 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_2;     
                    
                    end if;

                when Bit_2 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_3;     
                    
                    end if;

                when Bit_3 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_4;     
                    
                    end if;

                when Bit_4 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_5;     
                    
                    end if;

                when Bit_5 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_6;     
                    
                    end if;

                when Bit_6 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_7;     
                    
                    end if;

                when Bit_7 =>

                    if pulse_feedback = '1' then
            
                        enable <= '1';
                        state <= Bit_8;     
                    
                    end if;

                when Bit_8 =>

                    if pulse_feedback = '1' then
            
                        enable <= '0';
                        state <= Stop; 
                    
                    end if;

                when Stop =>

                    if pulse_feedback_d = '1' then

                        enable <= '0';
                        state <= Idle; 
                
                    end if;

                when others =>
                    null;

            end case;

                    
        end if; --clk
    end process pulse_control_process;

    
end architecture std;

