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

Son tres checks. El diagrama es obligatorio y no se reemplaza. Los otros dos son actividades
obligatorias a elección.

    check 1   diagrama, 50%    obligatorio siempre, no necesita codigo
    check 2   slot 1 = AO1     el design_1.vhd que genera Create HDL Wrapper
    check 3   slot 2 = AO2     tres IP cores propios con genericos en el block design

Como la presentacion exige block design con bloques propios, AO2 quedo obligatoria. Ya no tiene
sentido cambiar un slot por dos AC: los dos slots salen del mismo trabajo.

El 7.0 de cada slot exige que funcione, que sea coherente con el diagrama y que se demuestre con
ILA o VIO en la tarjeta. Sin eso el tope es 6.0, y si no calza con el diagrama es 5.0.

El 7.0 del diagrama exige software y no mano, cada flecha rotulada con su dato, colores indicando
donde se cumple cada actividad, y leyenda.

Dos cosas que valen 1.0 si fallan: llevar la Zybo a la evaluacion, y que los dos tengamos copia
del repositorio.

En las jornadas PROG llaman al azar a 3 a 5 grupos. Esperan AC4 en PROG02, AC5 en PROG03 y AC6
en PROG04. Es 5.0 con testbench y simulaciones, 7.0 si ademas se muestra en la tarjeta.


## el minimo

Con una sola pieza de trabajo se cierran las dos AO.

    tres IP cores propios, cada uno con un generico, puestos en un block design

AO2 son esos tres packages con parametros genericos, que es su texto literal. AO1 sale del
design_1.vhd que Vivado genera al hacer Create HDL Wrapper, porque ese archivo declara e
instancia un component por cada bloque del diagrama, y con tres ya cumple.

Los tres elegidos:

    clk_divider    generico DIV, cuantos ciclos contar        -- done --
    debounce       generico con los ciclos de espera
    coord_input    generico con el ancho del valor

La prueba de AO2 es que al hacer doble click sobre el bloque se abra una ventana con el generico.
Si sale vacia, el empaquetado no lo tomo y hay que rehacerlo. Captura esa ventana, es la
evidencia para el avance y para el video.

### lo que sale casi gratis encima

AC4, variables. Ya esta hecha: el contador de clk_divider es una variable, y el de debounce
tambien lo sera. Cero trabajo extra.

AC2, VIO e ILA. Es arrastrar dos bloques de Xilinx al block design y conectarles las senales que
queremos mirar. Ademas hace falta igual, porque sin demostracion con ILA o VIO el tope de los dos
slots es 6.0.

AC3, dos operadores y dos atributos. Sale gratis si al escribir coord_input y debounce se usan a
proposito. Ojo que rising_edge es funcion y no cuenta como atributo; sirven 'event, 'range,
'length, 'high, 'low.

Con eso quedan las dos AO y tres AC sin desviarse del camino.

### lo que cuesta un poco mas

AC5, secuencial contra concurrente. Pide un cuarto IP core, led_driver, escrito con with select
concurrente para que contraste con los process de los otros modulos.

AC1, maquina de estados. Pide game_fsm, aunque sea con los estados vacios recorriendose.

AC6, function y procedure. Pide sep_pkg con idx() y capture_coord().

Ninguna de las tres es necesaria para el avance, pero las tres se piden en las jornadas PROG y
las tres cuentan para la entrega final.


## block design e IP cores

Hay dos tipos de proyecto de Vivado y conviene tenerlos separados en la cabeza.

Uno por cada IP core. Chico, contiene un solo vhd y su testbench. Su producto no es un bitstream
sino un component.xml, que es lo que convierte el vhd en una cajita arrastrable.

Y el proyecto principal, que casi no escribe VHDL. Su trabajo es tener el block design donde se
arrastran esas cajitas, conectarlas y generar el bitstream.

### estructura real en el repo

    SEP-Project/
    ├── Proyecto_SEP/                      proyecto principal
    │   ├── Proyecto_SEP.xpr
    │   ├── Ipcores/                       aqui viven los IP empaquetados
    │   │   ├── component.xml              lo que lo hace un IP
    │   │   ├── src/clk_divider.vhd
    │   │   └── xgui/clk_divider_v1_0.tcl  dibuja la ventana del generico
    │   └── Proyecto_SEP.srcs/
    │       └── sources_1/bd/design_1/
    │           ├── design_1.bd            el block design, esto es el diagrama
    │           └── ip/design_1_clk_divider_0_0/*.xci
    └── clk_divider/                       proyecto fuente del IP core
        ├── clk_divider.xpr
        └── clk_divider.srcs/sources_1/new/clk_divider.vhd

El block design no vive en el xpr. El xpr es un indice que apunta al design_1.bd, y ese bd es el
diagrama completo guardado como texto. El xci de al lado guarda con que valor de generico quedo
configurado cada bloque.

Cuando esten los tres IP cores conviene mover todo a una carpeta IPCores en la raiz, porque el
enunciado pide para el zip final una carpeta adicional por cada IP core creado.

### al clonar en otro computador

Vivado no guarda la ruta del IP repository dentro del xpr, asi que no viaja en git. El que clone
tiene que configurarla a mano, una vez:

    Settings > IP > Repository > + > agregar Proyecto_SEP/Ipcores

Sin eso el bloque aparece bloqueado o con signo de interrogacion al abrir el block design. Y ojo
que en el panel Sources de Vivado nunca aparece una carpeta Ipcores: un IP empaquetado no es una
fuente del proyecto, aparece en el IP Catalog bajo User Repository y como bloque en el diagrama.

### el flujo, de punta a punta

Para fabricar cada IP core, en su propio proyecto nuevo:

    1  File > Project > New, mismo part que el principal: xc7z010clg400-1
    2  Add Sources, marcando Copy sources into project
    3  correr la sintesis para confirmar que compila
    4  Tools > Create and Package New IP > Package your current project
    5  en Customization Parameters verificar que aparezca el generico
    6  Review and Package > Package IP

Para consumirlos, en el proyecto principal:

    1  Settings > IP > Repository, agregar la carpeta de los IP
    2  Create Block Design
    3  boton + , buscar el IP por nombre, aparece bajo User Repository
    4  doble click al bloque para configurar el generico
    5  conectar arrastrando de pin a pin
    6  click derecho sobre un pin > Make External para los puertos fisicos
    7  Validate Design, F6
    8  click derecho sobre design_1.bd > Create HDL Wrapper
    9  click derecho sobre design_1_wrapper > Set as Top
    10 sintesis, implementacion, bitstream

### sobre AO1 y el wrapper

Create HDL Wrapper genera dos archivos. El design_1_wrapper.vhd declara un solo component y
conecta con los pines. El design_1.vhd es el block design traducido a VHDL, y ese declara e
instancia un component por cada bloque del diagrama. Eso es literalmente lo que pide AO1, y sale
sin escribir una linea.

El detalle es que ese codigo lo genera Vivado, no nosotros. Si alcanza el tiempo conviene que
ademas battleship_top.vhd instancie sus componentes a mano, para poder explicar AO1 por los dos
lados cuando pregunten.

### errores frecuentes

El part del proyecto del IP no calza con el del principal. El IP aparece pero sale bloqueado, y
el mensaje de error no dice que el problema es el part.

Se edito el vhd de un IP y no se reflejo. Hay que re-empaquetarlo en su proyecto y despues, en el
principal, Reports > Report IP Status > Upgrade.

El xdc no encuentra los puertos porque Make External les puso sufijo _0.

El bloque no abre ventana de configuracion, o sea el generico no se registro al empaquetar, o sea
AO2 no esta cumplida.

Los bloques de Xilinx como el ATG, el ILA o el VIO pueden estar en el block design, pero no
cuentan para AO2: el enunciado pide packages para incorporar nuestros codigos.


## archivos

En orden. No avanzar al siguiente hasta que el anterior compile.

Lo del mínimo, o sea las dos AO:

    clk_divider.vhd       IP core 1/3   -- done --  cuenta tics. generico DIV
    debounce.vhd          IP core 2/3   limpia el rebote del boton, entrega un pulso de un ciclo
    coord_input.vhd       IP core 3/3   captura 3 bits de los switches al confirmar
    design_1.bd           el block design con los tres bloques conectados
    design_1.vhd          lo genera Create HDL Wrapper, y es lo que cierra AO1
    constraints.xdc       pines: clk en K17, sw, btn, led, RGB, y create_clock de 8 ns
    tb_clk_divider.vhd    instanciar con DIV => 5, si no la simulacion tarda 40 min
    tb_debounce.vhd
    tb_coord_input.vhd
    ILA y VIO             sin esto el tope de los dos slots es 6.0

Lo que agrega una AC cada uno, en orden de conveniencia:

    led_driver.vhd        AC5   estado -> LEDs y RGB, con with select concurrente
    game_fsm.vhd          AC1   fases SETUP, PLAY, END. basta que los estados se recorran
    sep_pkg.vhd           AC6   function idx(x,y) y procedure capture_coord()
    battleship_top.vhd    respaldo de AO1 escrito a mano, por si el design_1.vhd no convence

Las capturas de simulación e ILA/VIO se toman cuando cada etapa funciona, no después. En el
informe final los resultados de simulación valen 3 de los 7 puntos.

Fuera del avance: `board_mem.vhd`, `placement_fsm.vhd`, `combat_fsm.vhd`, `axi_status_slave` y
`axi_config_slave`. Esos apuntan a AO3 y a la entrega final.


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

Si alcanzamos a sumar alguna AC encima del mínimo, y cuál. Ver la sección del mínimo.

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
