library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_core is
	port (
		signal clk				:	in	std_logic;
		signal r_i, g_i, b_i	:	in std_logic;
		signal vsync, hsync	: out std_logic;
		signal r_o, g_o, b_o	: out std_logic;
		signal curr_px			: out std_logic_vector(18 downto 0);
		signal read_req		: out std_logic
	);
end entity vga_core;

architecture vga_core_arch of vga_core is
	signal xpos, ypos : integer range 0 to 1024 := 0;
	signal display_on	: std_logic := '0';
	signal pxcounter	: integer range 0 to (640*480) := 0;
begin	
	
	read_req <= display_on;
	curr_px <= std_logic_vector(to_unsigned(pxcounter, 19));
	r_o <= r_i when (display_on = '1') else '0';
	g_o <= g_i when (display_on = '1') else '0';
	b_o <= b_i when (display_on = '1') else '0';
	
	process (clk)
	begin
		if (rising_edge(clk)) then
			-- Update x and y counters
			if (xpos < 799) then
				xpos <= xpos + 1;
			else
				xpos <= 0;
				if (ypos < 524) then
					ypos <= ypos + 1;
				else
					ypos <= 0;
					pxcounter <= 0;
				end if;
			end if;
			
			-- set px enable to read buffer
			if (xpos < 640 and ypos < 480) then
				display_on <= '1';
			else
				display_on <= '0';
			end if;
			
			-- update px addres
			if (display_on = '1') then
				pxcounter <= pxcounter + 1;
			end if;
			
			-- hsync pulse
			if ((xpos > 655) and (xpos < 752)) then
				hsync <= '1';
			else
				hsync <= '0';
			end if;
			
			-- vsync pulse
			if ((ypos > 489) and (ypos < 492)) then
				vsync <= '1';
			else
				vsync <= '0';
			end if;
		end if;
	end process;
end architecture vga_core_arch;