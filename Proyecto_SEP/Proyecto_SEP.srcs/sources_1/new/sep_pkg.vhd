-- Package compartido del proyecto. Junta las constantes, los tipos y las dos
-- rutinas que usan varios modulos, para no repetirlas en cada archivo. Aca se
-- cumple AC6, que pide una function y un procedure explicitando en que se
-- diferencian: la function devuelve un solo valor y no modifica nada de lo que
-- recibe, el procedure puede devolver varias salidas a la vez.
-- Un package no tiene entity ni architecture, tiene una parte de declaracion y
-- un body donde va el codigo de verdad.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package sep_pkg is

    -- aca van las constantes del tablero, como el largo del lado y cuantas
    -- boyas hay que colocar

    -- aca va el type propio que representa el tablero, si decidimos usar uno

    -- aca va la declaracion de la function idx, que recibe una coordenada X y
    -- una Y y devuelve la posicion equivalente dentro del tablero. aca solo se
    -- declara que existe y que forma tiene, el codigo va mas abajo

    -- aca va la declaracion del procedure capture_coord, que a diferencia de la
    -- function puede escribir varias salidas a la vez

end sep_pkg;

package body sep_pkg is

    -- aca va el cuerpo de la function idx, con el calculo que convierte fila y
    -- columna en una sola direccion del tablero

    -- aca va el cuerpo del procedure capture_coord, con lo que hace y como
    -- escribe cada uno de sus parametros de salida

end sep_pkg;
