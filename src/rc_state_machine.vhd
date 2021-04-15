-- <<< QUESTIONS >>>

-- 1) I do not understand how the mast/less significant bits are considered during
--    assignment of values, indexing and GTKwave representation

-- 2) Is it expected behaviour?
--     (for 1T transitions) baude_pulse --> state update --> output update
--     ar should the output be updated with the state?

-- 3) Bits are transmitted in time from right to left (considering vhdl assignment)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rc_state_machine is
    port 
    (
        clk             : in std_logic;
        UART_in         : in std_logic;
        sampling_signal : in std_logic;

        data_out : out std_logic_vector(7 downto 0);
        valid    : out std_logic
    );
end entity rc_state_machine;


architecture std of rc_state_machine is
    
    type state_t is (Bit_1, Bit_2, Bit_3, Bit_4, Bit_5, Bit_6, Bit_7, Bit_8, Stop, Idle);
    signal state : state_t := Idle;

    signal output_memory : std_logic_vector(7 downto 0);

begin -- architecture std

rc_state_machine_process : process (clk) is
    begin -- process
        if rising_edge(clk) then --clk

            case state is

                when Idle =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        if UART_in = '0' then -- check if real start or glitch
                            state <= Bit_1;
                        end if;
                    
                    end if;

                when Bit_1 =>
                    
                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(0) <= UART_in;
                        state <= Bit_2;     
                    
                    end if;

                when Bit_2 =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(1) <= UART_in;
                        state <= Bit_3;     
                    
                    end if;

                when Bit_3 =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(2) <= UART_in;
                        state <= Bit_4;     
                    
                    end if;


                when Bit_4 =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(3) <= UART_in;
                        state <= Bit_5;     
                    
                    end if;

                when Bit_5 =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(4) <= UART_in;
                        state <= Bit_6;     
                    
                    end if;

                when Bit_6 =>
                    
                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(5) <= UART_in;
                        state <= Bit_7;     
                    
                    end if;



                when Bit_7 =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(6) <= UART_in;
                        state <= Bit_8;     
                    
                    end if;


                when Bit_8 =>

                    valid <= '0';
                    if sampling_signal = '1' then
            
                        output_memory(7) <= UART_in;
                        state <= Stop; 
                    
                    end if;

                when Stop =>
                    if sampling_signal = '1' then
            
                        if UART_in = '1' then -- check if valid bit

                            valid <= '1';
                            data_out <= output_memory;
                            
                        else 
                            valid <= '0';

                        end if;

                        state <= Idle;

                    end if;

                when others =>
                    null;

            end case;

                    
        end if; --clk
    end process rc_state_machine_process;

    

    
end architecture std;

