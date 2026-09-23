# Batalla Naval en Zybo Z7

Proyecto 1 del curso IEE2463 Sistemas Electrónicos Programables, PUC.
Profesor Michel Rozas Fernández (mvrozas@uc.cl), ayudante coordinador Pablo Uribe (parred@uc.cl).


## concepto

Batalla naval sobre un tablero de 8x8 que existe solo como estado interno de la FPGA. No se
muestra en ninguna pantalla: se juega a ciegas y lo único que se recibe es la respuesta de cada
disparo. Eso es propio del juego y además calza con que la tarjeta solo tiene 4 LEDs.

Se simplificó: los barcos son de una sola casilla, boyas más que barcos. Primero se colocan las
boyas eligiendo una coordenada para cada una, después se dispara y cada disparo responde agua o
impacto. Termina cuando todas fueron alcanzadas.

Alcance de esta entrega: un jugador. Dos jugadores queda como extensión posterior, y tiene la
limitación de que los switches y LEDs son compartidos y visibles.

### interfaz

Solo hardware integrado: 3 switches, botones, 4 LEDs y 1 LED RGB.

La coordenada se ingresa en dos etapas, primero X y después Y, porque 8x8 necesita 3 bits por
eje y solo hay 4 switches. Es restricción de hardware, no decisión estética, y conviene decirlo
en el informe.

Los 4 LEDs cambian de significado según el estado: durante la selección muestran el número que
se está formando, el resto del tiempo las boyas vivas. El RGB indica el estado; con 8 colores y
fijo o parpadeante son 16 contextos, suficientes.


## lo que pide el enunciado

### actividades obligatorias

AO1: Utilice components para integrar al menos tres componentes dentro de otra entity.

AO2: Genere al menos 3 diferentes packages (IP-Cores) en vivado block design para incorporar
sus códigos. Utilice parámetros genéricos para la configuración de sus packages.

AO3: Utilice comunicación AXI para comunicar: i) al menos un IP core esclavo creado por ud.
con un ATG maestro en Test Mode y ii) al menos un IP-core esclavo creado por ud. con un ATG
maestro en Advance Mode.

### actividades complementarias

AC1: Genere una máquina de estados que esté asociada a parte o a el total de su proyecto.

AC2: Utilice Vio e ILA para monitorear y modificar señales de su proyecto.

AC3: Utilice al menos 2 operadores y 2 atributos diferentes.

AC4: Utilice variables para actualizar valores instantáneamente en alguna parte de la lógica
programada.

AC5: Utilice código secuencial y código concurrente y evidencie claramente la diferencia de
funcionamiento de ambos tipos de códigos.

AC6: Haga uso de functions y procedures, donde el uso de ambas rutinas explicite sus
diferencias principales.

AC7: Implemente alguna función que no se haya presentado en el curso. Esto puede ser activar
algún hardware integrado en la ZYBOZ7, implementar la interconexión entre el PL y algún
periférico elemento del zynq (memorias, EMIO, DMA, snoop control, etc), utilizar una variante
de AXI no vista en clases, etc.

Dos trampas. En AC3 `rising_edge()` es función, no atributo: si la contamos nos falta uno; sirven
`'event`, `'length`, `'range`, `'high`, `'low`. En AO2 el genérico tiene que afectar de verdad el
comportamiento, declararlo y no usarlo no cuenta.

Todo lo que venga de otra fuente va referenciado, incluida la asistencia de IA y de qué partes.
Lo no referenciado se asume propio, y si aparece en internet durante la revisión es plagio.


## la entrega parcial

    NAP1 = 0.5 * Diagrama + 0.25 * Slot1 + 0.25 * Slot2

Son tres checks. El diagrama es obligatorio y no se reemplaza. Los slots son dos AO a elección,
y solo una de las dos puede cambiarse por dos AC, promediando sus notas. O sea que el avance no
pide las tres AO.

    check 1   diagrama, 50%        obligatorio siempre, no necesita código
    check 2   slot 1 = AO1         el design_1.vhd que genera el wrapper, y battleship_top
    check 3   slot 2 = AO2         tres IP cores propios con genéricos en el block design

Como la presentación exige block design con bloques propios, AO2 quedó obligatoria y ya no tiene
sentido reemplazar un slot por dos AC. Las dos salen del mismo trabajo.

Qué archivo cumple qué:

    diagrama.drawio       check 1
    constraints.xdc       habilita el 7.0 de los checks 2 y 3
    clk_divider.vhd       AO1 componente, AC4
    debounce.vhd          AO1 componente, AC4
    coord_input.vhd       AO1 componente, AC3
    led_driver.vhd        AO1 componente, AC5 concurrente
    battleship_top.vhd    AO1 completa
    sep_pkg.vhd           AC6
    game_fsm.vhd          AC1, AC5 secuencial
    board_mem.vhd         AO2 1/3
    axi_status_slave      AO2 2/3, AO3
    axi_config_slave      AO2 3/3, AO3
    tb_*.vhd              nota semanal 5.0 y evidencia de los slots
    ILA + VIO             AC2, habilita el 7.0 de los checks 2 y 3

El 7.0 de cada slot exige que funcione, que sea coherente con el diagrama y que se demuestre con
ILA o VIO en la tarjeta. Sin eso el tope es 6.0, y si no calza con el diagrama es 5.0.

El 7.0 del diagrama exige software y no mano, cada flecha rotulada con su dato, colores indicando
dónde se cumple cada actividad, y leyenda.

AC1, AC2, AC3 y AC5 salen como subproducto aunque no sean el slot elegido, y cuentan para la
entrega final.

Dos cosas que valen 1.0 si fallan: llevar la Zybo a la evaluación, y que los dos tengamos copia
del repositorio.

En las jornadas PROG llaman al azar a 3 a 5 grupos. Esperan AC4 en PROG02, AC5 en PROG03 y AC6
en PROG04. Es 5.0 con testbench y simulaciones, 7.0 si además se muestra en la tarjeta.


## opciones de planificación

    opción 1   AO1 + (AC4 y AC6)   la más barata, y AC4/AC6 son lo que piden PROG02 y PROG04
    opción 2   AO1 + AO2           más cara, pero adelanta el camino a AO3, que es el riesgo real
    opción 3   AO1 + (AC4 y AC5)   igual que la 1, otro par

La elección no se amarra hasta el día de la evaluación: se escribe el código y se decide al final
qué presentar. Conviene apuntar a la opción 2 con la 1 como red de seguridad, porque AC4, AC5 y
AC6 van a salir igual al escribir los módulos base.

Si falta una AO en la entrega final el tramo de implementación baja a 2 puntos incluso con 6 AC,
y eso pega en la nota del video y en la de códigos. Por eso AO3 no se puede dejar para el final.


## block design e IP cores

La presentación exige mostrar el block design con bloques propios, así que AO2 pasa a ser
obligatoria para la entrega parcial. Ya no alcanza con un solo top VHDL.

La estructura es un proyecto de Vivado por cada IP core, más el proyecto principal que contiene
el block design. Es lo que hace la ayudantía 03 y lo que pide el enunciado para el zip final,
que exige una carpeta adicional por cada IP core creado.

    SEP-Project/
    ├── Proyecto_SEP/        proyecto principal, aqui vive el block design
    └── IPCores/
        ├── clk_divider/
        │   ├── clk_divider.xpr
        │   └── clk_divider.srcs/
        │       ├── component.xml                  esto lo convierte en IP
        │       ├── sources_1/new/clk_divider.vhd
        │       └── sim_1/new/tb_clk_divider.vhd
        ├── coord_input/
        └── ...

El flujo para cada IP core es: proyecto nuevo, escribir el vhd, simularlo, Tools > Create and
Package New IP, y queda el component.xml. Después en el proyecto principal se agrega la carpeta
IPCores como IP repository, y los bloques aparecen en el catálogo listos para arrastrar.

La prueba de AO2 es que al hacer doble click sobre el bloque en el block design se abre una
ventana de configuración con el genérico. Si no aparece, el empaquetado no lo tomó.

Sobre AO1. Al hacer Create HDL Wrapper, Vivado genera dos archivos. El `design_1_wrapper.vhd`
declara un solo component y conecta con los pines. El `design_1.vhd` es el block design traducido
a VHDL, y ese declara e instancia un component por cada bloque que pusimos. Eso es literalmente
lo que pide AO1, y sale sin escribir una línea.

El detalle es que ese código lo genera Vivado, no nosotros. Por eso conviene además que
`battleship_top.vhd` instancie sus componentes a mano: AO1 queda cubierta por los dos lados y se
puede explicar de cualquiera de las dos formas cuando pregunten.

Los bloques de Xilinx como el ATG, el ILA o el VIO pueden estar en el block design, pero no
cuentan para AO2: el enunciado pide packages para incorporar nuestros códigos.


## archivos

En orden. No avanzar al siguiente hasta que el anterior compile.

    constraints.xdc       obligatorio       pines: clk en K17, sw, btn, led, RGB, y create_clock de 8 ns
    clk_divider.vhd       obligatorio       -- done --  cuenta tics y da vuelta la salida. genérico DIV
    debounce.vhd          obligatorio       limpia el rebote del botón, entrega un pulso de un ciclo
    coord_input.vhd       obligatorio       captura 3 bits de los switches al confirmar. se instancia 3 veces
    sep_pkg.vhd           solo si slot 2 = AC4+AC6    function idx(x,y) y procedure capture_coord()
    led_driver.vhd        obligatorio       estado -> patrón de LEDs y color RGB, con with/select
    battleship_top.vhd    obligatorio       top que instancia los 4 anteriores. cierra AO1
    game_fsm.vhd          recomendado       fases SETUP, PLAY, END. basta que los estados se recorran
    tb_clk_divider.vhd    obligatorio       instanciar con DIV => 5, si no la simulación tarda 40 min
    tb_debounce.vhd       obligatorio
    tb_coord_input.vhd    obligatorio
    ILA y VIO             para el 7.0       ILA graba señales ciclo a ciclo, VIO las lee y modifica en vivo

Las capturas de simulación e ILA/VIO se toman cuando cada etapa funciona, no después. En el
informe final los resultados de simulación valen 3 de los 7 puntos.

Fuera del mínimo: `board_mem.vhd`, `placement_fsm.vhd`, `combat_fsm.vhd`, `axi_status_slave` y
`axi_config_slave`. AO2 completa y AO3 apuntan a la entrega final.


## estados

Provisorio, ajustar al dibujar el diagrama.

    S_START           espera inicial
    S_PLACE_X         eligiendo X de la boya
    S_PLACE_Y         eligiendo Y de la boya
    S_VALIDATE        transitorio, revisa si la celda ya estaba ocupada
    S_PLACE_ERR       celda ocupada, repetir
    S_READY           boyas colocadas
    S_AIM_X           eligiendo X del disparo
    S_AIM_Y           eligiendo Y del disparo
    S_RESOLVE         transitorio, consulta el tablero
    S_RESULT_AGUA     falló
    S_RESULT_IMPACTO  acertó
    S_WIN             no quedan boyas

Desde S_VALIDATE, si estaba ocupada va a S_PLACE_ERR y vuelve a S_PLACE_X; si estaba libre y
quedan boyas vuelve a S_PLACE_X con la siguiente, y si no quedan pasa a S_READY. El combate va
S_AIM_X, S_AIM_Y, S_RESOLVE, un resultado, y de vuelta a S_AIM_X o a S_WIN.

Datos: `tablero_boyas` 64 bits, uno por celda. `tablero_disparos` 64 bits. `boyas_vivas`, un
contador. Con barcos de largo variable haría falta un id de 3 bits por celda y contadores de
impactos por barco; con boyas no.


## el diagrama

Es un dibujo en draw.io, no el block design de Vivado. Vale el 50% y no necesita código, así que
va en paralelo con los módulos.

    clk_divider        clk -> tick
    debounce x4        btn -> pulso limpio de un ciclo
    coord_input x3     sw(2:0) + confirmar -> valor(2:0)
    placement_fsm      coords -> estado, escritura al tablero
    combat_fsm         coords -> estado, consulta al tablero
    game_fsm           -> fase SETUP / PLAY / END
    board_mem          addr(5:0), dato, we -> agua / impacto
    led_driver         estado -> led(3:0), rgb(2:0)
    axi_status_slave   cuelga de un ATG en Test Mode
    axi_config_slave   cuelga de un ATG en Advance Mode
    ILA y VIO          bloques de Xilinx, marcarlos como tales
    battleship_top     el marco que contiene a los demás

Entradas a la izquierda, salidas a la derecha. Cada flecha rotulada con el dato y su ancho, o sea
`coord_x(2:0)` y no "coordenada". Cada bloque pintado según la actividad que cumple, con la
etiqueta encima del tipo `AO2 2/3`. Leyenda de colores. Guardar el `.drawio` en el repo, no solo
el PDF.

`diagramas_proyecto_1.pdf` en el repo del curso tiene ejemplos de años anteriores con ese formato.


## repositorio

Se versionan `.vhd`, `.xdc`, `.xpr`, el block design, los IP cores y la documentación. El resto
lo filtra el `.gitignore`.

Los archivos de Vivado no se fusionan: cada uno es dueño de sus módulos, y el block design lo
edita uno a la vez avisando antes.

`git pull` antes de empezar.


## decisiones pendientes

Nombre del proyecto. Define el nombre del PDF y del video en la entrega final, y equivocarse en
el formato penaliza un punto.

Cuántas boyas. Cuatro calza con los cuatro LEDs; con más habría que multiplexar esa información
también.

Si se puede disparar dos veces a la misma celda. Permitirlo es más simple; bloquearlo necesita
un estado de error. Si se permite, `tablero_disparos` se podría eliminar.

Nombre del módulo de captura. El repo tiene `input_coords.vhd` y todo lo demás dice
`coord_input`. Hay que borrar uno, la incoherencia con el diagrama tiene tope 5.0.

Qué dos actividades presentamos. Ver opciones de planificación.

Cuál AC7. La idea es que el PS genere la colocación y la escriba al PL por AXI, apoyándose en
AYUD03. Alternativa más barata: usar AXI SmartConnect explicando su rol, que es lo que hizo el
proyecto de ejemplo del curso.

Confirmar que Vivado 2020.1 es la versión de los laboratorios.

Borrar la copia duplicada del repo en `C:\Users\lucas\Documents\SEP\PROY01\SEP-Project`.


## referencias

Repo del curso: enunciado, rúbrica del avance, penalizaciones, plantilla LaTeX del informe y
`diagramas_proyecto_1.pdf`.

`REF-Programacion-VHDL` tiene una cápsula por tema (la 7 para AC4, 5 y 6 para AC5, 8 para AO1, 9
para AC6, 10 para AC1) y `REF-Lecturas` las de Zynq/AXI, ATG e IP Cores para AO3. En ayudantías,
AYUD03 sirve para AC7 y trae un `BTNS_debouncer.vhd`, AYUD04 es ILA y VIO, y hay una de
exportación de archivos que es obligatoria para armar el zip final.

El curso publicó Conway's Game of Life como ejemplo: misma grilla 8x8 con 4 LEDs y los dos ATG,
con informe completo. Los zip de ese paquete son punteros de Git LFS.
