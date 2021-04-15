library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity bauderate_generator is
    port 
    (
        clk : in std_logic;
        bauderate_out : out std_logic
    );
end entity bauderate_generator;


architecture std of bauderate_generator is
    
    signal counter : unsigned(9 downto 0) := to_unsigned(0,10);
    constant divider : unsigned(9 downto 0) := to_unsigned(867,10);

begin -- architecture rtl

    main : process (clk) is
    begin -- process main
        if rising_edge(clk) then
            counter <= counter + 1;
            
            if counter=divider then
                bauderate_out <= '1';
                counter <= (others => '0');
            else
                bauderate_out <= '0';
            end if; 
        end if;
    end process main;
    
end architecture std;

