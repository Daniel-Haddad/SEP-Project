-- Captura una coordenada desde los switches cuando llega un pulso de
-- confirmacion, y la mantiene quieta hasta la proxima captura. El tablero es de
-- 8x8, asi que cada eje necesita 3 bits y hay que ingresarlos por separado
-- porque la tarjeta solo tiene 4 switches. Se instancia tres veces, para la X y
-- la Y de colocacion y para el apuntado en combate.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coord_input is
    -- aca va el generic con el ancho del valor a capturar, para poder reusar el
    -- mismo modulo si alguna vez cambia el tamano del tablero

    -- aca van los puertos, o sea el reloj, los switches de entrada, el pulso
    -- que ordena capturar, y la salida con el valor ya capturado
end coord_input;

architecture Behavioral of coord_input is

    -- aca va la senal interna que retiene el valor capturado, que hace falta
    -- porque un puerto de salida no se puede volver a leer desde adentro

begin

    -- aca va el process sincrono que copia los switches a la senal interna solo
    -- cuando llega el pulso de confirmacion, y que el resto del tiempo no hace
    -- nada para que el valor se quede donde estaba

    -- aca va la asignacion concurrente que lleva la senal interna al puerto

end Behavioral;
