library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_test is 
		port(A,B : in std_logic_vector(7 downto 0);
			  ALU_Sel :  in std_logic_vector(2 downto 0);
			  NZVC:  out std_logic_vector(3 downto 0);
			  HEX0, HEX1:  out std_logic_vector(6 downto 0));
			  
end entity;

architecture behavorial of ALU_test is 

	component ALU
		port(B, Bus1 : in std_logic_vector(7 downto 0);
			  ALU_Sel : in std_logic_vector(2 downto 0);
			  ALU_Result : out std_logic_vector(7 downto 0);
			  NZVC : out std_logic_vector(3 downto 0));
	end component;
	
	component Display7
		port(F: in std_logic_vector(3 downto 0);
			  HEXout: out std_logic_vector(6 downto 0));
	end component;
	
	
	signal data_out0 : std_logic_vector(7 downto 0);
	signal data_out1 : std_logic_vector(3 downto 0) := data_out0(3 downto 0);
	signal data_out2 : std_logic_vector(3 downto 0) := data_out0(7 downto 4);
	
begin 
	
	Atest : ALU port map (A, B, ALU_Sel, data_out0, NZVC);
	out0 : Display7 port map (data_out1, HEX0);
	out1 : Display7 port map (data_out2, HEX1);
	
end behavorial; 