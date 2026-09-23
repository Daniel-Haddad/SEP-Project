-- Testbench de debounce. Un testbench no se sintetiza, o sea no se convierte en
-- hardware: existe solo para generar estimulos y poder mirar como responde el
-- modulo durante la simulacion. Por eso su entity no tiene ningun puerto.
-- Lo que hay que probar es que un boton que rebota varias veces produzca un
-- solo pulso de salida. Para eso los estimulos tienen que imitar el rebote,
-- moviendo la entrada varias veces seguidas antes de dejarla quieta.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debounce is
    -- un testbench no lleva puertos, no se conecta a nada de afuera
end tb_debounce;

architecture sim of tb_debounce is

    -- aca va la declaracion component de debounce, copiando su entity tal cual

    -- aca van las senales que se van a conectar a cada puerto del modulo

    -- aca va la constante con el periodo del reloj, que son 8 ns para los
    -- 125 MHz de la tarjeta

begin

    -- aca va la instancia de debounce con su port map, y con el generic map poniendo una espera
    -- corta para no alargar la simulacion

    -- aca va el process que genera el reloj, invirtiendolo cada medio periodo

    -- aca va el process de estimulos, que mueve las entradas con wait for entre
    -- medio y deja tiempo suficiente para alcanzar a ver la respuesta

end sim;
