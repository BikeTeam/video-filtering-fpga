library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity limit_binarization is
	port(
		signal ena : in std_logic;
      signal selector   : in std_logic_vector(3 downto 0);
		signal d	: in std_logic_vector(17 downto 0);
		signal q, n	: out std_logic
	);
end entity limit_binarization;

architecture lim_and_bin_arch of limit_binarization is
	signal curr_th : std_logic_vector(3 downto 0) := "0001";
	signal limited_px : std_logic_vector (11 downto 0);
begin 
	
	q <= '1' when (unsigned(limited_px) > unsigned("0000" & curr_th & "0010")) else '0';
	
	limit: process (d)
	begin
		if (d(17) = '1') then
			-- if negative then set to 0
			limited_px <= (others=>'0');
			n <= '1';
		elsif (unsigned(d) > 4096) then
			-- saturate to 12 bits
			limited_px <= (others=>'1');
		else
			limited_px <= d(11 downto 0);
			n <= '0';
		end if;
	end process limit;
	
	set_threshold: process (ena)
	begin
		if rising_edge(ena) then
			curr_th <= selector;
			
		end if;
	end process set_threshold;

end architecture lim_and_bin_arch;