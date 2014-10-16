library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity qm32 is
	generic (
			constant DATA_WIDTH: integer:= 32
	);
	port 
	(
		A	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		B	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		V	: out std_logic_vector(DATA_WIDTH*2-1 downto 0)
	);
end entity;

architecture qm32 of qm32 is
type mux_results_type	is array (15 downto 0) of std_logic_vector(DATA_WIDTH downto 0);
type sum_first_type		is array (7 downto 0) of std_logic_vector(35 downto 0);
type sum_second_type	is array (3 downto 0) of std_logic_vector(39 downto 0);
signal s2A: std_logic_vector(32 downto 0);
signal s3A: std_logic_vector(DATA_WIDTH downto 0);
signal r:	mux_results_type;
signal sum1:	sum_first_type;
signal sum2:	sum_second_type;
signal sum3_0: std_logic_vector(47 downto 0);
signal sum3_1: std_logic_vector(47 downto 0);

--component lpm_mux1
--	PORT
--	(
--		data0x	: IN STD_LOGIC_VECTOR (33 DOWNTO 0);
--		data1x	: IN STD_LOGIC_VECTOR (33 DOWNTO 0);
--		data2x	: IN STD_LOGIC_VECTOR (33 DOWNTO 0);
--		data3x	: IN STD_LOGIC_VECTOR (33 DOWNTO 0);
--		sel		: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
--		result	: OUT STD_LOGIC_VECTOR (33 DOWNTO 0)
--	);
--end component;
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
	s3A <= ("0"&A) + (A&"");
	
	gen_mux:
		for i in 0 to 15 generate
			muxI: my_mux generic map (DATA_WIDTH => DATA_WIDTH)
				port map (
--				"0000000000000000000000000000000000",
--				"0"&A,
--				"0"&A&"",
				A,
				s3A,
				B(i+i+1 downto i+i),
				r(i));
	end generate gen_mux;
	
--	gen_sum_first:
--		for i in 0 to 7 generate
--			sum1i: sum1(i) <= ("00"&r(i+i)) + (r(i+i+1)&"0");
--	end generate gen_sum_first;
--	
--	gen_sum_second:
--		for i in 0 to 3 generate
--			sum2i: sum2(i) <= ("00000"&sum1(i+i)) + (sum1(i+i+1)&"0000");
--	end generate gen_sum_second;
--	
--	sum3_0 <= ("000000000"&sum2(0)) + (sum2(1)&"00000000");
--	sum3_1 <= ("000000000"&sum2(2)) + (sum2(3)&"00000000");
--	V <= ("00000000000000000"&sum3_0) + (sum3_1&"0000000000000000");
	V <= ("0000000000000000000000000000000"&r(0))+("00000000000000000000000000000"&r(1)&"0")+("000000000000000000000000000"&r(2)&"0000")+("0000000000000000000000000"&r(3)&"000000")+("00000000000000000000000"&r(4)&"00000000")+("000000000000000000000"&r(5)&"0000000000")+("0000000000000000000"&r(6)&"000000000000")+("00000000000000000"&r(7)&"00000000000000")+("000000000000000"&r(8)&"0000000000000000")+("0000000000000"&r(9)&"000000000000000000")+("00000000000"&r(10)&"00000000000000000000")+("000000000"&r(11)&"0000000000000000000000")+("0000000"&r(12)&"000000000000000000000000")+("00000"&r(13)&"00000000000000000000000000")+("00"&r(14)&"0000000000000000000000000000")+(r(15)&"000000000000000000000000000000");
end;
