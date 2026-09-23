# Conecta los nombres de los puertos del top con los pines fisicos de la Zybo
# Z7-10, y le dice a Vivado a que velocidad corre el reloj. Sin este archivo el
# diseno sintetiza igual, pero no hay forma de cargarlo a la tarjeta.
# Los pines salen del Zybo-Z7-Master.xdc de Digilent. Lo que va entre get_ports
# tiene que ser exactamente el nombre del puerto en battleship_top, si no Vivado
# tira error.

# aca va el pin del reloj, que en la Zybo Z7-10 es el K17

# aca va el create_clock declarando que el periodo es de 8 ns, o sea 125 MHz

# aca van los pines de los switches, que son G15, P15, W13 y T16

# aca van los pines de los botones, que son K18, P16, K19 e Y16

# aca van los pines de los 4 LEDs de usuario, que son M14, M15, G14 y D18

# aca van los pines del LED RGB, que son V16, F17 y M17. hay que verificar en la
# tarjeta cual es cual, porque el grupo del proyecto de ejemplo los mapeo al
# reves de lo que dicen los comentarios de Digilent
