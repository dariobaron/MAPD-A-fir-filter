library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity all_tb is
end entity all_tb;


architecture test_all of all_tb is

  component top is
  	port (
    	CLK100MHZ    : in  std_logic;
    	uart_txd_in  : in  std_logic;
    	uart_rxd_out : out std_logic);
  end component top;

 
  
  --component ports

    signal CLK100MHZ    : std_logic :='0';
    signal uart_txd_in  : std_logic;
    signal uart_rxd_out : std_logic;
    
begin  -- architecture test
  -- component instantiation

    DUT : top

    port map (
      CLK100MHZ         => CLK100MHZ,
      uart_txd_in       => uart_txd_in,
      uart_rxd_out      => uart_rxd_out);


CLK100MHZ <= not CLK100MHZ after 5 ns;
  
  main: process  is
  begin  -- process main

--NB: give bits from the less significant bit to the most significant bit

    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (00110111)
    wait for 8680 ns;
    uart_txd_in <= '1'; 
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;
  
    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (01111111)
    wait for 8680 ns;
    uart_txd_in <= '1'; 
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;  
    
    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (11111110)
    wait for 8680 ns;
    uart_txd_in <= '0'; 
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;

    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (11110010)
    wait for 8680 ns;
    uart_txd_in <= '0'; 
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;    
    
    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (01011100)
    wait for 8680 ns;
    uart_txd_in <= '0'; 
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;    
    
    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (00000000)
    wait for 8680 ns;
    uart_txd_in <= '0'; 
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;
    
    wait until rising_edge(CLK100MHZ);
    uart_txd_in <= '0'; --start bit (10100100)
    wait for 8680 ns;
    uart_txd_in <= '0'; 
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '0';
    wait for 8680 ns;
    uart_txd_in <= '1';
    wait for 8680 ns;
    uart_txd_in <= '1'; --stop bit
    wait for 8680 ns;

    wait for 10 us;
    
    wait;
  end process main;

end architecture test_all;
