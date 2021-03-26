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
  signal clock         : std_logic;
  signal valid         : std_logic;
  signal received_data : std_logic_vector(7 downto 0);
  signal data_valid    : std_logic;
  signal data_to_send  : std_logic_vector(7 downto 0);
  signal busy          : std_logic;

  component uart_receiver is
    port (
      clock         : in  std_logic;
      uart_rx       : in  std_logic;
      valid         : out std_logic;
      received_data : out std_logic_vector(7 downto 0));
  end component uart_receiver;

  component fir_filter2 is
    port (
      clock         : in std_logic;
      valid         : in std_logic;
      data          : in std_logic_vector(7 downto 0);
      data_valid    : out std_logic;
      data_out      : out std_logic_vector(7 downto 0));
  end component fir_filter;

  component uart_transmitter is
    port (
      clock         : in  std_logic;
      data_to_send  : in  std_logic_vector(7 downto 0);
      data_valid    : in  std_logic;
      busy          : out std_logic;
      uart_tx       : out std_logic);
  end component uart_transmitter;
begin  -- architecture str

  uart_receiver_1 : uart_receiver

    port map (
      clock         => CLK100MHZ,
      uart_rx       => uart_txd_in,
      valid         => valid,
      received_data => received_data);

  fir_filter_1 : fir_filter2

    port map(
      clock         => CLK100MHZ,
      valid         => valid,
      data          => received_data,
      data_valid    => data_valid,
      data_out      => data_to_send);

  uart_transmitter_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send,
      data_valid   => data_valid,
      busy         => busy,
      uart_tx      => uart_rxd_out);

end architecture str;
