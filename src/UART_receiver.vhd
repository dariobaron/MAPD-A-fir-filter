library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity UART_receiver is
    port
    (
        -- input
        clk     : in std_logic;
        UART_in : in std_logic;

        -- output
        data_out : out std_logic_vector(7 downto 0);
        valid    : out std_logic
    );
end entity UART_receiver;


architecture std of UART_receiver is

    signal sampling_signal : std_logic;
    
begin

    -- import components
    
    sampler_generator : entity work.sampler_generator
    port map
    (
        clk           => clk,
        UART_in       => UART_in,
        
        bauderate_out => sampling_signal
    );

    rc_state_machine : entity work.rc_state_machine
    port map
    (
        clk          => clk,
        UART_in => UART_in,
        sampling_signal => sampling_signal,

        data_out => data_out,
        valid => valid
    );

    
end architecture std;

