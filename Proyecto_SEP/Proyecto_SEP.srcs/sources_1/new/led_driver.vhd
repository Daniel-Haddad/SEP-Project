-- Traduce el estado de la maquina a lo que se ve en la tarjeta, o sea el patron
-- de los 4 LEDs y el color del LED RGB. Los LEDs cambian de significado segun
-- el estado: durante la seleccion muestran el numero que se esta formando con
-- los switches, y el resto del tiempo muestran cuantas boyas quedan vivas.
-- Esta escrito con asignaciones concurrentes a proposito, para que contraste
-- con las FSM que son secuenciales. Esa es la mitad concurrente de AC5.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_driver is
    -- aca va el generic del divisor del parpadeo, para poder ajustar la
    -- velocidad sin tocar el codigo

    -- aca van los puertos, o sea el estado actual de la FSM, el valor que se
    -- esta formando con los switches, cuantas boyas quedan, el tick que marca
    -- el ritmo del parpadeo, y las salidas hacia los 4 LEDs y hacia las tres
    -- senales del LED RGB
end led_driver;

architecture Behavioral of led_driver is

    -- aca van las senales intermedias con el color base y el patron base, antes
    -- de aplicarles el parpadeo

begin

    -- aca va el with select que elige el color RGB segun el estado. es
    -- concurrente, no va dentro de ningun process, y hay que cubrir todos los
    -- casos o cerrar con others para no dejar combinaciones sin definir

    -- aca va el with select que elige el patron de los 4 LEDs segun el estado

    -- aca va la logica que combina el patron con el tick, para que los estados
    -- que deben parpadear parpadeen y los demas queden fijos

end Behavioral;
