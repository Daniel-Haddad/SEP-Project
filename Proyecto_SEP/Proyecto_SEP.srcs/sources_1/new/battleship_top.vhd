-- Top del diseno. No tiene logica propia: su unico trabajo es instanciar los
-- otros modulos y cablearlos entre si. Aca se cumple AO1, que pide usar
-- components para integrar al menos tres componentes dentro de otra entity.
-- Este archivo es el que se conecta a los pines reales de la tarjeta, asi que
-- los nombres de sus puertos tienen que calzar con los del constraints.xdc.
-- Despues se empaqueta entero como un IP core y se suelta en el block design.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity battleship_top is
    -- aca van los puertos fisicos y nada mas, o sea el reloj de la tarjeta, los
    -- switches, los botones, los 4 LEDs y las tres senales del LED RGB
end battleship_top;

architecture Behavioral of battleship_top is

    -- aca va la declaracion component de clk_divider, que es una copia de su
    -- entity para avisarle a este archivo que ese modulo existe

    -- aca va la declaracion component de debounce

    -- aca va la declaracion component de coord_input

    -- aca va la declaracion component de led_driver

    -- aca van las senales internas que conectan una instancia con otra, o sea
    -- el tick que sale del divisor, los pulsos limpios que salen de los
    -- debounce, las coordenadas capturadas y el estado de la FSM

begin

    -- aca va la instancia del clk_divider con su port map y su generic map, que
    -- es donde se le pasa el valor de division que queremos en cada caso

    -- aca van las instancias de los debounce, una por cada boton que usemos

    -- aca van las instancias de coord_input, una por cada coordenada que haya
    -- que capturar

    -- aca va la instancia del led_driver, conectada al estado y a los LEDs

end Behavioral;
