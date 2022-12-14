library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
	port(B, Bus1 : in std_logic_vector(7 downto 0);
		  ALU_Sel : in std_logic_vector(2 downto 0);
		  ALU_Result : out std_logic_vector(7 downto 0);
		  NZVC : out std_logic_vector(3 downto 0));
end entity; 

architecture behavorial of ALU is 
begin 
		ALU_PROCESS : process(B, Bus1, ALU_Sel)
		variable Sum_uns : unsigned(8 downto 0);
		variable Res_uns : unsigned(8 downto 0);
		
	begin 
	
		if(ALU_Sel = "000") then
		Sum_uns := unsigned('0' & B) + unsigned('0' & Bus1);
		ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
		NZVC(3) <=Sum_uns(7);
		if(Sum_uns(7 downto 0)=x"00")then
			NZVC(2)<='1';
		else
			NZVC(2)<='0';
		end if;
		if((B(7)='0' and Bus1(7) = '0' and Sum_uns(7)='1')or(B(7)='1' and Bus1(7) = '1' and Sum_uns(7)='0'))then
			NZVC(1)<='1';
		else
			NZVC(1)<='0';
		end if;
		
		NZVC(0) <=Sum_uns(8);
		
		elsif(ALU_Sel = "001")then
		if(B >= Bus1) then 
		Res_uns := unsigned('0' & B) - unsigned('0' & Bus1);
		ALU_Result <= std_logic_vector(Res_uns(7 downto 0));
		NZVC(3) <=Res_uns(7);
		if(Res_uns(7 downto 0)=x"00")then
			NZVC(1)<='1';
		else
			NZVC(1)<='0';
		end if;
		if((B(7)='1' and Bus1(7) = '0' and Res_uns(7)='0')or(B(7)='0' and Bus1(7) = '0' and Res_uns(7)='1'))then
			NZVC(1)<='1';
		else
			NZVC(1)<='0';
		end if;
		NZVC(0) <=Res_uns(8);
		end if;	
		if(B < Bus1) then 
		Res_uns := unsigned('0' & B) - unsigned('0' & Bus1);
		ALU_Result <= std_logic_vector(Res_uns(7 downto 0));
		NZVC(3) <=Res_uns(7);
		if(Res_uns(7 downto 0)=x"00")then
			NZVC(1)<='1';
		else
			NZVC(1)<='0';
		end if;
		if((B(7)='0' and Bus1(7) = '0' and Res_uns(7)='1')or(B(7)='1' and Bus1(7) = '1' and Res_uns(7)='0'))then
			NZVC(1)<='0';
		else
			NZVC(1)<='1';
		end if;
		
		NZVC(0) <=Res_uns(8);
	   end if;
		end if;
	end process;
end behavorial;	