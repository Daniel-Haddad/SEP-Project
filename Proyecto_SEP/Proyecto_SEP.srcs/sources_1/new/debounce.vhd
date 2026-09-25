-- Limpia el rebote mecanico de un boton y entrega un pulso de un solo ciclo
-- cada vez que el boton se aprieta. Un pulsador rebota unos milisegundos al
-- apretarlo, y a 125 MHz eso son cientos de miles de transiciones, asi que un
-- solo apreton se contaria como muchos.
--
-- La idea es no mirar el boton cada 8 ns sino cada pocos milisegundos. Entre
-- muestra y muestra el rebote ya se acabo, asi que lo que se lee es el estado
-- estable. Despues se comparan dos muestras seguidas para saber si el boton
-- acaba de pasar de suelto a apretado, y solo ahi sale el pulso. Sin esa parte
-- la salida quedaria en alto todo el rato que mantienes el boton apretado.
--
-- Este modulo no sabe a que boton esta conectado. Cual es se decide en el block
-- design y en el constraints.xdc; para btn0 el pin es K18.
--
-- Estructura basada en BTNS_debouncer.vhd de la ayudantia AYUD03, que a su vez
-- viene de fpga4student.com. Las diferencias con esa version estan comentadas
-- mas abajo. Ambas fuentes van referenciadas en el informe.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    generic (
        -- Cuantos ciclos de reloj esperar entre muestra y muestra.
        -- 250_000 a 125 MHz son 2 ms, de sobra para que se asiente el rebote.
        -- En el testbench se instancia con un valor chico, tipo 4, para no
        -- tener que simular milisegundos.
        CICLOS : integer := 250_000
    );
    port (
        clk   : in  std_logic;   -- reloj de la placa, 125 MHz
        btn   : in  std_logic;   -- entrada cruda del pulsador
        pulso : out std_logic    -- un ciclo en alto por cada apreton
    );
end debounce;

architecture Behavioral of debounce is

    -- Se levanta un solo ciclo cada CICLOS. Marca cuando toca muestrear.
    signal enable_lento : std_logic := '0';

    -- Cadena de muestreo. q0 es la muestra mas reciente, q2 la mas vieja.
    -- Tres etapas, igual que los tres flip-flops de la ayudantia.
    signal q0, q1, q2 : std_logic := '0';

    -- Señal interna del pulso, porque un puerto out no se puede leer.
    signal pulso_int : std_logic := '0';

begin

    ----------------------------------------------------------------------
    -- Generador del enable lento.
    -- En la ayudantia esto era una entity aparte, clock_enable_debouncing
    -- _button. Aca va adentro para que el modulo sea autocontenido y se
    -- pueda empaquetar como un solo IP core.
    -- La cuenta va en una variable y no en una señal para que cuenta + 1
    -- use el valor recien escrito. Esto es AC4.
    ----------------------------------------------------------------------
    gen_enable : process(clk)
        variable cuenta : integer range 0 to CICLOS := 0;
    begin
        if rising_edge(clk) then
            if cuenta = CICLOS - 1 then
                cuenta       := 0;
                enable_lento <= '1';
            else
                cuenta       := cuenta + 1;
                enable_lento <= '0';
            end if;
        end if;
    end process gen_enable;

    ----------------------------------------------------------------------
    -- Muestreo y deteccion de flanco.
    --
    -- Cuando enable_lento se levanta, la cadena corre un lugar: q0 toma el
    -- boton, q1 toma el q0 anterior, q2 toma el q1 anterior. O sea que q1 y
    -- q2 son dos muestras consecutivas separadas por CICLOS ciclos.
    --
    -- Si q1 esta en 1 y q2 en 0, entre esas dos muestras el boton paso de
    -- suelto a apretado. Ese es el flanco, y ahi sale el pulso.
    --
    -- Diferencia con la ayudantia: alla el pulso se calculaba de forma
    -- concurrente, con Q1 and not Q2, y quedaba en alto durante todo un
    -- periodo lento, o sea 250.000 ciclos. Para una maquina de estados
    -- corriendo a 125 MHz eso seria un desastre: avanzaria 250.000 veces de
    -- un solo apreton. Aca el pulso se registra adentro del process, asi
    -- que dura exactamente un ciclo de reloj.
    --
    -- El pulso_int <= '0' de la primera linea es el valor por defecto: si
    -- ninguna condicion de mas abajo lo levanta, la señal vuelve sola a
    -- cero al ciclo siguiente.
    ----------------------------------------------------------------------
    muestreo : process(clk)
    begin
        if rising_edge(clk) then

            pulso_int <= '0';

            if enable_lento = '1' then
                q0 <= btn;
                q1 <= q0;
                q2 <= q1;

                if q1 = '1' and q2 = '0' then
                    pulso_int <= '1';
                end if;
            end if;

        end if;
    end process muestreo;

    -- Puente de la señal interna hacia el puerto de salida.
    pulso <= pulso_int;

end Behavioral;
