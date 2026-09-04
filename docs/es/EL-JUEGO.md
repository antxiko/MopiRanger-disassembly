# El juego

*Mopi Ranger* es un juego de laberintos de 1985. Se recorren zonas cerradas
recogiendo lo que hay en ellas, esquivando a los enemigos y con un martillo
que se lanza en linea recta.

![La pantalla de titulo](../imagenes/titulo.png)

*El rotulo, dibujado desde la ROM. No es un dibujo suelto: son tres filas de
veinte celdas con patrones consecutivos desde el 0xC0.*

## Cincuenta zonas, veinticinco mapas

El marcador cuenta hasta cincuenta zonas. Dibujos distintos hay
**veinticinco**: al llegar a la 25 el juego resta 25 al indice y vuelve a
empezar por el primer mapa, con los enemigos y los objetos cambiados.

Y de esos veinticinco, **una de cada cinco es de bonus** y las cinco comparten
la misma pantalla.

![La primera zona](../imagenes/zona_00.png)

*La primera zona. Cada uno de los 120 bytes del mapa es un cuadro de 2x2
celdas; doce de ancho por diez de alto.*

## Como se juega

- Se mueve con las cuatro direcciones, **de casilla en casilla**. Para girar
  noventa grados hay que estar en el centro de una casilla; la media vuelta se
  puede dar en cualquier momento.
- El boton lanza el **martillo**, que vuela recto hasta que se topa con algo.
  Si alcanza a un enemigo, lo mata: cien puntos.
- Hay bloques que se **empujan**, si hay hueco al otro lado y no hay nadie.
- Cada zona tiene un **reloj**. Cuando queda poco, el aviso del marcador
  parpadea y el decorado empieza a moverse al doble de velocidad.

## Los enemigos

Son cinco tipos, y ninguno se comporta igual:

| tipo | que hace |
|---|---|
| 1 | te corta el paso: va a donde vas a estar, no a donde estas |
| 2 | te **imita**: copia la direccion que pulsas, con el eje horizontal al reves |
| 3 | va a tu punto **espejo**, asi que ronda la pantalla en vez de seguirte |
| 4 | como el 1, con un adelanto mas corto |
| 5 | el **grande**: va a por los objetos y se los come |

El grande merece parrafo aparte. **No te quita una vida: te quita la zona.**
Cuando se pone encima de un objeto lo borra del tablero y devuelve a la
pantalla lo que habia debajo, igual que si lo hubieras cogido tu. Ademas es el
unico que puede pisar las casillas de meta.

Y hay un detalle bonito: cuando cae un enemigo, los demas **se enteran**. Una
tabla dice, para cada uno, quienes son sus tres vecinos, y a esos se les da la
vuelta.

## Las zonas de bonus

![La zona de bonus](../imagenes/zona_04.png)

*La zona de bonus, la misma para las cinco que la usan.*

Al terminarla entera se da el **PERFECT BONUS**. Y en ella esta escondido el
premio de la casa: puesto en la casilla exacta X=0x90, Y=0x39, el juego escribe
**KONAMI 5730 PTS** y suma esos 5730 puntos.

La cifra no es casual. En japones los numeros se pueden leer por su sonido:
**5 = go, 7 = na, 3 = mi**, o sea ***go-na-mi***. Konami metio ese premio en
muchos de sus juegos.

## El marcador

Seis cifras en BCD, con tope en 999999. El record se guarda mientras la maquina
siga encendida. Cada objeto vale segun lo que marque el reloj de la
coreografia, y el premio de fin de fase son veinte mil puntos, sumados en tres
veces porque el sumador trabaja en decimal y no le caben de una.

## Lo que se ve y no se toca

La demostracion que corre cuando nadie juega **no es una inteligencia**: son 77
pulsaciones grabadas que se meten por donde entraria el mando. Esta contado en
[Hallazgos](HALLAZGOS.html).
