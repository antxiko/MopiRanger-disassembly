# Preguntas abiertas

Lo que **no** se sabe. Esta pagina existe porque un desensamblado que solo
cuenta lo que ha salido bien no se puede distinguir de uno que disimula.

## Que dice la pantalla de bonus

El mapa de la zona de bonus, dibujado desde la ROM, forma letras con los
metatiles del decorado: se lee **MOP** arriba e **ILLA** abajo.

![La zona de bonus](../imagenes/zona_04.png)

La geometria esta confirmada por el codigo -doce metatiles por diez, el
`cp 00ch` y el `cp 00ah` de 0x64CD-, asi que el dibujo es fiel: eso es lo que
el cartucho pinta. Lo que no se sabe es **que se supone que pone**. No es el
titulo, que en la pantalla de presentacion se escribe MOPIRANGER.

Falta jugar la fase de bonus en el emulador y ver como queda con los objetos y
los sprites encima.

## Que hace exactamente el enemigo grande con su camino fijo

El tipo 5 alterna dos comportamientos con la bandera de 0xE2D8: o va a por el
primer objeto de la lista, o sigue un camino sacado de la tabla de 0x5812,
indexado por el medio byte alto de su propio reloj. Lo que hace esta claro; lo
que **no** esta medido es si ese camino fijo dibuja una figura reconocible en
la pantalla o si es solo un recorrido de servicio.

## De donde salen los 18 bytes de 0x6099

Los cinco primeros (`01 04 03 02 05`) los carga 0x4B27 en DE, y los trece
siguientes son la lista de zonas con razzon grande. Lo que hace 0x4B27 con esos
cinco esta trazado, pero **no se ha comprobado en marcha** que signifiquen lo
que parecen.

## El descuadre del bucle de catorce

Que el bucle de 0x41D5 lea catorce bytes de una lista de trece esta medido, y
el efecto tambien: la zona 8 se libra del aviso `NO BIG RAZZON`. Lo que no se
puede afirmar es **si es un descuido o es deliberado**. El binario dice lo que
el codigo hace, no lo que quien lo escribio pretendia.

## La rutina que no llama nadie

En 0x4575 hay diez bytes que preparan la lectura de la memoria de video y a los
que no salta nadie. Se ha buscado como destino de `call` y `jp` en toda la ROM
y como palabra en las tablas, y no aparece. Queda la posibilidad de que se
alcance por un camino que el trazado no ve; **no se ha encontrado ninguno**.

## Las cifras que faltan

- No se ha medido cuantos **ciclos** cuesta pintar una zona entera. Con dos
  breakpoints y `machine_info time` se puede contestar con un numero.
- No se ha comprobado si hay **mas de una compilacion** de este cartucho
  circulando, como pasa con otros de la casa.

## Si sabes algo de esto

Los issues del repositorio estan abiertos. Una correccion con una medida al
lado vale mas que diez paginas de texto: en esta serie, varias afirmaciones ya
publicadas han caido porque alguien se puso delante del juego y miro.
