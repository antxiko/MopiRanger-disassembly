#!/usr/bin/env python3
"""La musica del cartucho, ejecutando su motor de sonido (ver motor_musica.py).

Pide el sonido con `suena` (0x7AD4, A = numero) y corre `atiende_el_sonido`
(0x7B67), que la interrupcion llama cada cuadro (0x4047). Tres canales de 14
bytes desde 0xE018; la copia del registro 7 del PSG, en 0xE042.
Uso:  musica.py registros 0x8F [cuadros] | mp3 0x8F f.mp3 | todas docs/audio
      musica.py barrido 0x80 0xBF | emu
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

TABLA = "ninguna llamada directa: está en la tabla de pistas"

PIEZAS = [
    P(0x8F, "El aviso de zona", "The zone warning",
      "`suena_el_aviso_de_zona`"),
    P(0x8A, "La entrada", "The entrance", "`tramo_de_entrada`"),
    P(0x92, "Game over", "Game over", "`pinta_el_game_over`"),
    P(0x99, "La pieza del 0x50FA", "The tune at 0x50FA", "`L_50FA`"),
] + [P(n, "Pista 0x%02X de la tabla" % n, "Table track 0x%02X" % n, TABLA)
     for n in (0x8B, 0x8D, 0x8E, 0x90, 0x91, 0x93, 0x94)]

PAGINA = motor_musica.pagina_basica(
    "`atiende_el_sonido`, 0x7B67, y `suena`, 0x7AD4, que le reparte los "
    "canales; lo llama la interrupción en 0x4047",
    "`atiende_el_sonido`, 0x7B67, and `suena`, 0x7AD4, which hands it the "
    "channels; the interrupt calls it at 0x4047",
    "C-BIOS MSX1 japonés",
    [("el aviso de zona (0x8F) entero, 282 cuadros, tal como el juego lo pide",
      "the zone warning (0x8F), whole, 282 frames, as the game asks for it"),
     ("la entrada (0x8A) entera, 57 cuadros",
      "the entrance (0x8A), whole, 57 frames"),
     ("«game over» (0x92), sus primeros 222 cuadros",
      "\"game over\" (0x92), its first 222 frames")],
    [("Cómo se pide una pieza",
      "`suena` recibe el número en A. Los números bajos son efectos y del "
      "0x8A en adelante hay música. Cada canal ocupa catorce bytes desde "
      "0xE018 y 0xE042 guarda la copia del mezclador del PSG, que el "
      "arranque deja en 0xB8. Las pistas «de la tabla» están en la tabla "
      "de pistas pero ninguna rutina las pide con un `ld a`.",
      "How a piece is asked for",
      "`suena` takes the number in A. Low numbers are effects and from 0x8A "
      "up there is music. Each channel takes fourteen bytes from 0xE018 and "
      "0xE042 holds the copy of the PSG mixer, which start-up leaves at "
      "0xB8. The tracks marked «in the table» are in the track table but no "
      "routine asks for them with an `ld a`.")])

CFG = dict(rom="mopiranger.rom", org=0x4000, frame=0x7B67, pide=0x7AD4,
           ram=(0xE018, 0xE043), ram0=[(0xE042, 0xB8)],
           excluye=[0xE021, 0xE02F, 0xE03D], hz=60, psg0={7: 0xB8},
           piezas=PIEZAS, pagina=PAGINA,
           cotejado=[(0x8F, 282, None), (0x8A, 57, 1)])

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
