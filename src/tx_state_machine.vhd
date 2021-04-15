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


entity tx_state_machine is
    port 
    (
        clk          : in std_logic;
        baude_signal : in std_logic;

        data     : in std_logic_vector(7 downto 0);
        validity : in std_logic;

        UART_tx : out std_logic;
        busy   : out std_logic
    );
end entity tx_state_machine;


architecture std of tx_state_machine is
    
    type state_t is (Idle,Valid,Start,Tx0,Tx1,Tx2,Tx3,Tx4,Tx5,Tx6,Tx7,Stop);
    
    signal state : state_t := Idle;
    signal input_memory : std_logic_vector(7 downto 0);

begin -- architecture std

    main : process (clk) is
    begin -- process main
        if rising_edge(clk) then
            
            case state is -- state machine cases


                when Idle =>

                    UART_tx <= '1';
                    busy   <= '0';
                    
                    if validity = '1' then
                        state        <= Valid;
                        input_memory <= data;
                        busy         <= '1';
                    end if;

                when Valid =>

                    UART_tx <= '1';
                    
                    if baude_signal = '1' then
                        state   <= Start;
                    end if;

                when Start =>

                    UART_tx <= '0';
                    
                    if baude_signal = '1' then
                        state <= Tx0;
                    end if;

                when Tx0 =>

                    UART_tx <= input_memory(0);
                    
                    if baude_signal = '1' then
                        state <= Tx1;
                    end if;
            
                when Tx1 =>

                    UART_tx <= input_memory(1);
                    
                    if baude_signal = '1' then
                        state <= Tx2;
                    end if;

                when Tx2 =>

                    UART_tx <= input_memory(2);
                    
                    if baude_signal = '1' then
                        state <= Tx3;
                    end if;

                when Tx3 =>

                    UART_tx <= input_memory(3);
                    
                    if baude_signal = '1' then
                        state <= Tx4;
                    end if;

                when Tx4 =>

                    UART_tx <= input_memory(4);
                    
                    if baude_signal = '1' then
                        state <= Tx5;
                    end if;

                when Tx5 =>

                    UART_tx <= input_memory(5);
                    
                    if baude_signal = '1' then
                        state <= Tx6;
                    end if;

                when Tx6 =>

                    UART_tx <= input_memory(6);
                    
                    if baude_signal = '1' then
                        state <= Tx7;
                    end if;

                when Tx7 =>

                    UART_tx <= input_memory(7);
                    
                    if baude_signal = '1' then
                        state <= Stop;
                    end if;

                when Stop =>

                    UART_tx <= '1';
                    
                    if baude_signal = '1' then
                        state <= Idle;
                        busy <= '0';
                    end if;

                when others => 
                    null;

            end case; -- state machine cases

        end if; -- rising clk
    end process main;
    
end architecture std;

