#!/usr/bin/env python3
"""Comprobaciones sobre el listado generado y sobre la web.

Ninguna necesita el cartucho: se hacen sobre src/mopiranger.asm,
src/mopiranger.notes y el trazado. Vigilan que el listado no se degrade sin que
nadie se entere -que no desaparezcan comentarios, que no vuelvan a aparecer
bloques sin identificar- y que las cifras publicadas en la web sean las del
arbol y no las que habia cuando se escribio el texto.
"""
import json
import os
import re
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASM = os.path.join(RAIZ, "src", "mopiranger.asm")
NOTES = os.path.join(RAIZ, "src", "mopiranger.notes")
ENTRIES = os.path.join(RAIZ, "src", "mopiranger.entries")
TRACE = os.path.join(RAIZ, "work", "mopiranger.trace.json")
DOCS = os.path.join(RAIZ, "docs")
ORG, FIN = 0x4000, 0x8000

sys.path.insert(0, os.path.join(RAIZ, "tools"))

# Los demas juegos de la serie. Que el nombre de otro salga en una pagina de
# este es casi siempre un copia y pega: ya paso con cinco ficheros LICENSE y
# con el pie de catorce paginas de otro proyecto.
OTROS_JUEGOS = (
    "Tennis", "Pitfall", "Temptations", "Stardust", "Ale Hop", "Colt 36",
    "Antarctic", "Athletic Land", "Monkey Academy", "F-1 Spirit", "Pippols",
    "Time Pilot", "Frogger", "Super Cobra", "Billiards", "Mahjong",
    "Hyper Rally", "Hyper Sports", "Nemesis", "Demonia", "Cabbage",
    "Hole in One", "Casio World Open", "3D Golf", "Baseball",
    "Yie Ar Kung-Fu", "King's Valley", "Sky Jaguar", "Road Fighter",
    "Ping Pong",
)


def lee(ruta):
    with open(ruta, encoding="utf-8") as f:
        return f.read()


def bloques_del_listado(lineas):
    """Los mismos bloques que cuenta tools/densidad.py, con su misma logica.

    Dos detalles suyos hay que respetar o las cifras no cuadran: una etiqueta
    solo cuenta si su linea no lleva nada mas (salvo un comentario), y una
    linea es de INSTRUCCION cuando su direccion viene pegada al punto y coma
    (";4323"), mientras que las de datos llevan un espacio ("; 4323"). Por eso
    los bloques DATA_ salen con cero instrucciones y no cuentan como rutina.
    """
    bloques, nombre, ini, n, c = [], "(cabecera)", 0, 0, 0
    for ln in lineas:
        m = re.match(r"^([A-Za-z_][A-Za-z_0-9]*):\s*(;.*)?$", ln)
        if m:
            if n:
                bloques.append((nombre, ini, n, c))
            nombre, ini, n, c = m.group(1), 0, 0, 0
            continue
        m = re.match(r"^\t.*;([0-9a-f]{4})(.*)$", ln)
        if not m:
            continue
        if not ini:
            ini = int(m.group(1), 16)
        n += 1
        if ";" in m.group(2):
            c += 1
    if n:
        bloques.append((nombre, ini, n, c))
    return bloques


def rom_del_listado():
    """Reconstruye los BYTES DE DATOS del cartucho leyendo el listado.

    El cartucho no viaja con el repositorio, pero src/mopiranger.asm si, y cada
    fila de datos lleva su direccion en el comentario -eso lo pone mkasm.py-.
    Con las filas `defb` y `defw` se rehace un buffer de 16 KB con todas las
    zonas de datos en su sitio, que es lo unico que el descompresor necesita
    leer. Asi estos tests corren en un clon pelado, sin cartucho y sin `make`.
    """
    rom = bytearray(FIN - ORG)
    for linea in lee(ASM).splitlines():
        m = re.match(r"\s*(defb|defw)\s+([^;]+);\s*([0-9a-f]{4})", linea)
        if not m:
            continue
        que, cuerpo, addr = m.group(1), m.group(2), int(m.group(3), 16)
        p = addr - ORG
        for tok in cuerpo.split(","):
            tok = tok.strip()
            if not re.fullmatch(r"[0-9][0-9a-fA-F]*h", tok):
                continue
            v = int(tok[:-1], 16)
            if que == "defb":
                rom[p] = v & 0xFF
                p += 1
            else:
                rom[p] = v & 0xFF
                rom[p + 1] = (v >> 8) & 0xFF
                p += 2
    return bytes(rom)


class TestListado(unittest.TestCase):
    """El listado en si."""

    @classmethod
    def setUpClass(cls):
        cls.asm = lee(ASM)
        cls.lineas = cls.asm.splitlines()

    def test_no_quedan_bloques_sin_identificar(self):
        """Cada bloque de datos tiene que tener nombre y explicacion.

        mkasm.py escribe "DATOS sin identificar" en los bloques que no tienen
        una directiva D en el .notes. Que vuelva a aparecer uno significa que
        el trazado ha cambiado y hay bytes que ya nadie explica.
        """
        sueltos = [l for l in self.lineas if "DATOS sin identificar" in l]
        self.assertEqual(
            sueltos, [],
            "han vuelto a aparecer bloques sin identificar:\n"
            + "\n".join(sueltos))

    def test_todas_las_rutinas_llegan_al_liston(self):
        """Ninguna rutina por debajo del 10 % de densidad de comentario.

        Es el liston de la serie, y se mide igual que densidad.py: solo cuentan
        las rutinas de SEIS instrucciones o mas, porque por debajo de eso un
        solo comentario ya distorsiona el porcentaje.
        """
        flojas = ["%s 0x%04X (%d/%d)" % (nom, ini, c, n)
                  for nom, ini, n, c in bloques_del_listado(self.lineas)
                  if n >= 6 and c * 100 // n < 10]
        self.assertEqual(flojas, [],
                         "rutinas por debajo del 10 %%: %s" % ", ".join(flojas))

    def test_hay_al_menos_mil_comentarios(self):
        """Un suelo para que un cambio no se lleve por delante el trabajo."""
        comentados = sum(1 for l in self.lineas
                         if re.search(r";[0-9a-f]{4}\s+;", l))
        self.assertGreaterEqual(comentados, 1000,
                                "solo quedan %d comentarios de linea"
                                % comentados)

    def test_las_etiquetas_son_snake_case(self):
        """mkasm.py no acepta parentesis ni espacios en un nombre de rutina.

        Cuando pasa, no da error: funde el bloque con el anterior y esa rutina
        desaparece de la cuenta sin avisar.
        """
        malas = []
        for linea in self.lineas:
            m = re.match(r"^([^\s:]+):", linea)
            if m and not re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", m.group(1)):
                malas.append(m.group(1))
        self.assertEqual(malas, [], "etiquetas con caracteres raros: %s" % malas)


class TestCobertura(unittest.TestCase):
    """El presupuesto de los 16 KB."""

    def test_el_trazado_cubre_el_cartucho_entero(self):
        """Codigo trazado mas datos declarados tienen que dar los 16.384."""
        if not os.path.exists(TRACE):
            self.skipTest("falta el trazado; corre `make trace` primero")
        with open(TRACE, encoding="utf-8") as f:
            trace = json.load(f)
        explicado = set()
        for tipo, ini, fin in trace["blocks"]:
            explicado.update(range(max(ini, ORG), min(fin, FIN)))
        for linea in lee(NOTES).splitlines():
            m = re.match(r"^D\s+(0x[0-9a-fA-F]+)\s+(0x[0-9a-fA-F]+)", linea)
            if m:
                explicado.update(range(int(m.group(1), 16),
                                       int(m.group(2), 16)))
        sin_explicar = sorted(set(range(ORG, FIN)) - explicado)
        self.assertEqual(
            sin_explicar, [],
            "%d bytes sin explicar, el primero en 0x%04X"
            % (len(sin_explicar), sin_explicar[0] if sin_explicar else 0))

    def test_las_entradas_estan_justificadas(self):
        """Cada punto de entrada lleva su razon escrita al lado.

        Una entrada sin justificar es una direccion que alguien metio a mano
        para que el trazado cuadrase, y eso es exactamente lo que no se puede
        hacer sin dejar constancia.
        """
        sin_razon = []
        for linea in lee(ENTRIES).splitlines():
            limpia = linea.strip()
            if not limpia or limpia.startswith("#"):
                continue
            if "#" not in limpia:
                sin_razon.append(limpia)
        self.assertEqual(sin_razon, [],
                         "entradas sin justificacion: %s" % sin_razon)


class TestNotas(unittest.TestCase):
    """El fichero de notas, que es donde vive lo entendido."""

    @classmethod
    def setUpClass(cls):
        cls.notes = lee(NOTES)

    def test_cada_bloque_de_datos_tiene_nombre_y_explicacion(self):
        """Ninguna directiva D puede quedarse en un nombre a secas.

        La norma de la serie es que cada bloque diga QUE es y COMO se sabe. Un
        bloque con nombre y sin explicacion esta bautizado, no entendido, que
        es justo lo que el nombre disimula.
        """
        pelados = []
        for m in re.finditer(
                r"^D\s+0x[0-9a-fA-F]+\s+0x[0-9a-fA-F]+\s+(\S+)(.*)$",
                self.notes, re.MULTILINE):
            if len(m.group(2).strip()) < 20:
                pelados.append(m.group(1))
        self.assertEqual(pelados, [],
                         "bloques D sin explicacion: %s" % pelados[:10])

    def test_las_anchuras_declaradas_apuntan_a_un_bloque(self):
        """Toda F tiene que caer en la direccion de arranque de una D.

        La F que se escribe con la direccion equivocada no da error: se aplica
        al bloque de al lado y le pone una anchura que no es la suya. Es un
        fallo silencioso, y este test es la unica forma de cazarlo.
        """
        inicios = {d.lower() for d in
                   re.findall(r"^D\s+(0x[0-9a-fA-F]+)", self.notes,
                              re.MULTILINE)}
        huerfanas = [f for f in re.findall(r"^F\s+(0x[0-9a-fA-F]+)",
                                           self.notes, re.MULTILINE)
                     if f.lower() not in inicios]
        self.assertEqual(huerfanas, [],
                         "anchuras que no caen en ningun bloque: %s"
                         % huerfanas)


class TestRLE(unittest.TestCase):
    """El descompresor del cartucho, que es lo que sostiene medio presupuesto.

    Estas comprobaciones no miran el aspecto de los bytes: EJECUTAN el
    descompresor rehecho en tools/rle.py sobre los datos del propio listado. Si
    el formato estuviera mal leido, los bloques no cerrarian donde cierran.
    """

    @classmethod
    def setUpClass(cls):
        cls.rom = rom_del_listado()

    def test_los_25_mapas_dan_120_bytes_cada_uno(self):
        """El encaje que demuestra que el formato RLE es el correcto.

        Los veinticinco mapas de zona estan comprimidos y ninguno lleva su
        tamano escrito: lo marca el 0x00 final. Que los veinticinco den
        EXACTAMENTE 120 bytes no puede salir de una lectura equivocada.
        """
        from rle import descomprime
        tamanos = []
        for i in range(25):
            p = 0x6522 - ORG + i * 2
            destino = self.rom[p] | (self.rom[p + 1] << 8)
            r = descomprime(self.rom, ORG, destino)
            self.assertIsNotNone(r, "el mapa %d (0x%04X) no cierra" % (i, destino))
            tamanos.append(len(r[1]))
        self.assertEqual(set(tamanos), {120},
                         "los mapas dan tamanos distintos: %s" % sorted(set(tamanos)))

    def test_los_mapas_son_contiguos_y_cierran_en_6ef3(self):
        """Los bloques se tocan: el fin de uno es el principio del siguiente."""
        from rle import descomprime
        destinos = set()
        for i in range(25):
            p = 0x6522 - ORG + i * 2
            destinos.add(self.rom[p] | (self.rom[p + 1] << 8))
        finales = {}
        for d in destinos:
            finales[d] = descomprime(self.rom, ORG, d)[0]
        self.assertEqual(min(destinos), 0x6554)
        self.assertEqual(max(finales.values()), 0x6EF3)
        # cada final tiene que ser el arranque de otro, salvo el ultimo
        huerfanos = [f for f in finales.values()
                     if f not in destinos and f != 0x6EF3]
        self.assertEqual(huerfanos, [],
                         "bloques que no encajan con el siguiente: %s"
                         % ["0x%04X" % h for h in huerfanos])

    def test_la_zona_de_bonus_es_una_de_cada_cinco(self):
        """Las entradas 4, 9, 14, 19 y 24 apuntan las cinco al mismo mapa."""
        punteros = []
        for i in range(25):
            p = 0x6522 - ORG + i * 2
            punteros.append(self.rom[p] | (self.rom[p + 1] << 8))
        quintas = {punteros[i] for i in (4, 9, 14, 19, 24)}
        self.assertEqual(len(quintas), 1,
                         "las quintas zonas no comparten mapa: %s" % quintas)
        otras = {punteros[i] for i in range(25) if i % 5 != 4}
        self.assertNotIn(quintas.pop(), otras,
                         "el mapa de bonus tambien sale como zona normal")

    def test_los_graficos_cierran_contiguos(self):
        """Los cuatro bloques grandes de VRAM se tocan de 0x722B a 0x79AA."""
        from rle import descomprime_vram
        cadena = [0x722B, 0x753D, 0x7683, 0x79AA]
        for i, d in enumerate(cadena):
            r = descomprime_vram(self.rom, ORG, d)
            self.assertIsNotNone(r, "0x%04X no cierra como RLE de VRAM" % d)
            siguiente = cadena[i + 1] if i + 1 < len(cadena) else 0x7AD4
            self.assertEqual(r[0], siguiente,
                             "0x%04X cierra en 0x%04X y deberia en 0x%04X"
                             % (d, r[0], siguiente))


class TestTablas(unittest.TestCase):
    """Las tablas de punteros, y la prueba de donde acaba cada una."""

    @classmethod
    def setUpClass(cls):
        cls.rom = rom_del_listado()

    def palabra(self, a):
        return self.rom[a - ORG] | (self.rom[a - ORG + 1] << 8)

    def test_la_tabla_de_zonas_tiene_50_entradas(self):
        """Cincuenta zonas sobre veinticinco mapas.

        La tabla cierra en 0x6099, y la prueba independiente es que 0x4b27
        carga justo esa direccion en DE para el bloque siguiente.
        """
        n = 0
        a = 0x6035
        while 0x6000 <= self.palabra(a) < 0x64B5:
            n += 1
            a += 2
        self.assertEqual(n, 50, "la tabla de zonas tiene %d entradas" % n)
        self.assertEqual(a, 0x6099, "la tabla cierra en 0x%04X" % a)

    def test_la_tabla_de_guiones_cierra_en_su_primer_destino(self):
        """Veintisiete punteros que acaban clavados donde empieza el primero.

        Es el encaje que fija el final de la tabla sin tener que suponerlo.
        """
        n = 0
        a = 0x7CA9
        destinos = []
        while 0x7CDF <= self.palabra(a) < 0x7FC9:
            destinos.append(self.palabra(a))
            n += 1
            a += 2
        self.assertEqual(n, 27, "hay %d punteros de guion" % n)
        self.assertEqual(a, min(destinos),
                         "la tabla cierra en 0x%04X y su primer destino es 0x%04X"
                         % (a, min(destinos)))

    def test_la_marca_de_konami_dice_rc728(self):
        """La marca oculta que encontro Manuel Pazos, al final de la ROM.

        Formato: el titulo del reves, su longitud, las dos cifras del RC en BCD
        y un 0xAA. Aqui son nueve bytes de titulo y el 0x28 de RC-728.
        """
        self.assertEqual(self.rom[0x7FFF - ORG], 0xAA, "no cierra con 0xAA")
        self.assertEqual(self.rom[0x7FFE - ORG], 0x28, "el RC no es 728")
        self.assertEqual(self.rom[0x7FFD - ORG], 0x09,
                         "el titulo no mide nueve bytes")

    def test_los_metatiles_son_grupos_de_cuatro(self):
        """193 cuadros de 2x2, que es lo que 0x64dd escribe: dos celdas, una
        fila abajo (0x20) y otras dos."""
        self.assertEqual((0x71F7 - 0x6EF3) % 4, 0,
                         "el bloque de metatiles no es multiplo de cuatro")
        self.assertEqual((0x71F7 - 0x6EF3) // 4, 193)


class TestWeb(unittest.TestCase):
    """La web: que las cifras sean las del arbol y no las del texto viejo."""

    def test_no_se_nombra_otro_juego_de_la_serie(self):
        """El nombre de otro juego en estas paginas es un copia y pega.

        Ya paso con cinco ficheros LICENSE y con el pie de catorce paginas.
        """
        if not os.path.isdir(DOCS):
            self.skipTest("todavia no hay web")
        fallos = []
        for carpeta, _dirs, ficheros in os.walk(DOCS):
            for fich in ficheros:
                if not fich.endswith((".md", ".html")):
                    continue
                texto = lee(os.path.join(carpeta, fich))
                for juego in OTROS_JUEGOS:
                    if juego in texto:
                        fallos.append("%s en %s" % (juego, fich))
        self.assertEqual(fallos, [], "nombres de otros juegos: %s" % fallos)


if __name__ == "__main__":
    unittest.main()
