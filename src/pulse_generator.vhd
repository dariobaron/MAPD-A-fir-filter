library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pulse_generator is
    port 
    (
        clk    : in std_logic;
        enable : in std_logic;

        pulse_out : out std_logic
    );
end entity pulse_generator;


architecture std of pulse_generator is
    
    signal counter : unsigned(9 downto 0) := to_unsigned(0,10);
    constant divisor : unsigned(9 downto 0) := to_unsigned(867,10);

begin -- architecture rtl


    pulse_generator_process : process (clk) is
    begin -- process main
        if rising_edge(clk) then --clk
            
            if enable='1' then --enable

                if (counter = to_unsigned(0,10)) then
                    pulse_out <= '1';
                    counter <= counter + 1;
                elsif (counter = divisor-1) then
                    pulse_out <= '0';
                    counter <= to_unsigned(0,10); -- reset counter
                else
                    pulse_out <= '0';
                    counter <= counter + 1;
                end if; 

                
        
            else
            
                counter <= to_unsigned(0,10);
                pulse_out <= '0';
        
            end if; -- enable

        end if; --clk
    end process pulse_generator_process;

    
end architecture std;

