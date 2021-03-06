library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity tren is
    Port ( tiempo, sensor, clk, Sp : in  STD_LOGIC;
           PA, PC, PARO, AVANCE : out  STD_LOGIC;
           Q1, Q0 : inout  STD_LOGIC);
end tren;

architecture asm of tren is
	type estados is (A, B, C, D);
	signal edo_pres, edo_fut: estados;
begin
	p_estados: process (edo_pres, tiempo, sensor, sp)
begin
case edo_pres is
	when A => PA <= '1'; PC <= '0'; PARO <= '0'; AVANCE <= '0'; Q1 <= '0'; Q0 <= '0'; 
		if TIEMPO = '1' then 															
		edo_fut <= B;
		else 
		edo_fut <= A;
		end if;
	when B => PA <= '0'; PC <= '1'; PARO <= '0'; AVANCE <= '0'; Q1 <= '0'; Q0 <= '1'; 
		if SP = '1' then 																	
		edo_fut <= C;
		else 
		edo_fut <= B;
		end if;
	when C => PA <= '0'; PC <= '0'; PARO <= '0'; AVANCE <= '1'; Q1 <= '1'; Q0 <= '0'; 
		if sensor = '1' then 															
		edo_fut <= D;
		else 
		edo_fut <= C;
		end if;
	when D => PA <= '0'; PC <= '0'; PARO <= '1'; AVANCE <= '0'; Q1 <= '0'; Q0 <= '1'; 
	edo_fut <= A;
end case;
end process p_estados;

--inicia segundo proceso
p_reloj: process (clk) begin
	if (clk'event and clk = '1') then 
			edo_pres <= edo_fut;
	end if;
end process;
end asm;

