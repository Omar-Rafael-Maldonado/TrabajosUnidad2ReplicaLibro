library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity maquina is port (
	CLK, MONEDA, MP, PRECIO, LC, LS : in  STD_LOGIC;
   CAP, LIMPIA, SIRVE, CAMBIO, DEC,IM, Q2, Q1, Q0: out  STD_LOGIC);
end maquina;
architecture arq_maq of maquina is
	type estados is (A,B,C,D,E,F,G,H);
	signal edo_pres, edo_fut: estados;
	begin
		p_estados: process (edo_pres, MONEDA, MP, PRECIO, LC, LS) 
	begin
		case edo_pres is
		when A => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '0'; CAMBIO <= '0'; DEC <= '0'; IM <= '1'; 
				Q2 <= '0'; Q1 <= '0'; Q0 <= '0'; 
			if MONEDA = '1' then
			edo_fut <= B;
			else edo_fut <= A;
			end if;
		when B => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '0'; CAMBIO <= '0'; DEC <= '0'; IM <= '0'; 
				Q2 <= '0'; Q1 <= '0'; Q0 <= '1'; 
			if MONEDA = '0' then
			edo_fut <= C;
			else edo_fut <= B;
			end if;
		when C => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '0'; CAMBIO <= '0'; DEC <= '0'; IM <= '0'; 
				Q2 <= '0'; Q1 <= '1'; Q0 <= '0'; 
			if MP = '0' then
			edo_fut <= D;
			else edo_fut <= A;
			end if;
		when D => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '0'; CAMBIO <= '0'; DEC <= '0'; IM <= '0'; 
				Q2 <= '0'; Q1 <= '1'; Q0 <= '1'; 
			if PRECIO = '0' then
			edo_fut <= H;
			else edo_fut <= E;
			end if;
		when E => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '1'; CAMBIO <= '0'; DEC <= '0'; IM <= '0'; 
				Q2 <= '1'; Q1 <= '0'; Q0 <= '0'; 
			if LS = '0' then 
			edo_fut <= E;
			else edo_fut <= F;
			end if;
		when F => CAP <= '1'; LIMPIA <= '1'; SIRVE <= '0'; CAMBIO <= '0'; DEC <= '0'; IM <= '0'; 
				Q2 <= '1'; Q1 <= '0'; Q0 <= '1'; edo_fut <= A;
		when G => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '0'; CAMBIO <= '1'; DEC <= '0'; IM <= '0'; 
				Q2 <= '1'; Q1 <= '1'; Q0 <= '1'; 
			if LC = '0' then
			edo_fut <= G;
			else edo_fut <= H;
			end if;
		when H => CAP <= '0'; LIMPIA <= '0'; SIRVE <= '0'; CAMBIO <= '0'; DEC <= '1'; IM <= '0'; 
				edo_fut <= D; 		
		end case;
	end process p_estados;
p_reloj: process (clk) begin
	if (clk'event and clk = '1') then 
			edo_pres <= edo_fut;
	end if;
end process p_reloj;
end arq_maq;

