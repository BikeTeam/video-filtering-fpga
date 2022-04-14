library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity px_selector is
	generic(
		fwidth : integer := 480;
		fheight : integer := 640;
		ww : integer := 8
	);
    port (
        signal clk, rst	  : in std_logic; 
        
		  signal tA, tB, tC : in std_logic_vector (ww-1 downto 0);
		  signal mA, mB, mC : in std_logic_vector (ww-1 downto 0);
		  signal bA, bB, bC : in std_logic_vector (ww-1 downto 0);
		  
		  signal otA, otB, otC : out std_logic_vector (ww-1 downto 0);
		  signal omA, omB, omC : out std_logic_vector (ww-1 downto 0);
		  signal obA, obB, obC : out std_logic_vector (ww-1 downto 0)
		  
    );
end entity px_selector;

architecture selector_arch of px_selector is
	signal ypos: integer range 0 to fheight :=0;
	signal xpos: integer range 0 to fwidth :=0;
	signal a,b,c,d,e,f,g,h,i: boolean;
begin 

	otA <= tA when a else (others=>'0'); 
	otB <= tB when b else (others=>'0');
	otC <= tC when c else (others=>'0');
	omA <= mA when d else (others=>'0');
	omB <= mB;
	omC <= mC when f else (others=>'0');
	obA <= bA when g else (others=>'0');
	obB <= bB when h else (others=>'0');
	obC <= bC when i else (others=>'0');
	
	process (rst, clk)
	begin
		if (rst = '1') then
			xpos <= 0;
			ypos <= 0;
		elsif rising_edge(clk) then
			a <= (xpos /= 0) and (ypos /= 0);
			b <= (ypos /= 0);
			c <= (xpos /= fwidth -1) and (ypos /= 0);
			d <= (xpos /= 0);
			f <= (xpos /= fwidth -1);
			g <= (xpos /= 0) and (ypos /= fheight-1);
			h <= (ypos /= fheight-1);
			i <= (xpos /= fwidth -1) and (ypos /= fheight-1);
			if (xpos < fwidth-1) then
				xpos <= xpos + 1;
			else
				xpos <= 0;
				if (ypos < fheight-1) then
					ypos <= ypos + 1;
				else
					ypos <= 0;
				end if;
			end if;
		end if;
	end process;
end selector_arch;