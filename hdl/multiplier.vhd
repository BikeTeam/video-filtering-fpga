library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
	generic (
		i_w : integer := 9
	);
	port (
		signal clk : in std_logic; 
		signal a, b : in signed(i_w-1 downto 0);
		signal q : out signed ((2*i_w)-1 downto 0)
	);
end entity multiplier;

architecture multiplier_arch of multiplier is
begin
	process (clk)
	begin
		if rising_edge(clk) then
			q <= a * b;
		end if;
	end process;
end multiplier_arch;