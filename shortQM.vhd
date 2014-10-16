library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sqm is
	port 
	(
		A	: in std_logic_vector(3 downto 0);
		B	: in std_logic_vector(3 downto 0);
		V	: out std_logic_vector(7 downto 0)
	);
end entity;

architecture sqm of sqm is
signal s2A: std_logic_vector(4 downto 0);
signal c3:	std_logic;
signal s3:	std_logic_vector(4 downto 0);
signal s3A: std_logic_vector(5 downto 0);
signal r1:	std_logic_vector(5 downto 0);
signal r2:	std_logic_vector(5 downto 0);
component lpm_add_sub0
	PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		cout		: OUT STD_LOGIC ;
		result		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
end component;

--component lpm_mux0
--	PORT
--	(
--		data0x	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
--		data1x	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
--		data2x	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
--		data3x	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
--		sel		: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
--		result	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
--	);
--end component;

component my_mux
	port
	(
		dataA	: in STD_LOGIC_VECTOR (4 DOWNTO 0);
		data3A	: in STD_LOGIC_VECTOR (5 DOWNTO 0);
		sel		: in STD_LOGIC_VECTOR (1 DOWNTO 0);
		result	: out STD_LOGIC_VECTOR (5 DOWNTO 0)
	);
end component;

begin
--sm1: lpm_add_sub0 port map ("0"&A, A&"0", s3A(5), s3A(4 downto 0));
--mux1: lpm_mux0 port map("000000", "00"&A, "0"&s2A, s3A, B(1 downto 0), r1);
--mux2: lpm_mux0 port map("000000", "00"&A, "0"&s2A, s3A, B(3 downto 2), r2);
mux1: my_mux port map("0"&A, s3A, B(1 downto 0), r1);
mux2: my_mux port map("0"&A, s3A, B(3 downto 2), r2);
s2A <= A&"0";
s3A <= A + ("0"&s2A);
V <= r1 + (r2&"00");
end;
