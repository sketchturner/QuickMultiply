library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity qm32 is
	generic (
			constant DATA_WIDTH: integer:= 8
	);
	port 
	(
		A	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		B	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		V	: out std_logic_vector(DATA_WIDTH*2-1 downto 0)
	);
end entity;

architecture qm32 of qm32 is
type mux_results_type	is array (DATA_WIDTH/2-1 downto 0) of std_logic_vector(DATA_WIDTH downto 0);
type tmp_array is array(DATA_WIDTH/2-1 downto 0) of std_logic_vector(DATA_WIDTH*2-2 downto 0);
signal s3A: std_logic_vector(DATA_WIDTH downto 0);
signal r:	mux_results_type;
signal tmp: tmp_array;

component my_mux
	generic (
			DATA_WIDTH: integer:= 32
	);
	port
	(
		dataA	: in STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
		data3A	: in STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0);
		sel		: in STD_LOGIC_VECTOR (1 DOWNTO 0);
		result	: out STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0)
	);
end component;
begin
	s3A <= ("0"&A) + (A&"0");
	gen_mux:
		for i in 0 to DATA_WIDTH/2-1 generate
			muxI: my_mux generic map (DATA_WIDTH => DATA_WIDTH)
				port map (
				A,
				s3A,
				B(i+i+1 downto i+i),
				r(i));
	end generate gen_mux;
-----------------------------
--      for 32bit data     --
-----------------------------
--	V <= r(0)+(r(1)&"00")+(r(2)&"0000")+(r(3)&"000000")+(r(4)&"00000000")+(r(5)&"0000000000")+(r(6)&"000000000000")+(r(7)&"00000000000000")+(r(8)&"0000000000000000")+(r(9)&"000000000000000000")+(r(10)&"00000000000000000000")+(r(11)&"0000000000000000000000")+(r(12)&"000000000000000000000000")+(r(13)&"00000000000000000000000000")+(r(14)&"0000000000000000000000000000")+("0"&r(15)&"000000000000000000000000000000");
-----------------------------
--      for other data     --
-----------------------------
	gen_sum:
		for i in 0 to DATA_WIDTH/2-1 generate
		sum0:
			if i=0 generate
				tmp(i) <= ((DATA_WIDTH-3 downto 0 => '0')&r(i))+(r(i+1)&((i+1)*2-1 downto 0 => '0'));
			end generate;
		sumI:
			if i>0 and i<DATA_WIDTH/2-1 generate
				tmp(i) <= tmp(i-1)+(r(i+1)&((i+1)*2-1 downto 0 => '0'));
			end generate;
		sumN:
			if i=DATA_WIDTH/2-1 generate
				V <= ("0"&tmp(i-1))+(r(i)&(DATA_WIDTH-3 downto 0 => '0'));
			end generate;
	end generate gen_sum;
end;
