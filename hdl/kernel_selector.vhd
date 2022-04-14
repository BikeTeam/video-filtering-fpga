library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity kernel_generator is
	port(
		signal ena : in std_logic;
      signal selector   : in std_logic_vector(2 downto 0);
		signal k0, k1, k2	: out std_logic_vector(8 downto 0);
		signal k3, k4, k5	: out std_logic_vector(8 downto 0);
		signal k6, k7, k8	: out std_logic_vector(8 downto 0)
	);
end entity kernel_generator;

architecture kernel_arch of kernel_generator is

	type kernel is array (0 to 8) of integer range -256 to 255;
	signal wire 		: kernel := (0, 0, 0, 0, 16, 0, 0, 0, 0);
	signal low_pass 	: kernel := (1, 2, 1, 2, 4, 2, 1, 2, 1);
	signal high_boost : kernel := (-16, -16, -16, -16, 160, -16, -16, -16, -16);
	signal laplacian 	: kernel := (16, 16, 16, 16, -128, 16, 16, 16, 16);
	signal h_sobel 	: kernel := (-16, -32, -16, 0, 0, 0, 16, 32, 16);
	signal v_sobel 	: kernel := (-16, 0, 16, -32, 0, 32, -16, 0, 16);
	
	signal current_kernel : kernel := (0, 0, 0, 0, 16, 0, 0, 0, 0);
	
begin 
	k0 <= std_logic_vector(to_signed(current_kernel(0), 9));
	k1 <= std_logic_vector(to_signed(current_kernel(1), 9));
	k2 <= std_logic_vector(to_signed(current_kernel(2), 9));
	
	k3 <= std_logic_vector(to_signed(current_kernel(3), 9));
	k4 <= std_logic_vector(to_signed(current_kernel(4), 9));
	k5 <= std_logic_vector(to_signed(current_kernel(5), 9));
	
	k6 <= std_logic_vector(to_signed(current_kernel(6), 9));
	k7 <= std_logic_vector(to_signed(current_kernel(7), 9));
	k8 <= std_logic_vector(to_signed(current_kernel(8), 9));
	
	process (ena)
	begin
		if rising_edge(ena) then
			case selector is
				when "000" => current_kernel <= wire;
				when "001" => current_kernel <= low_pass;
				when "010" => current_kernel <= high_boost;
				when "011" => current_kernel <= laplacian;
				when "100" => current_kernel <= h_sobel;
				when "101" => current_kernel <= v_sobel;
				when others => current_kernel <= wire;
			end case;
		end if;
	end process;

end architecture kernel_arch;