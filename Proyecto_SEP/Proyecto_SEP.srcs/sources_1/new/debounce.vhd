-- Limpia el rebote mecanico de un boton. Un pulsador rebota unos 10 ms al
-- apretarlo, y a 125 MHz eso son cientos de miles de transiciones, asi que un
-- solo apreton se contaria como muchos. Este modulo espera a que la entrada se
-- mantenga estable y recien ahi entrega un pulso limpio de un solo ciclo.
-- Hay una referencia en la ayudantia AYUD03, el archivo BTNS_debouncer.vhd.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    -- aca va el generic con la cantidad de ciclos de reloj que hay que esperar
    -- antes de dar por buena la entrada, para poder ajustar el tiempo sin tocar
    -- el codigo y para poder simular con un valor chico

    -- aca van los puertos, o sea el reloj, la entrada cruda del boton, y la
    -- salida que entrega un pulso de un ciclo cuando la pulsacion quedo firme
end debounce;

architecture Behavioral of debounce is

    -- aca va la senal que guarda el estado ya estable del boton

    -- aca va la senal que guarda el estado anterior, para poder detectar el
    -- flanco y emitir el pulso una sola vez y no mientras el boton siga apretado

begin

    -- aca va el process sincrono que cuenta ciclos mientras la entrada no
    -- cambie, y que reinicia la cuenta si la entrada se mueve. la cuenta va en
    -- una variable para que se actualice al instante dentro de la misma pasada

    -- aca va la comparacion entre el estado actual y el anterior, que es lo que
    -- genera el pulso de salida de un solo ciclo

end Behavioral;
