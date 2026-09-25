# Roadmap hasta la entrega parcial

Qué sigue, en orden. Cada hito termina en algo que se puede mostrar. La regla es no avanzar al
siguiente hasta que el anterior funcione de verdad, porque si se acumulan dos cosas a medias no
se sabe cuál está fallando.

Para el detalle de qué pide el enunciado y qué cumple cada archivo, ver el README.


## estado actual

    clk_divider     escrito, empaquetado como IP core, puesto en el block design
    debounce        escrito, empaquetado, puesto en el block design
    coord_input     falta escribirlo
    block design    los dos bloques puestos pero sin conectar
    diagrama        no empezado
    repo            README, .gitignore y archivos esqueleto ya subidos

Ojo que el design_1.bd que está en el repo todavía solo tiene clk_divider. Guardar el diagrama
con Ctrl+S y commitear, si no Daniel no ve el debounce.


## hito 1, el LED parpadeando

El objetivo no es que haga algo útil. Es validar el camino completo desde el block design hasta
la placa, que tiene sus propias trampas y ninguna tiene que ver con cuántos bloques haya.

### conectar

Los dos bloques quedan en paralelo, sin cable entre ellos. Es esperable: `clk_divider` entrega un
tick y `debounce` no lo consume, cada uno cuelga del reloj por su lado. El cable entre bloques
llega con `coord_input`, en el hito 2.

    clk    externo  -->  clk_divider.clk  y  debounce.clk
    clk_divider.tick -->  externo, a un LED
    btn    externo  -->  debounce.btn
    debounce.pulso   -->  externo, a otro LED

Para sacar una señal al mundo: click derecho sobre el pin, Make External, o Ctrl+T.

### renombrar los externos

Vivado les pone sufijo, y `clk` queda como `clk_0`. Hay que renombrarlos en las propiedades del
puerto, porque el xdc tiene que calzar exacto con estos nombres. Propuesta:

    clk        el reloj de la placa
    btn0       el pulsador
    led_valor  de 3 bits, se usa recién en el hito 2
    led_tick   el que va a parpadear

### validar y generar

    1  Validate Design, F6. Pilla relojes sin conectar y anchos que no calzan.
    2  click derecho sobre design_1.bd, Create HDL Wrapper, Let Vivado manage
    3  click derecho sobre design_1_wrapper, Set as Top
    4  escribir el constraints.xdc
    5  Run Synthesis, Run Implementation, Generate Bitstream
    6  Open Hardware Manager, Program Device

### el constraints.xdc

Pines de la Zybo Z7-10, sacados del Zybo-Z7-Master.xdc de Digilent:

    clk         K17    y el create_clock de 8 ns
    btn0        K18
    led_valor   M14, M15, G14
    led_tick    D18
    sw          G15, P15, W13    para el hito 2

### qué tiene que pasar

El LED conectado al tick parpadea una vez por segundo.

El LED del pulso **no se va a ver**. El pulso dura un ciclo, o sea 8 nanosegundos. Eso no es un
error, es el comportamiento correcto. Se ve con el ILA en el hito 3, o se nota indirectamente en
el hito 2 cuando `coord_input` lo use para capturar.

Cuando el LED parpadee, el flujo completo está validado y deja de ser un problema.


## hito 2, coord_input y la cadena completa

Es el tercer IP core, el que cierra AO2, y el que convierte tres bloques sueltos en algo que hace
algo visible.

### qué hace

Captura los 3 bits de los switches cuando llega el pulso de confirmación, y los mantiene quietos
hasta la próxima captura.

    entradas   clk, sw(2:0), confirmar
    salida     valor(2:0)
    generico   el ancho del valor, para poder reusarlo si cambia el tablero

Adentro: una señal interna que retiene el valor, un process síncrono que la actualiza solo cuando
`confirmar` está en alto, y una asignación concurrente que la saca al puerto.

Acá conviene meter a propósito dos operadores y dos atributos, y con eso queda AC3. Recordar que
`rising_edge` es función y no cuenta; sirven `'event`, `'range`, `'length`, `'high`, `'low`.

### pasos

    1  escribir coord_input.vhd
    2  escribir tb_coord_input.vhd y simular, instanciando con un generico chico
    3  proyecto nuevo para el IP core, con el part xc7z010clg400-1
    4  Add Sources marcando Copy sources into project
    5  correr la sintesis para confirmar que compila
    6  Tools, Create and Package New IP, Package your current project
    7  en Customization Parameters verificar que aparezca el generico
    8  Review and Package, Package IP

### conectar en el block design

Acá aparece el primer cable de verdad entre dos bloques propios:

    sw(2:0) externo        -->  coord_input.sw
    debounce.pulso         -->  coord_input.confirmar
    coord_input.valor(2:0) -->  externo, a led_valor

### qué tiene que pasar

Mueves los switches, aprietas btn0, y los LEDs se quedan con el valor que elegiste. Sigues
moviendo los switches y los LEDs no cambian hasta el próximo apretón.

Eso es demostrable en la mesa en dos segundos, y es exactamente lo que la rúbrica pide ver
funcionando en la ZYBO. Con esto quedan cerradas **AO2** y, por el design_1.vhd que genera el
wrapper, también **AO1**.


## hito 3, ILA y VIO

Sin esto el tope de los dos slots es 6.0, por buena que sea la implementación. La rúbrica pone el
7.0 en poder demostrarlo con ILA o VIO.

Son dos bloques de Xilinx que se arrastran al block design como cualquier otro.

El ILA graba señales ciclo a ciclo y las dibuja como forma de onda. Conectarle el `pulso` del
debounce, el `valor` capturado y el `tick`. Es la única forma de ver el pulso de 8 ns.

El VIO lee y escribe señales internas desde el PC mientras el diseño corre. Sirve para inyectar
un pulso de confirmación sin tocar el botón, o para forzar un valor y ver qué pasa.

Los dos necesitan el reloj conectado y la placa enchufada por JTAG con el Hardware Manager
abierto.

Con esto queda **AC2**.


## hito 4, capturas

Sacar las capturas en el momento en que cada cosa funciona, no al final. Rearmar un diseño solo
para volver a fotografiarlo es tiempo perdido, y en el informe final los resultados de simulación
valen 3 de los 7 puntos, más que la arquitectura y las actividades juntas.

Qué capturar:

    la ventana de configuracion del generico al hacer doble click en cada IP core
    la simulacion de cada testbench
    el ILA mostrando el pulso del debounce
    el VIO inyectando un valor
    el block design completo
    el design_1.vhd con los components, que es la evidencia de AO1
    la placa funcionando


## en paralelo, el diagrama

Vale el 50% del avance y no depende de nada de lo anterior. Conviene tenerlo listo antes que el
código, no después.

Para el 7.0: hecho en software y no a mano, cada flecha rotulada con el dato que transporta y su
ancho, cada bloque pintado con el color de la actividad que cumple y con la etiqueta encima del
tipo `AO2 2/3`, leyenda de colores.

Guardar el .drawio en el repo, no solo el PDF, para poder editarlo entre los dos. En el repo del
curso está `diagramas_proyecto_1.pdf` con ejemplos de años anteriores en ese formato.


## el dia de la evaluacion

    llevar la ZYBO                       no llevarla es 1.0
    los dos con copia del repo           que lo tenga el ausente es 1.0
    el diagrama impreso o en pantalla
    el proyecto abierto y sintetizado
    las capturas a mano
    el bitstream ya cargado o listo

Y tener claro qué dos slots se presentan: AO1 por el design_1.vhd, AO2 por los tres IP cores.


## despues del avance

En orden de riesgo, no de facilidad. AO3 es lo más caro del proyecto completo y lo que no se puede
dejar para el final: si falta una AO en la entrega final, el tramo de implementación baja a 2
puntos incluso teniendo 6 AC, y eso pega en la nota del video y en la de códigos.

    AO3    board_mem, axi_status_slave con ATG en Test Mode,
           axi_config_slave con ATG en Advance Mode
    AC1    game_fsm con los estados recorriendose
    AC5    led_driver con with select concurrente
    AC6    sep_pkg con la function idx() y el procedure capture_coord()
    AC7    el PS generando la colocacion y escribiendola al PL por AXI,
           o AXI SmartConnect como plan B mas barato
    juego  primero el loop de combate con las boyas en posiciones fijas,
           despues la colocacion manual. asi el peor escenario es un
           proyecto completo con colocacion fija y no uno a medias

Y al final: informe en LaTeX, video de 5 a 15 minutos, y el zip con la carpeta raíz del proyecto
más una carpeta por cada IP core. Subir más de 3 archivos o nombrarlos mal penaliza un punto.
