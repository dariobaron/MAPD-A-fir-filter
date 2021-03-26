library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_filter2 is
	port(
		clock:	in std_logic;
		valid:	in std_logic;
		data :	in std_logic_vector(7 downto 0);

		data_valid:	out std_logic;
		data_out:	out std_logic_vector(7 downto 0));

end entity fir_filter2;

architecture str of fir_filter2 is

	type state_t is (s0,s1,s2);
	signal state :	state_t := s0;

	type arr8_t is array (0 to 5) of signed(7 downto 0);
	--type arr16_t is array (0 to 5) of signed(15 downto 0);
	 

	signal data_pipe :	arr8_t := (others => (others => '0'));
	signal coeff :	arr8_t := (others => (others => '0'));
	--signal mult : arr16_t := (others => (others => '0'));
	--signal adder : signed(20 downto 0) := (others => '0');

begin  -- architecture

      --coeff(0) <= to_signed(1,8);  --initialize coefficients
      --coeff(1) <= to_signed(3,8);
      --coeff(2) <= to_signed(2,8);
      --coeff(3) <= to_signed(3,8);

coeff(0) <= "00000010";
coeff(1) <= "00001011";
coeff(2) <= "00011010";
coeff(3) <= "00011010";
coeff(4) <= "00001011";
coeff(5) <= "00000010";

  main : process (clock,valid) is
  begin  -- process main
    if rising_edge(clock) then -- rising clock edge
      
      case state is

        when s0 =>     --initialized to s0 state
          data_valid  <= '0';
          if valid = '1' then
            state <= s1;
          end if;

        when s1 =>
		data_valid  <= '0';
		data_pipe  <= signed(data)&data_pipe(0 to data_pipe'length-2);

		if valid = '0' then
			state <= s2;
		end if;

	
	when s2 =>
		data_out <=	std_logic_vector(resize(shift_right(
				resize(data_pipe(0)*coeff(0),21) + 
				resize(data_pipe(1)*coeff(1),21) + 
				resize(data_pipe(2)*coeff(2),21) + 
				resize(data_pipe(3)*coeff(3),21) + 
				resize(data_pipe(4)*coeff(4),21) + 
				resize(data_pipe(5)*coeff(5),21), 7), 8));
		data_valid  <= '1';
			if valid = '0' then
				state <= s0;
			end if;

        when others => null;
      end case;

    end if;

  end process main;

end architecture str;
