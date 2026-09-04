# Hallazgos

Lo que aparecio al desmontar el cartucho. Todo lo de aqui esta **medido**
-ejecutando el formato, o leyendo las constantes con las que el codigo
cuenta-, no deducido del aspecto de los bytes.

## 5730 puntos son la palabra KONAMI

En una zona de bonus, con el protagonista en la casilla **exacta** X=0x90 e
Y=0x39, y solo una vez por partida, el juego escribe `KONAMI 5730 PTS` y suma
esos 5730 puntos.

    0x4910   call es_zona_de_bonus
             ret nz                      solo en las de bonus
             ld a,(0e068h) / and a
             ret nz                      y solo una vez
             ld hl,(0e132h)
             ld a,l / cp 090h / ret nz    la X exacta
             ld a,h / sub 039h / ret nz   y la Y exacta
             ...
             ld de,05730h
             jp suma_al_marcador

Las dos cifras cuadran solas: el rotulo dice 5730 y la instruccion suma 5730.

Y la cifra no es arbitraria. En japones los numeros se pueden leer por su
sonido: **5 = go, 7 = na, 3 = mi**, o sea ***go-na-mi***. Es un huevo de pascua
que la casa repitio en muchos de sus juegos, tambien en los recreativos.

## La demostracion es una partida grabada

Cuando nadie juega, el muneco se mueve solo. No hay ninguna rutina que decida
nada: hay **77 pulsaciones grabadas**.

Estan comprimidas en 0x5D82, se descomprimen a 0xE342 y la rutina de 0x468F las
va leyendo, una cada dos cuadros, y las deja **donde iria lo leido del mando**.
El guion termina con un 0xFF, que es lo que baja la bandera y acaba la
demostracion.

Los valores son las mismas mascaras que da el joystick: 0x01 arriba, 0x02
abajo, 0x04 izquierda, 0x08 derecha, 0x10 el boton. Los primeros son
`02 02 02 02 02 02 08 08 08...` -abajo seis veces, luego derecha-. El resto del
juego no puede distinguir si esta jugando una persona o el guion.

El encaje que lo confirma: el bloque descomprime a **77 bytes exactos** y el
ultimo es justo el 0xFF que la rutina busca.

## El mapa de colisiones es la propia pantalla

Este cartucho no guarda en memoria por donde se puede andar. Para saberlo
**lee la pantalla**: llama a RDVRM y mira que patron hay dibujado en la
casilla. Por debajo de 0x80 es pared -y se apunta como 0x84-, de 0x90 en
adelante se pasa.

Eso explica un detalle que si no pareceria caprichoso: cada vez que se coloca
un objeto, el juego se apunta **que habia debajo**. Si no lo hiciera, al
cogerlo se abriria un agujero por donde se podria caminar.

## Cincuenta zonas sobre veinticinco mapas

    0x498E   ld a,(0e053h)      el numero de zona
             ld hl,06522h       la tabla de los 25 mapas
             cp 019h            por debajo de 25 va directa
             jr c,+
             sub 019h           y de 25 en adelante se repite

De los veinticinco mapas, cuatro son el mismo: las entradas 4, 9, 14, 19 y 24
apuntan las cinco al bloque de 0x6E87. **Una de cada cinco zonas es de bonus.**

La prueba de que el formato RLE esta bien leido no es que los mapas se vean
bien. Es que los veinticinco, que no llevan su tamano escrito en ninguna parte,
descomprimen a **120 bytes clavados** cada uno, y ocupan la ROM de 0x6554 a
0x6EF3 sin dejar un hueco.

## Los colores van debajo de los patrones

En SCREEN 2 lo habitual es patrones en 0x0000 y colores en 0x2000. Aqui es al
reves, y lo dicen los ocho bytes que el cartucho carga en el VDP: **R3=0x7F**
pone los colores en 0x0000 y **R4=0x07** los patrones en 0x2000.

R3 y R4 no son direcciones sino base y mascara. Leerlos al reves no falla de
golpe: da formas correctas y colores a franjas.

## Cinco enemigos, cinco maneras de perseguir

El reparto de 0x569F manda a cada tipo a su rutina, y ninguna hace lo mismo:

- **Tipo 1**: no va donde estas, va **donde vas a estar**. Suma a tu posicion
  un adelanto sacado de una tabla segun la direccion que llevas pulsada.
- **Tipo 2**: no persigue, **imita**. Copia la direccion del jugador con el eje
  horizontal invertido.
- **Tipo 3**: se dirige a tu punto **espejo**, y por eso ronda la pantalla en
  vez de seguirte.
- **Tipo 4**: como el 1, con un adelanto mas corto.
- **Tipo 5**, el grande: va a por los **objetos**.

El motor comun mide las dos distancias, tira por el eje donde estes mas lejos y
**nunca elige la media vuelta**: eso ultimo es lo que evita que se queden
temblando en un pasillo.

## La tabla de sprites se rota entera en cada cuadro

El MSX1 solo ensena cuatro sprites por linea, y ganan siempre los primeros de
la tabla. La rutina de 0x459A vuelca la tabla **empezando cada cuadro dieciseis
bytes mas adelante**, dando la vuelta al final. Como el orden cambia, el que se
pierde no es siempre el mismo: en vez de un personaje invisible, un parpadeo
repartido.

## El decorado que fluye no guarda ni un fotograma

Las animaciones del fondo no tienen dibujos alternativos. Se coge el patron que
ya esta en la memoria de video y se le **rotan los bits** con `rrca` o `rlca`:
un pixel por vuelta, ocho bytes por patron. La otra variante mueve los bytes
enteros una fila con un `lddr` y devuelve el que se sale.

## Una direccion no significa nada sin decir cuando

0xE0B0 es **dos cosas distintas**: mientras se monta la zona guarda el mapa
descomprimido -120 bytes- y durante la partida son los **32 atributos de
sprite** -128 bytes- que se vuelcan de un tiron a 0x3B00. El mismo kilobyte
sirve para las dos cosas porque nunca hacen falta a la vez.

## Un bucle que cuenta catorce sobre una lista de trece

La rutina de 0x41D5 busca el numero de zona en la lista de las que llevan
razzon grande y, si no aparece, escribe `NO BIG RAZZON`. Entra con
`ld b,00eh` -catorce vueltas- pero de 0x609E a 0x60AA solo hay **trece bytes**:

    05 06 07 0A 0B 0C 10 11 12 1F 23 25 2B    los trece, en orden creciente
    08                                        la decimocuarta, ya fuera

La decimocuarta comparacion cae en 0x60AB, que es el primer byte del bloque de
la zona 0 -es justo donde apunta la primera entrada de la tabla de zonas- y
vale 0x08. Ese 0x08 rompe el orden creciente de los otros trece.

El efecto se puede decir sin suponer intenciones: **la zona 8 tambien da
coincidencia**, y por eso no le sale el aviso aunque no este en la lista.

## Codigo que no llama nadie

En 0x4575 hay una rutina de diez bytes que prepara la **lectura** de la memoria
de video -`call 0x0050` y el puerto sacado de 0x0007-, gemela exacta de la de
escritura que si se usa. No hay un solo `call` ni `jp` a esa direccion en toda
la ROM, ni aparece como palabra en ninguna tabla. Se quedo dentro.
