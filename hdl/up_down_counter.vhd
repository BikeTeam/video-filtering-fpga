library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic (
		max : integer := 100;
		ww : integer := 8
	);
	port (
		signal clk, rst, dir : in std_logic; 
		signal q : out std_logic_vector (ww-1 downto 0);
		signal max_num, min_num : out std_logic
	);
end entity counter;

architecture up_down_counter of counter is
	signal counter : integer range 0 to max;
begin
	q <= std_logic_vector(to_unsigned(counter, ww));
	max_num <= '1' when counter = max - 1 else '0';
	min_num <= '1' when counter = 0 else '0';
	process (rst, clk)
	begin
		if (rst = '1') then
			counter <= 0;
		elsif rising_edge(clk) then
			if (dir = '0') then
				if (counter < max-1) then
					counter <= counter + 1;
				end if;
			else
				if (counter > 0) then
					counter <= counter - 1;
				end if;
			end if;
		end if;
	end process;
end up_down_counter;