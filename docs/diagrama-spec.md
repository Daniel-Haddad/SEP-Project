# Especificacion del diagrama

Lista de bloques, puertos y cables para dibujar en draw.io. Cada cable va rotulado con el nombre
y el ancho, porque la rubrica pide que los datos vayan escritos sobre las flechas.

Estan separados en tres grupos: el nucleo, que es lo del avance; AO3, que es despues; y los
opcionales, con la razon de cada uno al final.


## pines fisicos

    ENTRADAS
    clk              K17            125 MHz
    btn_confirmar    K18            BTN0
    btn_reset        Y16            BTN3
    sw(2:0)          G15, P15, W13  SW0 a SW2

    SALIDAS
    led(3:0)         M14, M15, G14, D18
    rgb_r            V16            verificar en la placa, el ejemplo del curso los tenia
    rgb_g            F17            invertidos respecto de los comentarios de Digilent
    rgb_b            M17


## bloques del nucleo

Ocho cajas. Las tres primeras ya estan hechas y funcionando.

    clk_divider_lento      generic DIV = 62_500_000        HECHO
      in   clk
      out  tick

    clk_divider_rapido     generic DIV = 15_625_000        HECHO (segunda instancia)
      in   clk
      out  tick

    debounce_confirmar     generic CICLOS = 250_000        HECHO
      in   clk, btn
      out  pulso

    debounce_reset         generic CICLOS = 250_000        HECHO (segunda instancia)
      in   clk, btn
      out  pulso

    coord_input_x          generic ANCHO = 3               HECHO
      in   clk, sw(2:0), confirmar
      out  valor(2:0)

    coord_input_y          generic ANCHO = 3               HECHO (segunda instancia)
      in   clk, sw(2:0), confirmar
      out  valor(2:0)

    game_fsm               generic N_BOYAS = 4
      in   clk, reset, pulso, coord_x(2:0), coord_y(2:0), hay_boya, boyas_vivas(2:0)
      out  estado(3:0), cap_x, cap_y, addr(5:0), we, rd

    board_mem              generic N_CELDAS = 64
      in   clk, addr(5:0), we, rd
      out  hay_boya, boyas_vivas(2:0)

    led_driver
      in   estado(3:0), sw(2:0), boyas_vivas(2:0), tick_lento, tick_rapido
      out  led(3:0), rgb_r, rgb_g, rgb_b


## cables del nucleo

El reloj va a todos, conviene dibujarlo como un bus que baja por el costado y no como seis
flechas cruzando el diagrama.

    clk                        -->  clk_divider_lento.clk
    clk                        -->  clk_divider_rapido.clk
    clk                        -->  debounce_confirmar.clk
    clk                        -->  debounce_reset.clk
    clk                        -->  coord_input_x.clk
    clk                        -->  coord_input_y.clk
    clk                        -->  game_fsm.clk
    clk                        -->  board_mem.clk

Botones y switches hacia adentro:

    btn_confirmar              -->  debounce_confirmar.btn
    btn_reset                  -->  debounce_reset.btn
    sw(2:0)                    -->  coord_input_x.sw
    sw(2:0)                    -->  coord_input_y.sw
    sw(2:0)                    -->  led_driver.sw

Los pulsos limpios:

    debounce_confirmar.pulso   --pulso_confirmar-->   game_fsm.pulso
    debounce_reset.pulso       --pulso_reset-->       game_fsm.reset

La FSM decide cual coordenada se captura. Esto es importante: las dos instancias de coord_input
reciben los mismos switches, asi que si les llegara el mismo pulso capturarian lo mismo. Por eso
el pulso entra a la FSM y la FSM saca dos habilitaciones ya filtradas segun el estado.

    game_fsm.cap_x             --cap_x-->             coord_input_x.confirmar
    game_fsm.cap_y             --cap_y-->             coord_input_y.confirmar

Las coordenadas capturadas vuelven a la FSM:

    coord_input_x.valor(2:0)   --coord_x(2:0)-->      game_fsm.coord_x
    coord_input_y.valor(2:0)   --coord_y(2:0)-->      game_fsm.coord_y

La FSM contra el tablero. La direccion de 6 bits sale de juntar las dos coordenadas de 3 bits,
que es lo que hace la function idx() del package:

    game_fsm.addr(5:0)         --addr(5:0)-->         board_mem.addr
    game_fsm.we                --we-->                board_mem.we
    game_fsm.rd                --rd-->                board_mem.rd
    board_mem.hay_boya         --hay_boya-->          game_fsm.hay_boya
    board_mem.boyas_vivas(2:0) --boyas_vivas(2:0)-->  game_fsm.boyas_vivas

Hacia la salida visible:

    game_fsm.estado(3:0)       --estado(3:0)-->       led_driver.estado
    board_mem.boyas_vivas(2:0) --boyas_vivas(2:0)-->  led_driver.boyas_vivas
    clk_divider_lento.tick     --tick_lento-->        led_driver.tick_lento
    clk_divider_rapido.tick    --tick_rapido-->       led_driver.tick_rapido

    led_driver.led(3:0)        -->  led(3:0)
    led_driver.rgb_r           -->  rgb_r
    led_driver.rgb_g           -->  rgb_g
    led_driver.rgb_b           -->  rgb_b


## AO3, el grupo AXI

Va aparte, en su propio recuadro del diagrama, porque es para despues del avance y porque
conviene que se vea como un subsistema separado de la logica del juego.

    ATG Test Mode          bloque de Xilinx, maestro
      out  M_AXI

    ATG Advance Mode       bloque de Xilinx, maestro
      out  M_AXI

    AXI SmartConnect       bloque de Xilinx
      in   dos M_AXI
      out  dos S_AXI

    axi_status_slave       propio, de lectura
      in   clk, S_AXI, estado(3:0), boyas_vivas(2:0)
      out  respuesta AXI

    axi_config_slave       propio, de escritura
      in   clk, S_AXI
      out  boyas_iniciales(63:0), carga_valida

Cables:

    ATG Test Mode.M_AXI            --AXI4-Lite-->   SmartConnect
    ATG Advance Mode.M_AXI         --AXI4-Lite-->   SmartConnect
    SmartConnect                   --AXI4-Lite-->   axi_status_slave.S_AXI
    SmartConnect                   --AXI4-Lite-->   axi_config_slave.S_AXI
    game_fsm.estado(3:0)           -->              axi_status_slave.estado
    board_mem.boyas_vivas(2:0)     -->              axi_status_slave.boyas_vivas
    axi_config_slave.boyas_inic    --64 bits-->     board_mem.carga_inicial

El ATG en Test Mode lee el estado del juego. El ATG en Advance Mode escribe la colocacion inicial
de las boyas en el tablero, que es el rol que ese modo hace bien: cargar un bloque de datos.


## sondas, AC2

No son bloques del diseno, son instrumentos. Conviene dibujarlos en un tono distinto y con lineas
punteadas, para que se vea que observan y no participan.

    ILA    bloque de Xilinx
      observa   pulso_confirmar, coord_x(2:0), coord_y(2:0), estado(3:0), hay_boya

    VIO    bloque de Xilinx
      inyecta   pulso_confirmar forzado, reset forzado
      lee       estado(3:0), boyas_vivas(2:0), el tablero completo de 64 bits


## nota, no dibujar sep_pkg como bloque

Un package no tiene puertos, no se instancia y no se conecta con flechas. Va como anotacion al
costado, con linea punteada hacia los bloques que lo usan:

    sep_pkg    function idx(x,y) convierte las dos coordenadas de 3 bits en la direccion de 6
               procedure capture_coord() devuelve varias salidas a la vez
               lo usan game_fsm y board_mem

Si se dibuja como caja con flechas, cualquiera que sepa VHDL nota que no calza.


## opcionales, y por que

Ninguno es necesario para el avance. Si se dibujan, conviene marcarlos como futuros para que el
corrector no crea que estan prometidos.

    Zynq Processing System
    Es el procesador ARM del chip. Va solo si la AC7 elegida es que el PS genere la colocacion de
    las boyas y la escriba al PL por AXI. Es la AC7 mas vistosa y la mas cara. Referencia: AYUD03.

    Clocking Wizard
    Sintetiza un reloj de otra frecuencia con el hardware dedicado del chip. No reemplaza al
    clk_divider, porque no baja de unos 4,7 MHz. Serviria si el AXI termina pidiendo otra
    frecuencia, o para limpiar el reloj de entrada. Tambien es candidato al punto de originalidad
    del video si se configura de una forma no vista en clases y se sabe explicar.

    Processor System Reset
    Genera resets sincronizados con el reloj. Cuando entre el AXI va a hacer falta, y Connection
    Automation lo agrega solo. Dibujarlo recien cuando aparezca.

    battleship_top
    Un top escrito a mano que instancie tres o mas componentes. Ahora que el block design es el
    top, AO1 ya esta cubierta por el design_1.vhd que genera el wrapper. Serviria solo como
    respaldo, para poder explicar AO1 con codigo propio y no autogenerado.

    tercer debounce
    Si quieren un boton separado para disparar, en vez de que el mismo boton de confirmar sirva
    para todo. No aporta nota, solo comodidad de juego.

    matriz LED 8x8 por Pmod
    Para que el publico vea el tablero completo en el video. Requiere hardware externo y un
    maestro SPI. Es un AC7 alternativo. Dejarlo para el final, si sobra tiempo.


## para el 7.0 del diagrama

    hecho en software, no a mano
    cada flecha rotulada con el nombre del dato y su ancho, no "coordenada" sino coord_x(2:0)
    cada bloque pintado segun la actividad que cumple, con la etiqueta encima tipo AO2 2/3
    leyenda de colores
    los bloques de Xilinx marcados como tales, porque el video pide distinguir lo propio
    los tres que ya funcionan marcados de alguna forma, para que se vea que no es solo plan
