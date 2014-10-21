library ieee;
use ieee.std_logic_1164.all;

entity my_mux is
	generic (
			constant DATA_WIDTH: integer:= 32
	);
	port
	(
		dataA	: in STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
		data3A	: in STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0);
		sel		: in STD_LOGIC_VECTOR (1 DOWNTO 0);
		result	: out STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0)
	);
end my_mux;

architecture my_mux of my_mux is
begin
	with sel select
		result <=	(DATA_WIDTH downto 0 => '0')	when "00",
					"0"&dataA						when "01",
					dataA&"0"						when "10",
					data3A							when "11";
end my_mux;