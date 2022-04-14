library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
	generic (
		ww : integer := 8
	);
	port (
		signal clk, rst	  : in std_logic; 
		signal d  		  : in std_logic_vector(ww-1 downto 0);
		signal q0, q1, q2 : out std_logic_vector (ww-1 downto 0)
	);
end entity shift_register;

architecture reg_arch of shift_register is
	signal buff1, buff2 : std_logic_vector(ww-1 downto 0);
begin

	process (rst, clk)
	begin
		if (rst = '1') then
			buff1 <= (others=>'0');
			buff2 <= (others=>'0');
		elsif rising_edge(clk) then
			buff1 <= d;
			buff2 <= buff1;
			q0 <= d;
			q1 <= buff1;
			q2 <= buff2;
		end if;
	end process;
end reg_arch;