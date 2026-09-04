# Empezar

Este repositorio no trae el juego. Trae el **desensamblado comentado** de
*Mopi Ranger* (Konami, 1985, RC-728) y las herramientas que lo reproducen.

## Lo que hace falta

- El cartucho, 16.384 bytes exactos, en la raiz y con el nombre
  `mopiranger.rom`. Su sha256 es
  `89ae5bdd1541c38c2593a91d36bdacf36634c0c8b85977ff2fff046bae4dadbf`.
- `pasmo` y `z80dasm` en el PATH.
- Python 3.
- `make`.

## La comprobacion que decide

    make comprueba      # que el volcado es el mismo
    make               # traza, genera el listado, reensambla y comprueba

`make` termina con esto, y es lo unico que hay que mirar:

    OK: reproducible byte a byte

Significa que el listado de `src/mopiranger.asm`, ensamblado, devuelve **los
mismos 16.384 bytes** del cartucho. Si eso falla, todo lo demas sobra.

## Lo que cada orden hace

| orden | que hace |
|---|---|
| `make trace` | sigue el flujo desde los puntos de entrada de `src/mopiranger.entries` |
| `make listado` | escribe `src/mopiranger.asm` juntando el trazado y las notas |
| `make verify` | ensambla y compara el sha256 con el original |
| `make sanity` | lo que el reensamblado NO cubre (ver abajo) |
| `make test` | los tests |
| `make densidad` | cuanto del listado esta comentado |
| `make mapas` | dibuja las zonas descomprimiendolas |
| `make web` | genera estas paginas |

## Por que `verify` no basta

Un listado puede reproducir la ROM byte a byte y estar diciendo mentiras: los
bytes no cambian por leerlos mal. Lo que caza eso es `make sanity`:

- **que ningun dato salga como codigo**: si el trazador entra en una tabla, la
  desensambla como instrucciones y la cobertura sube sin que nada falle.
- **que ningun punto de entrada caiga dentro de una zona de datos**, que es la
  forma de que el listado se contradiga a si mismo.
- **que no quede un byte sin explicar**. Aqui son 16.384 de 16.384, el 100 %.

## Los ficheros

    src/mopiranger.entries   los puntos de entrada, cada uno con su razon
    src/mopiranger.nocode    las zonas que NO son codigo
    src/mopiranger.notes     lo entendido: los bloques de datos y los comentarios
    src/mopiranger.asm       el listado, generado
    tools/                   el trazador, el generador y los dibujantes

El `.asm` **se genera**: lo que se edita es el `.notes`, porque los comentarios
van anclados a direccion y asi sobreviven a un retrazado.
