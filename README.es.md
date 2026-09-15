# Mopi Ranger (Konami, 1985) — desensamblado comentado

Desensamblado completo y comentado del cartucho de MSX1 **Mopi Ranger**
(Konami, numero de catalogo **RC-728**, 16 KB), reproducible byte a byte.

**Web: <https://antxiko.github.io/MopiRanger-disassembly/es/>** · [In English](README.md)

|  |  |
|---|---|
| Del binario explicado | **100 %** — 0 bytes sin identificar, de 16.384 |
| Reensambla | **byte a byte**, al mismo sha256 |
| Listado comentado | **53,0 %** — 2.016 comentarios sobre 3.802 instrucciones |
| Rutinas por debajo del liston del 10 % | **0** de 512 |

## Que hay aqui

    src/mopiranger.asm       el listado, generado
    src/mopiranger.notes     lo entendido: bloques de datos y comentarios
    src/mopiranger.entries   los puntos de entrada, cada uno con su razon
    src/mopiranger.nocode    las zonas que no son codigo
    tools/                   el trazador, el generador y los dibujantes
    docs/                    la web, en ingles y castellano

## Como se reproduce

El cartucho **no** se distribuye aqui. Hay que ponerlo en la raiz como
`mopiranger.rom` (16.384 bytes, sha256 `89ae5bdd1541c38c2593a91d36bdacf36634c0c8b85977ff2fff046bae4dadbf`)
y ejecutar:

    make comprueba      # que el volcado es el que toca
    make                # traza, genera, reensambla, verifica y pasa los tests

Termina con `OK: reproducible byte a byte`, que significa que el listado
devuelve el cartucho exacto.

## Algo de lo que aparecio

- **5730 puntos son KONAMI.** Un premio escondido en una casilla exacta de las
  zonas de bonus. En japones 5-7-3 se lee *go-na-mi*.
- **La demostracion no es inteligencia**: son 77 pulsaciones grabadas que se
  meten por donde entraria el mando.
- **El mapa de colisiones es la propia pantalla** — el juego lee la memoria de
  video para saber por donde se puede andar.
- **Cincuenta zonas sobre veinticinco mapas**, y la prueba de que la compresion
  esta bien entendida es que los veinticinco dan 120 bytes clavados.
- **Los colores van debajo de los patrones** en la memoria de video, al reves
  de lo habitual.

La lista entera esta en [Hallazgos](https://antxiko.github.io/MopiRanger-disassembly/es/HALLAZGOS.html),
y lo que **no** se sabe, en
[Preguntas abiertas](https://antxiko.github.io/MopiRanger-disassembly/es/PREGUNTAS-ABIERTAS.html).

## A quien hay que dar las gracias

La marca oculta de Konami del final de la ROM -el numero de catalogo y el
titulo en katakana- la descubrio **Manuel Pazos**
([@ManuelPazosMSX](https://twitter.com/ManuelPazosMSX)) en 2021.

## Legal

Esto es trabajo de preservacion, estudio y documentacion. El juego y sus
graficos siguen siendo de sus titulares; la imagen del cartucho no se
distribuye. Ver [AVISO-LEGAL.md](AVISO-LEGAL.md) y [LICENSE](LICENSE).
