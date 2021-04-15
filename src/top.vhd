library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top is

  port (

    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);

end entity top;

architecture str of top is
  signal clk           : std_logic;
  signal valid         : std_logic;
  signal data_out      : std_logic_vector(7 downto 0);
  signal data_valid    : std_logic;
  signal data_to_send  : std_logic_vector(7 downto 0);
  signal busy          : std_logic;

  component UART_receiver is
    port (
      clk         : in  std_logic;
      UART_in       : in  std_logic;
      valid         : out std_logic;
      data_out : out std_logic_vector(7 downto 0));
  end component UART_receiver;

  component fir_filter is
    port (
      clk         : in std_logic;
      valid         : in std_logic;
      data          : in std_logic_vector(7 downto 0);
      data_valid    : out std_logic;
      data_out      : out std_logic_vector(7 downto 0));
  end component fir_filter;

  component UART_transmitter is
    port (
      clk           : in  std_logic;
      data          : in  std_logic_vector(7 downto 0);
      data_validity : in  std_logic;
      busy          : out std_logic;
      UART_tx       : out std_logic);
  end component UART_transmitter;
begin  -- architecture str

  uart_receiver_1 : UART_receiver

    port map (
      clk           => CLK100MHZ,
      UART_in       => uart_txd_in,
      valid         => valid,
      data_out      => data_out);

  fir_filter_1 : fir_filter

    port map(
      clk           => CLK100MHZ,
      valid         => valid,
      data          => data_out,
      data_valid    => data_valid,
      data_out      => data_to_send);

  uart_transmitter_1 : UART_transmitter
    port map (
      clk          => CLK100MHZ,
      data         => data_to_send,
      data_validity=> data_valid,
      busy         => busy,
      UART_tx      => uart_rxd_out);

end architecture str;
