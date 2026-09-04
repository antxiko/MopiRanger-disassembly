#!/usr/bin/env python3
"""El CONTENIDO de la portada: los hallazgos y los pies de la galeria.

Va aparte de make_web.py a proposito. make_web.py es el generador -la
plantilla, la maquetacion, el HTML- y no cambia de un juego al siguiente; esto
es lo unico que hay que reescribir entero en cada cartucho. Teniendolo separado
no hay que ir buscando los textos del juego anterior dentro del generador, que
es justo como se han colado los nombres equivocados otras veces.

Cada hallazgo es (titulo, html) y cada entrada de galeria
(fichero, pie en castellano, pie en ingles).
"""

HALLAZGOS = {
    "es": [
        ('5730 puntos son, en japones, la palabra KONAMI',
         '<p>En una zona de bonus, si el protagonista se pone en la casilla '
         '<b>exacta</b> X=0x90 e Y=0x39, el juego escribe <code>KONAMI 5730 '
         'PTS</code> y suma esos 5730 puntos. Las dos cifras cuadran solas: el '
         'rotulo lo dice y el <code>ld de,05730h</code> de 0x4931 lo suma.</p>'
         '<p>La cifra no es arbitraria. En japones los numeros se leen tambien '
         'por su sonido: <b>5 = go, 7 = na, 3 = mi</b>, o sea '
         '<b><i>go-na-mi</i></b>. Es un huevo de pascua que la casa repitio en '
         'muchos de sus juegos, tambien en los recreativos.</p>'),
        ('La demostracion no es inteligencia: es una partida grabada',
         '<p>Cuando nadie juega, el muneco se mueve solo. No hay ninguna '
         'rutina que decida: hay <b>77 pulsaciones grabadas</b>, comprimidas '
         'en 0x5D82, que se descomprimen a 0xE342 y que la rutina de 0x468F va '
         'metiendo <b>por donde entraria el mando</b>, una cada dos cuadros, '
         'hasta encontrar un 0xFF.</p>'
         '<p>Los valores son las mismas mascaras que da el joystick -0x01 '
         'arriba, 0x02 abajo, 0x04 izquierda, 0x08 derecha, 0x10 el boton-, '
         'asi que el resto del juego no distingue si esta jugando una persona '
         'o el guion.</p>'),
        ('El mapa de colisiones es la propia pantalla',
         '<p>Este cartucho no guarda en memoria por donde se puede andar. Para '
         'saberlo <b>lee la pantalla</b>: llama a RDVRM y mira que patron hay '
         'dibujado en la casilla. Todo patron por debajo de 0x80 se trata como '
         'pared, y de 0x90 en adelante se puede pasar.</p>'
         '<p>Eso explica un detalle que si no pareceria caprichoso: cada vez '
         'que se pone un objeto en la pantalla, el juego se apunta <b>que '
         'habia debajo</b>. Si no lo hiciera, al cogerlo se abriria un agujero '
         'por donde se podria caminar.</p>'),
        ('Cincuenta zonas sobre veinticinco mapas',
         '<p>El juego anuncia cincuenta zonas, y mapas distintos solo hay '
         '<b>veinticinco</b>: en 0x498E, cuando el numero de zona llega a 25, '
         'se le restan 25 y se vuelve a empezar por el primer mapa.</p>'
         '<p>Y de esos veinticinco, cuatro son el mismo: las entradas 4, 9, '
         '14, 19 y 24 apuntan las cinco al bloque de 0x6E87. <b>Una de cada '
         'cinco zonas es de bonus</b>, y todas comparten pantalla.</p>'
         '<p>La prueba de que los mapas estan bien leidos no es que se vean '
         'bien: es que los veinticinco, comprimidos con el RLE de la casa y '
         'sin llevar el tamano escrito en ninguna parte, descomprimen a '
         '<b>120 bytes clavados</b> cada uno.</p>'),
        ('Los colores van debajo de los patrones, al reves de lo normal',
         '<p>En SCREEN 2 lo habitual es poner los patrones en 0x0000 y los '
         'colores en 0x2000. Aqui es al reves, y lo dicen los ocho bytes que '
         'el cartucho carga en los registros del VDP (la tabla de 0x45F7, que '
         'vale <code>02 E2 0E 7F 07 76 03 E0</code>): <b>R3=0x7F</b> pone los '
         'colores en 0x0000 y <b>R4=0x07</b> los patrones en 0x2000.</p>'
         '<p>Leerlo al reves no da un error visible de golpe: da formas '
         'correctas y colores a franjas. Es la trampa clasica de este modo.</p>'),
        ('Los enemigos son cinco, y ninguno persigue igual',
         '<p>El reparto de 0x569F manda a cada tipo a su propia rutina:</p>'
         '<ul><li><b>Tipo 1</b>: no va donde estas, va donde <i>vas a estar</i>. '
         'Suma a tu posicion un adelanto en la direccion que llevas pulsada.</li>'
         '<li><b>Tipo 2</b>: no persigue, <b>imita</b>. Copia la direccion que '
         'pulsa el jugador, con el eje horizontal invertido.</li>'
         '<li><b>Tipo 3</b>: se dirige al punto <b>espejo</b> del protagonista, '
         'lo que le hace rondar la pantalla en vez de seguirte.</li>'
         '<li><b>Tipo 4</b>: como el 1, pero con un adelanto mas corto.</li>'
         '<li><b>Tipo 5</b>, el grande: va a por los <b>objetos</b>. Cuando se '
         'pone encima de uno lo borra del tablero. No te quita una vida: te '
         'quita la zona.</li></ul>'),
        ('La tabla de sprites se rota entera en cada cuadro',
         '<p>El MSX1 solo puede ensenar <b>cuatro sprites por linea</b>, y los '
         'que ganan son siempre los primeros de la tabla: los ultimos '
         'desaparecen sin mas.</p>'
         '<p>La rutina de 0x459A lo resuelve volcando la tabla <b>empezando '
         'cada cuadro dieciseis bytes mas adelante</b> y dando la vuelta al '
         'llegar al final. Como el orden va cambiando, el que se pierde no es '
         'siempre el mismo, y lo que se ve es un parpadeo repartido en vez de '
         'un personaje invisible.</p>'),
        ('El decorado que fluye no guarda ni un fotograma',
         '<p>Las animaciones del fondo no tienen dibujos alternativos en la '
         'ROM. Se coge el patron que ya esta en la memoria de video y se le '
         '<b>rotan los bits</b> con <code>rrca</code> o <code>rlca</code>: un '
         'pixel de desplazamiento por vuelta, ocho bytes por patron.</p>'
         '<p>La otra variante mueve los bytes enteros una fila con un '
         '<code>lddr</code>, y devuelve por arriba el que se sale por abajo.</p>'),
        ('Una direccion de este cartucho no significa nada sin decir cuando',
         '<p>0xE0B0 es <b>dos cosas distintas</b> segun el momento: mientras '
         'se monta la zona guarda el mapa descomprimido, 120 bytes; durante la '
         'partida son los <b>32 atributos de sprite</b>, 128 bytes que se '
         'vuelcan de un tiron a 0x3B00 -que es donde R5 pone su tabla-.</p>'
         '<p>El mismo kilobyte sirve para las dos cosas porque nunca hacen '
         'falta a la vez.</p>'),
        ('Un bucle que cuenta catorce sobre una lista de trece',
         '<p>La rutina de 0x41D5 busca el numero de zona en la lista de las '
         'que llevan razzon grande y, si no lo encuentra, escribe el aviso '
         '<code>NO BIG RAZZON</code>. Entra con <code>ld b,00eh</code>, o sea '
         '<b>catorce vueltas</b>, pero de 0x609E a 0x60AA solo hay <b>trece '
         'bytes</b>.</p>'
         '<p>La decimocuarta comparacion cae ya en el bloque siguiente, el de '
         'la zona 0, y vale 0x08. Los trece de la lista van en orden creciente '
         'y ese 0x08 lo rompe. El efecto se puede decir sin suponer '
         'intenciones: <b>la zona 8 tambien da coincidencia</b>, y por eso no '
         'le sale el aviso aunque no este en la lista.</p>'),
        ('Codigo que no llama nadie',
         '<p>En 0x4575 hay una rutina de diez bytes que prepara la LECTURA de '
         'la memoria de video: la gemela exacta de la de escritura que si se '
         'usa. <b>No hay un solo <code>call</code> ni <code>jp</code> a esa '
         'direccion en toda la ROM</b>, ni aparece como palabra en ninguna '
         'tabla. Se quedo dentro.</p>'),
    ],
    "en": [
        ('5730 points spell KONAMI in Japanese',
         '<p>On a bonus stage, if you stand on the <b>exact</b> square X=0x90, '
         'Y=0x39, the game prints <code>KONAMI 5730 PTS</code> and awards '
         'those 5730 points. The two figures agree on their own: the caption '
         'says so and the <code>ld de,05730h</code> at 0x4931 adds it.</p>'
         '<p>The number is not arbitrary. Japanese numbers can be read by '
         'their sound too: <b>5 = go, 7 = na, 3 = mi</b>, that is '
         '<b><i>go-na-mi</i></b>. It is an easter egg the company reused '
         'across many of its games, arcade ones included.</p>'),
        ('The attract mode is not AI: it is a recorded game',
         '<p>When nobody is playing, the character moves by itself. No routine '
         'decides anything: there are <b>77 recorded keypresses</b>, '
         'compressed at 0x5D82, unpacked to 0xE342, which the routine at '
         '0x468F feeds in <b>where the joystick input would go</b>, one every '
         'two frames, until it hits an 0xFF.</p>'
         '<p>The values are the joystick masks themselves, so the rest of the '
         'game cannot tell whether a person or the script is playing.</p>'),
        ('The collision map is the screen itself',
         '<p>This cartridge keeps no walkability map in memory. To find out, '
         'it <b>reads the screen</b>: it calls RDVRM and looks at which '
         'pattern is drawn on the square. Anything below 0x80 counts as wall, '
         'from 0x90 on you can walk.</p>'
         '<p>That explains a detail that would otherwise look odd: whenever an '
         'object is placed, the game notes down <b>what was underneath</b>. '
         'Otherwise picking it up would punch a walkable hole in the wall.</p>'),
        ('Fifty zones over twenty-five maps',
         '<p>The game announces fifty zones, and there are only '
         '<b>twenty-five</b> distinct maps: at 0x498E, once the zone number '
         'reaches 25, it subtracts 25 and starts over from the first map.</p>'
         '<p>And of those twenty-five, four are the same one: entries 4, 9, '
         '14, 19 and 24 all point at the block at 0x6E87. <b>One zone in five '
         'is a bonus stage</b>, and they all share a screen.</p>'
         '<p>The proof that the maps are read correctly is not that they look '
         'right: it is that all twenty-five, compressed with the house RLE and '
         'carrying their length nowhere, unpack to <b>exactly 120 bytes</b>.</p>'),
        ('Colours sit below patterns, the other way round',
         '<p>In SCREEN 2 you normally put patterns at 0x0000 and colours at '
         '0x2000. Here it is reversed, and the eight bytes the cartridge loads '
         'into the VDP registers say so (the table at 0x45F7, '
         '<code>02 E2 0E 7F 07 76 03 E0</code>): <b>R3=0x7F</b> puts colours '
         'at 0x0000 and <b>R4=0x07</b> patterns at 0x2000.</p>'
         '<p>Reading it the wrong way round does not fail loudly: it gives '
         'correct shapes and striped colours. It is the classic trap of this '
         'mode.</p>'),
        ('Five enemies, five different ways of chasing',
         '<p>The dispatch at 0x569F sends each type to its own routine:</p>'
         '<ul><li><b>Type 1</b>: does not go where you are, it goes where you '
         '<i>will be</i>, adding a lead in the direction you are holding.</li>'
         '<li><b>Type 2</b>: does not chase, it <b>mirrors</b> you, copying '
         'the direction the player presses with the horizontal axis flipped.</li>'
         '<li><b>Type 3</b>: heads for the protagonist&#39;s <b>mirror point</b>, '
         'which makes it prowl the screen instead of following you.</li>'
         '<li><b>Type 4</b>: like type 1, with a shorter lead.</li>'
         '<li><b>Type 5</b>, the big one: it goes for the <b>objects</b>. When '
         'it stands on one it wipes it off the board. It does not cost you a '
         'life: it costs you the zone.</li></ul>'),
        ('The sprite table is rotated every single frame',
         '<p>The MSX1 can only show <b>four sprites per line</b>, and the ones '
         'that win are always the first in the table: the rest simply '
         'vanish.</p>'
         '<p>The routine at 0x459A fixes that by dumping the table <b>starting '
         'sixteen bytes further along each frame</b>, wrapping at the end. '
         'Since the order keeps shifting, the sprite that loses is never the '
         'same one, and what you see is shared flicker instead of an invisible '
         'character.</p>'),
        ('The flowing scenery stores not one frame',
         '<p>The background animations have no alternative artwork in the ROM. '
         'The pattern already sitting in video memory is taken and its bits '
         'are <b>rotated</b> with <code>rrca</code> or <code>rlca</code>: one '
         'pixel of travel per turn, eight bytes per pattern.</p>'
         '<p>The other variant shifts whole bytes one row with an '
         '<code>lddr</code>, wrapping the one that falls off.</p>'),
        ('An address here means nothing without a moment attached',
         '<p>0xE0B0 is <b>two different things</b> depending on when you look: '
         'while the zone is being built it holds the unpacked map, 120 bytes; '
         'during play it is the <b>32 sprite attributes</b>, 128 bytes dumped '
         'in one go to 0x3B00 -where R5 puts its table-.</p>'
         '<p>The same kilobyte does both jobs because they are never needed at '
         'the same time.</p>'),
        ('A loop that counts fourteen over a list of thirteen',
         '<p>The routine at 0x41D5 looks up the zone number in the list of '
         'those carrying a big razzon and, failing to find it, prints the '
         '<code>NO BIG RAZZON</code> notice. It enters with '
         '<code>ld b,00eh</code>, that is <b>fourteen turns</b>, but from '
         '0x609E to 0x60AA there are only <b>thirteen bytes</b>.</p>'
         '<p>The fourteenth comparison already falls into the next block, zone '
         '0&#39;s, and reads 0x08. The thirteen on the list run in ascending '
         'order and that 0x08 breaks it. The effect can be stated without '
         'guessing at intent: <b>zone 8 matches too</b>, and so it never gets '
         'the notice even though it is not on the list.</p>'),
        ('Code nobody calls',
         '<p>At 0x4575 sits a ten-byte routine that sets up a READ from video '
         'memory: the exact twin of the write one that is used. <b>There is '
         'not a single <code>call</code> or <code>jp</code> to that address in '
         'the whole ROM</b>, nor does it appear as a word in any table. It was '
         'left in.</p>'),
    ],
}

GALERIA = [
    ("titulo.png",
     "<b>La pantalla de titulo</b>, montada ejecutando los pasos del propio "
     "cartucho. El rotulo grande no es un dibujo suelto: son <b>tres filas de "
     "veinte celdas con patrones consecutivos</b> a partir del 0xC0, escritas "
     "por el bucle de 0x44A8 con un <code>inc d</code> por celda. El color lo "
     "pone un relleno de 480 bytes que alterna entre dos valores, y por eso el "
     "rotulo cambia de color",
     "<b>The title screen</b>, built by running the cartridge's own steps. The "
     "big wordmark is not a single piece of artwork: it is <b>three rows of "
     "twenty cells with consecutive patterns</b> from 0xC0 on, written by the "
     "loop at 0x44A8 with one <code>inc d</code> per cell. The colour comes "
     "from a 480-byte fill that alternates between two values, which is why "
     "the wordmark changes colour"),
    ("titulo_otro_color.png",
     "La misma pantalla con el otro color. No son dos dibujos: es el mismo, "
     "con el relleno de color puesto en 0xC0 en vez de 0xD0 segun el bit 0 del "
     "contador de 0xE043",
     "The same screen in the other colour. These are not two drawings: it is "
     "one, with the colour fill set to 0xC0 instead of 0xD0 depending on bit 0 "
     "of the counter at 0xE043"),
    ("marco_de_zona.png",
     "El <b>marco del area de juego</b> sin ninguna zona dentro, tal como lo "
     "deja la rutina de 0x4A61: dos filas de veinticuatro celdas arriba y "
     "abajo, cuatro columnas de veintidos a los lados, y encima el guion de "
     "0x71F7 con el resto del decorado",
     "The <b>playfield frame</b> with no zone in it, as the routine at 0x4A61 "
     "leaves it: two rows of twenty-four cells top and bottom, four columns of "
     "twenty-two down the sides, and on top the script at 0x71F7 with the rest "
     "of the trim"),
    ("zona_00.png",
     "La <b>primera zona</b>. Cada uno de los 120 bytes del mapa es un "
     "<b>metatile</b>, un cuadro de 2x2 celdas cuyos cuatro indices salen de "
     "la tabla de 0x6EF3. Doce de ancho por diez de alto, y esas dos cifras no "
     "salen del aspecto del dibujo: son el <code>cp 00ch</code> y el "
     "<code>cp 00ah</code> con los que cuenta el bucle de 0x64CD",
     "The <b>first zone</b>. Each of the map's 120 bytes is a <b>metatile</b>, "
     "a 2x2 block of cells whose four indices come from the table at 0x6EF3. "
     "Twelve across by ten down, and those two figures do not come from how "
     "the picture looks: they are the <code>cp 00ch</code> and "
     "<code>cp 00ah</code> the loop at 0x64CD counts with"),
    ("zona_02.png",
     "La <b>tercera zona</b>, ya con los macizos que hacen de obstaculo. El "
     "dibujo sale de descomprimir el bloque de 0x6648 con el RLE del cartucho "
     "y montar sus metatiles: no hay ninguna captura de por medio",
     "The <b>third zone</b>, now with the clumps that act as obstacles. The "
     "picture comes from unpacking the block at 0x6648 with the cartridge's "
     "RLE and assembling its metatiles: no capture involved"),
    ("zona_04.png",
     "La <b>zona de bonus</b>, que es la misma para las cinco que la usan (las "
     "entradas 4, 9, 14, 19 y 24 apuntan todas al bloque de 0x6E87). Dibuja "
     "letras con los propios metatiles del decorado",
     "The <b>bonus stage</b>, the same one for all five zones that use it "
     "(entries 4, 9, 14, 19 and 24 all point at the block at 0x6E87). It draws "
     "letters out of the scenery's own metatiles"),
    ("zona_08.png",
     "La zona de indice <b>8</b> -la que el marcador llama la 9-, la del "
     "descuadre: por el bucle que cuenta catorce sobre una lista de trece, es "
     "la unica que se libra del aviso <code>NO BIG RAZZON</code> sin estar en "
     "la lista",
     "The zone at index <b>8</b> -the one the scoreboard calls 9-, the odd one "
     "out: because of the loop that counts fourteen over a list of thirteen, "
     "it is the only one that escapes the <code>NO BIG RAZZON</code> notice "
     "without being on the list"),
    ("zona_12.png",
     "La <b>decimotercera</b>, de las mas cerradas del cartucho",
     "The <b>thirteenth</b>, one of the tightest in the cartridge"),
    ("zona_20.png",
     "La <b>vigesimo primera</b>. A partir de la 25 el juego vuelve a usar "
     "estos mismos mapas: cincuenta zonas anunciadas, veinticinco dibujos",
     "The <b>twenty-first</b>. From zone 25 on the game reuses these very "
     "maps: fifty zones announced, twenty-five drawings"),
    ("zona_23.png",
     "La <b>vigesimo cuarta</b>, la ultima antes de la zona de bonus que "
     "cierra la vuelta",
     "The <b>twenty-fourth</b>, the last one before the bonus stage that "
     "closes the lap"),
]
