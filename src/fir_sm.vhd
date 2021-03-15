library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_filter is
	port(
		clk:	in std_logic;
		valid:	in std_logic;
		data :	in std_logic_vector(7 downto 0);

		valid_out:	out std_logic;
		data_out:	out std_logic_vector(7 downto 0));

end entity fir_filter;

architecture str of fir_filter is

	type state_t is (s0,s1,s2,s3,s4);
	signal state :	state_t := s0;

	type arr8_t is array (0 to 4) of signed(7 downto 0);
	type arr16_t is array (0 to 4) of signed(15 downto 0);
	 

	signal data_pipe :	arr8_t := (others => (others => '0'));
	signal coeff :	arr8_t;
	signal mult : arr16_t := (others => (others => '0'));
	signal adder : signed(20 downto 0) := (others => '0'); 

  signal counter   : unsigned(9 downto 0) := (others => '0');
  constant divisor : unsigned(9 downto 0) := to_unsigned(15, 10);

begin  -- architecture

      --coeff(0) <= to_signed(1,8);  --initialize coefficients
      --coeff(1) <= to_signed(3,8);
      --coeff(2) <= to_signed(2,8);
      --coeff(3) <= to_signed(3,8);

coeff(0) <= "00010001";
coeff(1) <= "00110101";
coeff(2) <= "00010010";
coeff(3) <= "00110110";
coeff(4) <= "00110110";

  main : process (clk,valid) is
  begin  -- process main
    if rising_edge(clk) then -- rising clock edge
      
      case state is

        when s0 =>     --initialized to s0 state
          valid_out  <= '0';
          if valid = '1' then
            state <= s1;
          end if;

        when s1 =>
          valid_out  <= '0';
	  data_pipe  <= signed(data)&data_pipe(0 to data_pipe'length-2);

          if valid = '0' then
              state <= s2;
          end if;
	  
        when s2 =>
	  --counter <= counter + 1;

  	  mult(0) <= data_pipe(0)*coeff(0);
	  mult(1) <= data_pipe(1)*coeff(1);
	  mult(2) <= data_pipe(2)*coeff(2);
	  mult(3) <= data_pipe(3)*coeff(3);
	  mult(4) <= data_pipe(4)*coeff(4);


         --if counter = divisor then
	  if valid = '0' then
              state <= s3;
	   --   counter <= (others => '0');
          end if;

	when s3 =>
	  adder <= 	(resize(mult(0),21) + resize(mult(1),21) + resize(mult(2),21) +
			resize(mult(3),21) + resize(mult(4),21));

	  if valid = '0' then
              state <= s4;
          end if;


	when s4 =>
	  data_out <=	std_logic_vector(adder(20 downto 13));--shift rightresize(adder, 8)
          valid_out  <= '1';
	  if valid = '0' then
              state <= s0;
          end if;

        when others => null;
      end case;
    end if;
  end process main;
end architecture str;
