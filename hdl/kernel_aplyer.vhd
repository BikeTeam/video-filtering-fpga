library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity kernel_aplyer is
	generic (
		ww : integer := 9
	);
	port (
		signal clk, valid : in std_logic; 
		signal tA, tB, tC : in signed(ww-1 downto 0);
		signal mA, mB, mC : in signed(ww-1 downto 0);
		signal bA, bB, bC : in signed(ww-1 downto 0);

		signal kA, kB, kC : in signed(ww-1 downto 0);
		signal kD, kE, kF : in signed(ww-1 downto 0);
		signal kG, kH, kI : in signed(ww-1 downto 0);

		signal q : out signed (21 downto 0);
		signal pvalid : out std_logic
	);
end entity kernel_aplyer;

architecture kernel_aplyer_arch of kernel_aplyer is
	signal mulA, mulB, mulC : signed(2*ww-1 downto 0);
	signal mulD, mulE, mulF : signed(2*ww-1 downto 0);
	signal mulG, mulH, mulI : signed(2*ww-1 downto 0);
	signal qA, qB, qC : signed (21 downto 0);
	signal valid_buff0, valid_buff1: std_logic;
	component multiplier is
		generic (
			i_w : integer := 9
		);
		port (
			signal clk : in std_logic; 
			signal a, b : in signed(i_w-1 downto 0);
			signal q : out signed ((2*i_w)-1 downto 0)
		);
	end component multiplier;
	
begin
	
	multA : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => tA, b => kA, q => mulA);
	
	multB : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => tB, b => kB, q => mulB);
		
	multC : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => tC, b => kC, q => mulC);
		
	multD : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => mA, b => kD, q => mulD);
		
	multE : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => mB, b => kE, q => mulE);
		
	multF : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => mC, b => kF, q => mulF);
	
	multG : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => bA, b => kG, q => mulG);
		
	multH : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => bB, b => kH, q => mulH);
		
	multI : multiplier
		generic map (i_w => ww)
		port map (clk => clk, a => bC, b => kI, q => mulI);
		
	process (clk)
	begin
		if rising_edge(clk) then
			valid_buff0 <= valid;
			valid_buff1 <= valid_buff0; 
			pvalid <= valid_buff0;
			qA <= resize(mulA, q'length) + resize(mulB, q'length) + resize(mulC, q'length);
			qB <= resize(mulD, q'length) + resize(mulE, q'length) + resize(mulF, q'length);
			qC <= resize(mulG, q'length) + resize(mulH, q'length) + resize(mulI, q'length);
			q <= qA + qB + qC;
			--q <= resize(mulA, q'length) + resize(mulB, q'length) + resize(mulC, q'length) + 
			--	  resize(mulD, q'length) + resize(mulE, q'length) + resize(mulF, q'length) + 
			--	  resize(mulG, q'length) + resize(mulH, q'length) + resize(mulI, q'length);
		end if;
	end process;
end kernel_aplyer_arch;