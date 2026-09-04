# En el emulador

Como ver en marcha lo que cuenta este desensamblado. Todo lo de aqui es con
**openMSX**, que trae una consola de depuracion con la que se puede parar el
juego en una direccion y mirar la memoria.

## Arrancarlo

    openmsx -machine "Philips_VG_8020" -cart mopiranger.rom

## Ver el premio de los 5730 puntos

Es lo mas facil de comprobar y lo mas satisfactorio. Hay que llegar a una zona
de bonus -la 5, la 10, la 15...- y ponerse en la casilla exacta. Con la consola
se puede ir directo:

    debug set_breakpoint 0x4931 {} {puts "5730 puntos!"}

Ese breakpoint salta justo en el `ld de,05730h`. Si se dispara, el rotulo
`KONAMI 5730 PTS` esta a punto de aparecer.

Y para no buscar la casilla a mano, se puede mirar donde esta el protagonista
mientras se juega:

    debug read_block memory 0xE130 2

El primer byte es la X y el segundo la Y. Hay que llevarlos a 0x90 y 0x39.

## Ver que la demostracion es un guion

Deja el juego quieto en la pantalla de titulo hasta que arranque la
demostracion, y entonces:

    debug read_block memory 0xE342 77

Esos 77 bytes son las pulsaciones grabadas. Se puede seguir el puntero:

    debug set_watchpoint read_mem 0xE342 {} {puts "leyendo el guion"}

Y la prueba fina: cambiar un byte del guion en caliente y ver que la
demostracion hace otra cosa.

    debug write_block memory 0xE342 0x08

## Ver los registros del VDP al reves

Para comprobar de primera mano que los colores estan debajo de los patrones:

    debug read_block "VDP regs" 0 8

Salen los ocho bytes `02 E2 0E 7F 07 76 03 E0`. El cuarto (R3=0x7F) es la
tabla de colores y el quinto (R4=0x07) la de patrones.

## Ver la tabla de sprites rotando

    debug set_watchpoint write_mem 0xE057 {} {puts [format "%02X" [debug read memory 0xE057]]}

0xE057 es el desplazamiento con el que empieza el volcado de sprites cada
cuadro. Va subiendo de dieciseis en dieciseis y dando la vuelta a los 0x80.

## Volcar la memoria de video para comprobar un dibujo

Es lo que separa "la imagen parece correcta" de "la imagen ES correcta". Se
vuelca la VRAM y se compara byte a byte con lo que dibujan las herramientas de
`tools/`:

    debug save_memory VRAM vram.bin

Y del lado de Python, `tools/mapas.py` monta la misma VRAM ejecutando lo que
hace el cartucho. Si las dos coinciden, el formato esta bien entendido.

## Un aviso sobre los watchpoints

Poner un watchpoint sobre un rango grande con un callback caro **congela** el
emulador. La forma que funciona es empezar por una sonda estrecha, medir el
ritmo de escrituras y solo entonces decidir si el rango entero es asumible.
