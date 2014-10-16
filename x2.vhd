library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity x2 is
	port 
	(
		A		: in std_logic_vector(3 downto 0);
		s2A1	: out std_logic_vector(4 downto 0);
		s2A2	: out std_logic_vector(4 downto 0)
	);
end entity;

architecture x2 of x2 is
begin
s2A1 <= A&"0";
s2A2 <= A&"0";
end;
