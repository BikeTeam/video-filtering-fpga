LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ram_infer IS
	GENERIC
	(
		depth : integer := 1;
		w_w : integer := 8
	);
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (w_w-1 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to depth;
      read_address:   IN   integer RANGE 0 to depth;
      out_data:     OUT  std_logic_vector (w_w-1 DOWNTO 0)
   );
END ram_infer;

ARCHITECTURE rtl OF ram_infer IS
   TYPE mem IS ARRAY(0 TO depth) OF std_logic_vector(w_w-1 DOWNTO 0);
   SIGNAL ram_block : mem;
BEGIN
   PROCESS (clock)
   BEGIN
      IF rising_edge(clock) THEN
			ram_block(write_address) <= data;
         out_data <= ram_block(read_address);
      END IF;
   END PROCESS;
END rtl;