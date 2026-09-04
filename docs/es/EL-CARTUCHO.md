# El cartucho

*Mopi Ranger* es un cartucho de **16 KB** para MSX1, numero de catalogo de
Konami **RC-728**, de 1985. Se mapea en la **pagina 1**, de 0x4000 a 0x7FFF.

## La cabecera

Los diez primeros bytes son la cabecera que lee la BIOS:

    41 42 10 40 00 00 00 00 00 00
    A  B  INIT  STATEMENT DEVICE  TEXT

La `AB` es la firma que dice que ahi hay un cartucho. De las cuatro
direcciones, **solo INIT esta puesta**, en 0x4010; las otras tres van a cero.

## Todo cuelga de la interrupcion

INIT no arranca el juego: lo **engancha** y se queda quieto.

    di / im 1
    ld a,0c3h / ld (0fd9ah),a       un `jp` en H.KEYI
    ld hl,04043h / ld (0fd9bh),hl   y detras, el manejador
    ld sp,0e400h                    la pila
    ld hl,0e000h ... ldir           borra el kilobyte de variables
    ...
    ei
    jr $                            y aqui se queda para siempre

A partir de ese `jr $`, **el juego entero corre desde la interrupcion**. Es un
detalle que importa para desensamblarlo: con solo INIT declarado como punto de
entrada, el trazado se queda en el **1,3 %** del cartucho.

## El mapa de memoria

| donde | que |
|---|---|
| 0x4000-0x400F | la cabecera |
| 0x4010-0x5C75 | el codigo |
| 0x5C76-0x5DB7 | los textos y el guion de la demostracion |
| 0x5E0E-0x5FB7 | patrones, comprimidos |
| 0x6035-0x64B4 | las cincuenta zonas: punteros y datos |
| 0x6522-0x6EF2 | los veinticinco mapas, comprimidos |
| 0x6EF3-0x71F6 | los 193 metatiles |
| 0x722B-0x7AD3 | patrones y colores, comprimidos |
| 0x7C9D-0x7FC8 | los guiones del sonido |
| 0x7FC9-0x7FF3 | relleno |
| 0x7FF4-0x7FFF | la marca oculta de Konami |

En RAM, las variables viven de 0xE000 a 0xE3FF y la pila justo encima.

## La pantalla

El cartucho carga sus ocho registros del VDP de una tabla de 0x45F7, que vale
`02 E2 0E 7F 07 76 03 E0`:

| registro | valor | que dice |
|---|---|---|
| R0 | 0x02 | SCREEN 2 |
| R1 | 0xE2 | pantalla encendida, interrupcion activa, sprites de 16x16 |
| R2 | 0x0E | tabla de nombres en **0x3800** |
| R3 | 0x7F | tabla de colores en **0x0000** |
| R4 | 0x07 | tabla de patrones en **0x2000** |
| R5 | 0x76 | atributos de sprite en **0x3B00** |
| R6 | 0x03 | patrones de sprite en **0x1800** |
| R7 | 0xE0 | borde y fondo |

**Los colores van debajo de los patrones**, al reves de lo habitual. R3 y R4 no
son direcciones sino base y mascara, y leerlos al reves da formas correctas con
colores a franjas.

## La marca oculta de Konami

Los ultimos doce bytes son la marca que **Manuel Pazos** ([@ManuelPazosMSX](https://twitter.com/ManuelPazosMSX))
descubrio en 2021: Konami escondio en muchos de sus cartuchos de MSX el numero
de catalogo y el titulo en katakana. El formato, leyendo hacia adelante:

    [titulo, N bytes, EN ORDEN INVERSO] [N] [las dos cifras del RC en BCD] [0xAA]

Aqui:

    BA B1 B7 8B AC A9 B8 9A A2   09   28   AA

Nueve bytes de titulo, el 0x09 que dice cuantos son, el **0x28** de **RC-728**
y el 0xAA que cierra. El titulo, desandado, es **モピレンジャー** -*Mopi
Renjaa*-, con el handakuten y el dakuten como caracteres sueltos.

Este cartucho **si** la lleva, y eso no se puede dar por hecho: de los cerca
de veinte cartuchos de la casa que hay desensamblados en esta serie, menos de
la mitad la traen. Hay que rastrearla en TODA la ROM y no solo al final, porque
puede quedar delante de un bloque de datos.
