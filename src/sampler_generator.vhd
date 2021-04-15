library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sampler_generator is
    port 
    (
        clk : in std_logic;
        UART_in : in std_logic;
        bauderate_out : out std_logic
    );
end entity sampler_generator;


architecture std of sampler_generator is
    
    signal enable : std_logic;
    signal pulse_feedback : std_logic;
    signal pulse_feedback_d : std_logic;

begin -- architecture std

    pulse_control_0 : entity work.pulse_control port map
    (
        clk              => clk,
        UART_in          => UART_in,
        pulse_feedback   => pulse_feedback,
        pulse_feedback_d => pulse_feedback_d,
        enable           => enable
    );
    

    pulse_generator_0 : entity work.pulse_generator port map
    (
        clk       => clk,
        enable    => enable,
        pulse_out => pulse_feedback
    );


    delay_line_0 : entity work.delay_line port map
    (
        clk       => clk,
        pulse_in  => pulse_feedback,
        pulse_out => pulse_feedback_d
    );

    bauderate_out <= pulse_feedback_d;

    
end architecture std;

