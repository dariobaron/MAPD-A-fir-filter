library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_receiver_tb is
end entity uart_receiver_tb;

architecture test of uart_receiver_tb is

component uart_receiver is
port(
 clock : in std_logic;
 uart_rx : in std_logic;
 valid : out std_logic;
 received_data : out std_logic_vector(7 downto 0));
end component uart_receiver;


 signal clock : std_logic := '1';
 signal uart_rx : std_logic;
 signal received_data : std_logic_vector(7 downto 0);
 signal valid : std_logic;


begin
DUT : uart_receiver
port map( clock => clock, uart_rx => uart_rx,
valid => valid, received_data => received_data);

clock <= not clock after 5 ns;

main: process
begin

wait until rising_edge(clock);
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0'; --start bit1
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
-- second signal
uart_rx <= '0'; --start bit2
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
-- third signal
uart_rx <= '0'; --start bit3
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
uart_rx <= '0';
wait for 8680 ns;
uart_rx <= '1';
wait for 8680 ns;
wait;

end process main;

end architecture test;

