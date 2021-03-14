library ieee;
use ieee.std_logic_1164.all;


entity fir_filter_tb is
end entity fir_filter_tb;


architecture test of fir_filter_tb is

  component fir_filter is
	port(clk:	in std_logic;
	     valid:	in std_logic;
	     data :	in std_logic_vector(7 downto 0);
	     valid_out:	out std_logic;
	     data_out:	out std_logic_vector(7 downto 0));

  end component fir_filter;
  
  -- component ports
  signal clk		: std_logic :='0';
  signal valid		: std_logic :='0';
  signal data		: std_logic_vector(7 downto 0);
  signal valid_out	: std_logic;
  signal data_out	: std_logic_vector(7 downto 0);

begin  -- architecture test
  -- component instantiation
  DUT: fir_filter
    port map (
      clk	=> clk,
      valid	=> valid,
      data	=> data,
      valid_out	=> valid_out,
      data_out	=> data_out);

  clk <= not clk after 5 ns;

  main: process  is
  begin  -- process main

    wait for 1 us;
    wait until rising_edge(clk);
    valid <='1';
    data <= "10010010";
    wait until rising_edge(clk);
    valid <='0';
    data <= "00000000";
    wait for 1 us;

    wait until rising_edge(clk);
    valid <='1';
    data <= "10011010";
    wait until rising_edge(clk);
    valid <='0';
    wait for 1 us;

    wait until rising_edge(clk);
    valid <='1';
    data <= "00111001";
    wait until rising_edge(clk);
    valid <='0';
    wait for 1 us;

    wait until rising_edge(clk);
    valid <='1';
    data <= "10011110";
    wait until rising_edge(clk);
    valid <='0';
    wait for 1 us;

    wait until rising_edge(clk);
    valid <='1';
    data <= "01010100";
    wait until rising_edge(clk);
    valid <='0';
    wait for 1 us;

    wait until rising_edge(clk);
    valid <='1';
    data <= "00001010";
    wait until rising_edge(clk);
    valid <='0';
    wait for 1 us;

    wait until rising_edge(clk);
    valid <='1';
    data <= "00010001";
    wait until rising_edge(clk);
    valid <='0';
    wait for 1 us;

    wait;
  end process main;

end architecture test;





