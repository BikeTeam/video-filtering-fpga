library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ov7670_px_decoder is
	generic (
		vsync_dly : integer := 700;
		fheigth : integer := 480;
		fwidth : integer := 640
	);
	port (
		signal vsync    : in std_logic; 
		signal href     : in std_logic;
		signal clk     : in std_logic;
		signal data     : in std_logic_vector (7 downto 0);
		signal y        : out std_logic_vector (7 downto 0);
		signal vsyncd	: out std_logic;
		signal addrclk	: out std_logic;
		signal eof		: out std_logic;
		signal ready   : out std_logic
	);
end entity ov7670_px_decoder;

architecture ov7670_arch of ov7670_px_decoder is
	signal vsync_cntr, vcntr, hcntr 	: integer range 0 to 1024 := 0;
	signal state		: std_logic := '0';
	signal buffy      : std_logic_vector (7 downto 0) := "00000000";
	signal px_ready   : std_logic;
	signal enable     : std_logic;
	signal eof_buff 	: std_logic := '0';
	
begin
	ready <= px_ready;
	
	process (clk)
	begin
		if rising_edge(clk) then
			if (vsync = '1') then
				if (vsync_cntr > vsync_dly) then
					vsyncd <= '1';
					state <= '0';
					enable <= '0';
					eof <= '0';
					vcntr <= 0;
					hcntr <= 0;
					eof_buff <= '0';
				else
					vsync_cntr <= vsync_cntr + 1;
				end if;
			else
				vsync_cntr <= 0;
				vsyncd <= '0';
			end if;

			if (state = '0' and enable = '1' and href = '1') then
				addrclk <= '1';
				if (hcntr < fwidth-1) then
					hcntr <= hcntr + 1;
				else
					hcntr <= 0;
					if (vcntr < fheigth-1) then
						vcntr <= vcntr + 1;
					else
						vcntr <= 0;
						eof_buff <= '1';
					end if;
				end if;
			else 
				addrclk <= '0';
			end if;
			
			eof <= eof_buff;
			px_ready <= (not state) and href;-- and enable;

			if (href = '1') then
				if (state = '0') then
					y <= buffy;
				else
					buffy <= data;
					enable <= '1';
				end if;

				state <=  not state;
			else
				state <= '0';
				--enable <= '0';
			end if;
		end if;
	end process;

end architecture ov7670_arch;