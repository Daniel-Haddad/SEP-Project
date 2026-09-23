-- Testbench de coord_input. Un testbench no se sintetiza, o sea no se convierte en
-- hardware: existe solo para generar estimulos y poder mirar como responde el
-- modulo durante la simulacion. Por eso su entity no tiene ningun puerto.
-- Lo que hay que probar es que el valor solo se capture cuando llega el pulso
-- de confirmacion, y que despues se quede quieto aunque los switches cambien.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_coord_input is
    -- un testbench no lleva puertos, no se conecta a nada de afuera
end tb_coord_input;

architecture sim of tb_coord_input is

    -- aca va la declaracion component de coord_input, copiando su entity tal cual

    -- aca van las senales que se van a conectar a cada puerto del modulo

    -- aca va la constante con el periodo del reloj, que son 8 ns para los
    -- 125 MHz de la tarjeta

begin

    -- aca va la instancia de coord_input con su port map

    -- aca va el process que genera el reloj, invirtiendolo cada medio periodo

    -- aca va el process de estimulos, que mueve las entradas con wait for entre
    -- medio y deja tiempo suficiente para alcanzar a ver la respuesta

end sim;
