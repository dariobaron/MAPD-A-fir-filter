 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity UART_transmitter is
    port
    (
        -- clock
        clk : in std_logic;

        -- input
        data_validity : in std_logic;
        data          : in std_logic_vector(7 downto 0);

        -- output
        UART_tx : out std_logic;
        busy    : out std_logic
    );
end entity UART_transmitter;


architecture std of UART_transmitter is

    signal baude_signal : std_logic;
    
begin

    -- import components
    
    bauderate_generator : entity work.bauderate_generator
    port map
    (
        clk           => clk,
        bauderate_out => baude_signal
    );

    tx_state_machine : entity work.tx_state_machine
    port map
    (
        clk          => clk,
        baude_signal => baude_signal,

        data     => data,
        validity => data_validity,

        UART_tx => UART_tx,
        busy    => busy
    );

    
end architecture std;

