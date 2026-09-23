-- Maquina de estados que gobierna la partida. Lleva el recorrido completo,
-- desde la espera inicial, pasando por la colocacion de las boyas con su
-- validacion, y despues el loop de combate hasta que no queda ninguna. Aca se
-- cumple AC1, y tambien la mitad secuencial de AC5 porque todo ocurre dentro de
-- un process. Para la entrega parcial basta con que los estados existan y se
-- recorran, las acciones internas pueden quedar vacias.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_fsm is
    -- aca va el generic con la cantidad de boyas que hay que colocar

    -- aca van los puertos, o sea el reloj, el reset, los pulsos ya limpios que
    -- vienen de los botones, las coordenadas capturadas, la respuesta que llega
    -- del tablero, y la salida con el estado actual para que la lea el led_driver
end game_fsm;

architecture Behavioral of game_fsm is

    -- aca va el type enumerado con todos los estados, que es la forma de
    -- declararlos en VHDL y deja que el sintetizador les asigne un codigo solo

    -- aca va la senal que guarda el estado actual

    -- aca va el contador de boyas que todavia faltan por colocar

begin

    -- aca va el process sincrono con el case sobre el estado actual, donde cada
    -- estado decide a cual se va segun las entradas. hay que cubrir todos los
    -- estados y dejar siempre una salida, para no quedarse pegado en ninguno

    -- aca va la asignacion que saca el estado actual hacia el puerto

end Behavioral;
