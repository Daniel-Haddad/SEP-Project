library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- coord_input
--
-- Captura los ANCHO bits de "sw" en el flanco de subida de "clk" cuando
-- "confirmar" esta en alto, y mantiene ese valor quieto en "valor" hasta
-- la proxima vez que "confirmar" vuelva a estar en alto.
--
-- Generico ANCHO: permite reusar el bloque si cambia la cantidad de
-- switches/bits del tablero, sin tocar el codigo.

entity coord_input is
    generic (
        ANCHO : integer := 3
    );
    port (
        clk       : in  std_logic;
        sw        : in  std_logic_vector(ANCHO-1 downto 0);
        confirmar : in  std_logic;
        valor     : out std_logic_vector(ANCHO-1 downto 0)
    );
end entity coord_input;

architecture Behavioral of coord_input is

    -- Senal interna que retiene el valor capturado entre confirmaciones
    signal valor_reg : std_logic_vector(ANCHO-1 downto 0) := (others => '0');

begin

    -- Process sincrono: actualiza valor_reg SOLO cuando confirmar = '1'
    -- en el flanco de subida del reloj. El resto del tiempo, valor_reg
    -- no cambia (por eso "retiene" el valor).
    process(clk)
    begin
        if clk'event and clk = '1' then
            if confirmar = '1' then
                -- Copia bit a bit usando el rango real de sw (attribute 'range)
                for i in sw'range loop
                    valor_reg(i) <= sw(i);
                end loop;
            end if;
        end if;
    end process;

    -- Asignacion concurrente: saca la senal interna al puerto de salida
    valor <= valor_reg;

    -- Chequeo de consistencia de anchos (attribute 'length), util al
    -- simular si alguna vez cambia el generico y algo queda desalineado
    assert valor_reg'length = sw'length
        report "coord_input: el ancho de valor_reg no coincide con el de sw"
        severity error;

end architecture Behavioral;