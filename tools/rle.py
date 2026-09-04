#!/usr/bin/env python3
"""El descompresor RLE del cartucho, rehecho en Python para MEDIR los bloques.

La rutina es L_454F (0x454f), y L_454C es la misma con el destino fijo en
0xE0B0. Traducida instruccion a instruccion:

    L_454F  ld a,(hl)          el byte de control
            and a / ret z      un 0x00 TERMINA el bloque
            and 07fh / ld c,a  los 7 bits de abajo son la cuenta
            ld a,(hl) / ld b,000h / inc hl
            rla                el bit 7 al acarreo
            jr nc,L_4560
            ldir               bit 7 = 1 -> copia C bytes tal cual
            jr L_454F
    L_4560  ld a,(hl) / ld b,c
    L_4562  ld (de),a / inc de / djnz L_4562    bit 7 = 0 -> el byte que
            inc hl                              sigue, repetido C veces
            jr L_454F

O sea: [control] donde el bit 7 dice literal o repeticion y los otros siete la
cuenta; detras van los bytes (C si es literal, uno solo si es repeticion); y un
control de 0x00 cierra.

Ejecutarlo es la unica forma honesta de saber donde acaba cada bloque: el
tamano no esta escrito en ninguna parte, lo marca el propio 0x00 final. Y de
paso sale el contenido descomprimido, que es lo que hay que dibujar.

Uso: rle.py <rom> <org> <dir> [<dir> ...]     descomprime esos bloques
     rle.py <rom> <org> --tabla <dir> <n>     recorre una tabla de n punteros
"""
import sys

MAX = 0x4000        # ningun bloque del cartucho puede pasar de esto


def descomprime(rom, org, inicio):
    """Devuelve (fin, datos) o None si el bloque no cierra dentro de la ROM."""
    p = inicio - org
    if p < 0 or p >= len(rom):
        return None
    salida = bytearray()
    while True:
        if p >= len(rom):
            return None                       # se sale: no era un bloque RLE
        ctrl = rom[p]
        p += 1
        if ctrl == 0x00:                      # el terminador
            return org + p, bytes(salida)
        cuenta = ctrl & 0x7F
        if ctrl & 0x80:                       # literal: C bytes tal cual
            if p + cuenta > len(rom):
                return None
            salida += rom[p:p + cuenta]
            p += cuenta
        else:                                 # repeticion: un byte, C veces
            if p >= len(rom):
                return None
            salida += bytes([rom[p]]) * cuenta
            p += 1
        if len(salida) > MAX:
            return None                       # no cierra: se desboca


def descomprime_vram(rom, org, inicio, destino=None):
    """El mismo RLE, pero volcando al puerto del VDP. L_451F (0x451f).

    Es la variante de L_4548 / L_4517: mismo byte de control -bit 7 literal o
    repeticion, siete bits de cuenta- y dos controles especiales de mas, que
    salen de leer el codigo, no de suponerlos:

        L_4522  ld a,(de) / and 07fh / ld b,a    B = la cuenta
                ld a,(de) / inc de
                jr z,L_4543           cuenta 0 -> es un control
                cp b / jr z,L_4537    A==B (bit 7 a 0) -> repeticion
        L_452D  literal: B bytes al puerto, uno a uno
        L_4537  repeticion: un byte, B veces
        L_4543  cp b / jr nz,L_4519   control 0x80 -> OTRO destino de VRAM
                ei / ret              control 0x00 -> FIN

    O sea que un bloque puede repartirse por varias zonas de la VRAM, cada una
    con su word de destino delante. Devuelve (fin, [(destino, datos), ...]).
    """
    p = inicio - org
    if p < 0 or p >= len(rom):
        return None
    trozos = []
    salida = bytearray()
    while True:
        if p >= len(rom):
            return None
        ctrl = rom[p]
        p += 1
        cuenta = ctrl & 0x7F
        if cuenta == 0:                       # los dos controles
            if ctrl == 0x00:                  # fin del bloque
                trozos.append((destino, bytes(salida)))
                return org + p, trozos
            if p + 2 > len(rom):
                return None
            trozos.append((destino, bytes(salida)))
            salida = bytearray()
            destino = rom[p] | (rom[p + 1] << 8)   # otro destino de VRAM
            p += 2
            continue
        if ctrl & 0x80:                       # literal
            if p + cuenta > len(rom):
                return None
            salida += rom[p:p + cuenta]
            p += cuenta
        else:                                 # repeticion
            if p >= len(rom):
                return None
            salida += bytes([rom[p]]) * cuenta
            p += 1
        if len(salida) > MAX:
            return None


def main():
    if len(sys.argv) < 4:
        print(__doc__)
        return 2
    rom = open(sys.argv[1], "rb").read()
    org = int(sys.argv[2], 0)

    if sys.argv[3] == "--vram":
        print("   bloque             comprimido  trozos  destinos y tamanos")
        print("  " + "-" * 68)
        for a in sys.argv[4:]:
            d = int(a, 0)
            r = descomprime_vram(rom, org, d)
            if r is None:
                print("  0x%04X  NO CIERRA como RLE de VRAM" % d)
                continue
            fin, trozos = r
            det = "  ".join("0x%04X:%d" % (t[0] if t[0] is not None else 0,
                                           len(t[1])) for t in trozos if t[1])
            print("  0x%04X..0x%04X  %6d  %6d  %s"
                  % (d, fin, fin - d, len([t for t in trozos if t[1]]), det))
        return 0

    if sys.argv[3] == "--tabla":
        base = int(sys.argv[4], 0)
        n = int(sys.argv[5], 0)
        print("  tabla de %d punteros en 0x%04X" % (n, base))
        print()
        print("   i  puntero  bloque             comprimido  descomprimido")
        print("  " + "-" * 62)
        fin_max = base
        for i in range(n):
            o = base - org + i * 2
            d = rom[o] | (rom[o + 1] << 8)
            r = descomprime(rom, org, d)
            if r is None:
                print("  %2d  0x%04X   NO CIERRA como RLE" % (i, d))
                continue
            fin, datos = r
            fin_max = max(fin_max, fin)
            print("  %2d  0x%04X   0x%04X..0x%04X  %6d      %6d"
                  % (i, d, d, fin, fin - d, len(datos)))
        print("  " + "-" * 62)
        print("  el bloque mas lejano cierra en 0x%04X" % fin_max)
        return 0

    for a in sys.argv[3:]:
        d = int(a, 0)
        r = descomprime(rom, org, d)
        if r is None:
            print("  0x%04X  NO CIERRA como RLE dentro de la ROM" % d)
            continue
        fin, datos = r
        print("  0x%04X..0x%04X  %d bytes -> %d descomprimidos"
              % (d, fin, fin - d, len(datos)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
