# La música

Todo lo que suena aquí sale de ejecutar el motor de sonido del cartucho (`atiende_el_sonido`, 0x7B67, y `suena`, 0x7AD4, que le reparte los canales; lo llama la interrupción en 0x4047) en un Z80 emulado, cuadro a cuadro y a 60 por segundo, igual que lo llama el juego. Lo que el motor escribe en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). Cada MP3 es la pieza entera hasta donde vuelve a empezar, más 8 segundos de la vuelta apagándose; las que no se repiten acaban donde acaba el motor.

## Cotejado con openMSX

Las escrituras al PSG se han comparado cuadro a cuadro con las de openMSX (C-BIOS MSX1 japonés). En todos los cuadros el PSG queda igual:

- el aviso de zona (0x8F) entero, 282 cuadros, tal como el juego lo pide;
- la entrada (0x8A) entera, 57 cuadros;
- «game over» (0x92), sus primeros 222 cuadros.

El timbre no está cotejado: es el de un AY-3-8910 de manual, no una grabación del emulador. Las sondas están en `tools/omsx_psg.tcl` y `tools/coteja_psg.py`.

## Cómo se pide una pieza

`suena` recibe el número en A. Los números bajos son efectos y del 0x8A en adelante hay música. Cada canal ocupa catorce bytes desde 0xE018 y 0xE042 guarda la copia del mezclador del PSG, que el arranque deja en 0xB8. Las pistas «de la tabla» están en la tabla de pistas pero ninguna rutina las pide con un `ld a`.

## Las músicas

**El aviso de zona** (0x8F)

Lo pide `suena_el_aviso_de_zona`; dura 4,7 s.

<audio controls preload="none" src="../audio/musica_8F.mp3?v=5b85bcca"></audio>

**La entrada** (0x8A)

Lo pide `tramo_de_entrada`; dura 0,9 s y vuelve a empezar en el segundo 0,0.

<audio controls preload="none" src="../audio/musica_8A.mp3?v=65d1be6d"></audio>

**Game over** (0x92)

Lo pide `pinta_el_game_over`; dura 4,1 s.

<audio controls preload="none" src="../audio/musica_92.mp3?v=98cdcd31"></audio>

**La pieza del 0x50FA** (0x99)

Lo pide `L_50FA`; dura 0,0 s.

<audio controls preload="none" src="../audio/musica_99.mp3?v=719153cf"></audio>

**Pista 0x8B de la tabla** (0x8B)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 4,7 s y vuelve a empezar en el segundo 3,8.

<audio controls preload="none" src="../audio/musica_8B.mp3?v=8a443c3b"></audio>

**Pista 0x8D de la tabla** (0x8D)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 4,7 s.

<audio controls preload="none" src="../audio/musica_8D.mp3?v=1ca36ae6"></audio>

**Pista 0x8E de la tabla** (0x8E)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 4,7 s.

<audio controls preload="none" src="../audio/musica_8E.mp3?v=45d3f1fc"></audio>

**Pista 0x90 de la tabla** (0x90)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 4,7 s.

<audio controls preload="none" src="../audio/musica_90.mp3?v=cbdeed21"></audio>

**Pista 0x91 de la tabla** (0x91)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 4,7 s.

<audio controls preload="none" src="../audio/musica_91.mp3?v=2e8c3275"></audio>

**Pista 0x93 de la tabla** (0x93)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 50,3 s.

<audio controls preload="none" src="../audio/musica_93.mp3?v=cd77c0d8"></audio>

**Pista 0x94 de la tabla** (0x94)

Lo pide ninguna llamada directa: está en la tabla de pistas; dura 50,3 s.

<audio controls preload="none" src="../audio/musica_94.mp3?v=0c7f4aae"></audio>
