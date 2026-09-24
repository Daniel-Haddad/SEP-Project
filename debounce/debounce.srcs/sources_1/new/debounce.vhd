-- debounce: entrega un pulso de un ciclo por cada apreton del boton.
-- Basado en BTNS_debouncer.vhd (ayudantia AYUD03 / fpga4student.com).

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    generic (
        CICLOS : integer := 250_000   -- 2 ms a 125 MHz. En simulacion usar 4.
    );
    port (
        clk   : in  std_logic;
        btn   : in  std_logic;
        pulso : out std_logic
    );
end debounce;

architecture Behavioral of debounce is

    signal enable_lento : std_logic := '0';
    signal q0, q1, q2   : std_logic := '0';
    signal pulso_int    : std_logic := '0';

begin

    -- enable de un ciclo cada CICLOS
    gen_enable : process(clk)
        variable cuenta : integer range 0 to CICLOS := 0;
    begin
        if rising_edge(clk) then
            if cuenta = CICLOS - 1 then
                cuenta       := 0;
                enable_lento <= '1';
            else
                cuenta       := cuenta + 1;
                enable_lento <= '0';
            end if;
        end if;
    end process gen_enable;

    -- muestrea lento, detecta flanco de subida, pulso de un solo ciclo
    muestreo : process(clk)
    begin
        if rising_edge(clk) then
            pulso_int <= '0';
            if enable_lento = '1' then
                q0 <= btn;
                q1 <= q0;
                q2 <= q1;
                if q1 = '1' and q2 = '0' then
                    pulso_int <= '1';
                end if;
            end if;
        end if;
    end process muestreo;

    pulso <= pulso_int;

end Behavioral;