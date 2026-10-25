# El codigo

Del cartucho, **7.789 bytes son codigo** y 8.595 datos. Son 3.802
instrucciones repartidas en 512 rutinas con nombre.

## La forma del programa

Todo cuelga de la interrupcion. Cada cuadro entra por 0x4043, que lleva su
propio candado para no reentrar si un cuadro tarda mas de lo que dura, y de ahi
sale al reparto de escenas.

    interrupcion (0x4043)
      +- reparto de escenas (0x40AC), segun (0xE000)
           +- 9 escenas: titulo, demostracion, juego, empezar zona,
              perder vida, fin de zona, recuento, game over, espera

## El despachador, y por que las tablas no se cargan

El reparto por indice de todo el cartucho es esta rutina:

    despacha_por_indice:
        pop hl          ; la direccion de retorno: la TABLA misma
        call 0x50F2     ; A por dos, HL += A, DE = word[HL]
        ex de,hl
        jp (hl)         ; y salta

El `pop hl` recupera la direccion de retorno, que es **la tabla pegada justo
detras del `call`**. Por eso las tablas de despacho de este juego no se cargan
en ningun registro: se escriben en linea, en el hueco entre el `call` y el
codigo siguiente.

Para el desensamblado eso importa: un `jp (hl)` no se puede seguir
estaticamente. Sin declarar esas dos tablas -la de nueve escenas de 0x40DC y la
de cinco subestados de 0x4735- el trazado se queda en el **5,7 %**.

## Los subestados, sin tabla

Dentro de cada escena no hay tabla: hay una cadena de `djnz`.

    escena_de_juego:
        djnz L_41AC        ; si B != 1, al subestado siguiente
        ...                ; subestado 1
    L_41AC:
        ...                ; subestado 2

Cada `djnz` que no salta consume uno de B, asi que el codigo que queda al final
es el del subestado mas alto. Para cinco o seis casos sale mas corto que una
tabla, y por eso aqui no hay ninguna.

## El compresor de la casa

Un solo formato RLE, con dos rutinas que lo leen:

    [control] donde el bit 7 dice literal o repeticion
              y los otros siete, la cuenta
    [bytes]   la carga: C bytes si es literal, uno solo si se repite
    0x00      cierra

- **0x454F** descomprime a la RAM. Con el se guardan los veinticinco mapas.
- **0x451F** hace lo mismo pero volcando al **puerto del VDP**, y admite dos
  controles de mas: un 0x80 abre otro destino de VRAM y un 0x00 cierra. Con el
  se cargan patrones y colores.

Ninguno lleva el tamano escrito: lo marca el 0x00 final. La forma honesta de
saber donde acaba un bloque es **ejecutar el descompresor**, y eso es lo que
hace `tools/rle.py`.

## Los mapas: metatiles de 2x2

Cada zona son 120 bytes descomprimidos, y **cada byte es un metatile**: un
cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6EF3, de
cuatro bytes por entrada. El bucle de 0x64CD escribe dos celdas, suma 0x20 -una
fila entera de la tabla de nombres- y escribe otras dos.

Doce metatiles de ancho por diez de alto. Esas dos cifras no salen de mirar el
dibujo: son el `cp 00ch` y el `cp 00ah` con los que el bucle cuenta.

## El movimiento, casilla a casilla

Todo lo que se mueve comparte motor. Cuando alguien se cuadra en una casilla
-las dos coordenadas multiplo de ocho-, la rutina de 0x52DC **lee de la
pantalla** los patrones de las casillas de alrededor y se los guarda en su
bloque. Todo lo que viene despues -si puede girar, si hay suelo, si hay
escalera- se contesta mirando esos bytes.

Girar noventa grados exige estar cuadrado; la media vuelta se permite siempre.
Y al girar, la posicion se **arrastra** al multiplo de ocho de uno en uno en el
sentido de la marcha, no se redondea: por eso el giro se siente pegado a la
rejilla.

## El sonido

Tres canales del PSG, y los efectos llevan **prioridad**: uno nuevo no entra si
lo que suena tiene un numero mayor o igual. Cada efecto ocupa dos canales, con
su guion sacado de la tabla de 27 punteros de 0x7CA9.

La rutina que pide un efecto guarda **todos** los registros, IX e IY incluidos,
y corta las interrupciones: la llaman desde cualquier sitio del juego y el
manejador tambien toca el PSG.

## Como se lee este listado

Los nombres de rutina son descriptivos y los comentarios van anclados a
direccion en `src/mopiranger.notes`, no escritos dentro del `.asm`. El listado
esta comentado al **53,0 %** y no queda ninguna rutina por debajo del 10 %.

## Código compartido con otros cartuchos de Konami

Este desensamblado se ha comparado, instrucción por instrucción, con
todos los demás de Konami de la serie. Cuenta un bloque cuando las
mismas instrucciones, al menos seis desde una etiqueta hasta su `ret`
o su salto sin condición, están en los dos cartuchos; las direcciones
no se miran, porque cambian de un cartucho a otro. De los otros 57,
**52** tienen al menos un bloque en común con este; estos son los
que más comparten:

| Cartucho | Bloques | Instrucciones | Por ejemplo (aquí = allí) |
|---|---:|---:|---|
| [The Goonies](https://antxiko.github.io/Goonies-disassembly/es/) | 18 | 178 | `avanza_la_cortinilla` (0x46F5) = `baja_un_paso` |
| [Yie Ar Kung-Fu](https://antxiko.github.io/YieArKungFu-disassembly/es/) | 18 | 247 | `suma_al_marcador` (0x43B2) = `suma_a_la_puntuacion` |
| [Knightmare](https://antxiko.github.io/Knightmare-disassembly/es/) | 16 | 173 | `manejador_de_interrupcion` (0x4043) = `cada_cuadro` |
| [Sky Jaguar](https://antxiko.github.io/SkyJaguar-disassembly/es/) | 16 | 211 | `suma_al_marcador` (0x43B2) = `SUMA_PUNTOS` |
| [Yie Ar Kung-Fu II](https://antxiko.github.io/YieArKungFu2-disassembly/es/) | 16 | 145 | `avanza_la_cortinilla` (0x46F5) = `baja_un_paso` |
| [Hyper Sports 3](https://antxiko.github.io/HyperSports3-disassembly/es/) | 14 | 154 | `manejador_de_interrupcion` (0x4043) |
| [Konami's Boxing](https://antxiko.github.io/Boxing-disassembly/es/) | 13 | 118 | `avanza_el_guion` (0x7B35) = `repite_un_trozo` |
| [Hyper Rally](https://antxiko.github.io/HyperRally-disassembly/es/) | 12 | 121 | `manejador_de_interrupcion` (0x4043) = `INT` |
| [King's Valley](https://antxiko.github.io/KingsValley-disassembly/es/) | 12 | 141 | `suma_al_marcador` (0x43B2) |
| [Konami's Ping Pong](https://antxiko.github.io/KonamisPingPong-disassembly/es/) | 12 | 111 | `avanza_la_cortinilla` (0x46F5) = `sube_el_rotulo` |

La matriz entera, los 58 cartuchos entre sí, está en
[Las rutinas](https://antxiko.github.io/MSX-disassembly-database/es/LAS-RUTINAS.html) de la base de datos de la
serie, con el método y el programa que la mide.
