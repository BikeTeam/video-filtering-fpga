library ieee;
use ieee.std_logic_1164.all;

entity signal_delay is
	generic (
		t : integer := 1;
		ww : integer := 8
	);
	port (
		signal clk, rst  : in std_logic; 
		signal d : in std_logic_vector(ww-1 downto 0);
		signal q : out std_logic_vector (ww-1 downto 0)
	);
end entity signal_delay;

architecture delay_buff of signal_delay is
	signal w_ptr: integer RANGE 0 to t:= 0;
	signal r_ptr: integer RANGE 0 to t:= 1;
	signal ram_clk : std_logic;
	component ram_infer is
		generic(
			depth : integer := 1;
			w_w : integer := 8
		);
		port(
			clock			 : IN   std_logic;
			data			 : IN   std_logic_vector (w_w-1 DOWNTO 0);
			write_address: IN   integer RANGE 0 to depth;
			read_address : IN   integer RANGE 0 to depth;
			out_data		 : OUT  std_logic_vector (w_w-1 DOWNTO 0)
		);
	end component ram_infer;
begin
	ram_clk <= clk and (not rst);
	
	buff : ram_infer
		generic map(depth=>t, w_w => ww)
		port map(clock=>ram_clk, data=>d, write_address=>w_ptr, read_address=>r_ptr, out_data=>q);
	
	process (rst, clk)
	begin
		if (rst = '1') then
			w_ptr <= 0;
			r_ptr <= 1;
		elsif rising_edge(clk) then
			if (w_ptr < t-1) then
				w_ptr <= w_ptr + 1;
			else
				w_ptr <= 0;
			end if;
			
			if (r_ptr < t-1) then
				r_ptr <= r_ptr + 1;
			else
				r_ptr <= 0;
			end if;
			
		end if;
	end process;
end delay_buff;