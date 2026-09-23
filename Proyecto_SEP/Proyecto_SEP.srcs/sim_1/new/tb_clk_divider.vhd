-- Testbench de clk_divider. Un testbench no se sintetiza, o sea no se convierte en
-- hardware: existe solo para generar estimulos y poder mirar como responde el
-- modulo durante la simulacion. Por eso su entity no tiene ningun puerto.
-- Lo importante aca es instanciarlo con un DIV chico, por ejemplo 5. Con el
-- valor real habria que simular unos 40 minutos para ver un solo parpadeo.
-- El archivo del modulo no se toca, para eso sirve el generico.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clk_divider is
    -- un testbench no lleva puertos, no se conecta a nada de afuera
end tb_clk_divider;

architecture sim of tb_clk_divider is

    -- aca va la declaracion component de clk_divider, copiando su entity tal cual

    -- aca van las senales que se van a conectar a cada puerto del modulo

    -- aca va la constante con el periodo del reloj, que son 8 ns para los
    -- 125 MHz de la tarjeta

begin

    -- aca va la instancia de clk_divider con su port map, y con el generic map poniendo DIV en un
    -- valor chico

    -- aca va el process que genera el reloj, invirtiendolo cada medio periodo

    -- aca va el process de estimulos, que mueve las entradas con wait for entre
    -- medio y deja tiempo suficiente para alcanzar a ver la respuesta

end sim;
