# Mopi Ranger (Konami, 1985) — a commented disassembly

A complete, commented disassembly of the MSX1 cartridge **Mopi Ranger**
(Konami, catalogue number **RC-728**, 16 KB), reproducible byte for byte.

**Web: <https://antxiko.github.io/MopiRanger-disassembly/>** · [En castellano](README.es.md)

|  |  |
|---|---|
| Of the binary explained | **100%** — 0 bytes unaccounted for, of 16,384 |
| Reassembles | **byte for byte**, to the same sha256 |
| Listing commented | **52.9%** — 2,012 comments over 3,802 instructions |
| Routines below the 10% bar | **0** of 512 |

## What is in here

    src/mopiranger.asm       the listing, generated
    src/mopiranger.notes     what is understood: data blocks and comments
    src/mopiranger.entries   the entry points, each with its reason
    src/mopiranger.nocode    the ranges that are not code
    tools/                   the tracer, the generator and the drawing tools
    docs/                    the website, in English and Spanish

## Running it

The cartridge is **not** distributed here. Put it in the root as
`mopiranger.rom` (16,384 bytes, sha256 `89ae5bdd1541c38c2593a91d36bdacf36634c0c8b85977ff2fff046bae4dadbf`)
and run:

    make comprueba      # check the dump is the right one
    make                # trace, build, reassemble, verify, test

It ends with `OK: reproducible byte a byte`, which means the listing gives back
the cartridge exactly.

## Some of what turned up

- **5730 points spell KONAMI.** A hidden bonus on an exact square of a bonus
  stage. In Japanese 5-7-3 reads *go-na-mi*.
- **The attract mode is not AI**: it is 77 recorded keypresses fed in where the
  joystick input would go.
- **The collision map is the screen itself** — the game reads video memory to
  find out where you can walk.
- **Fifty zones over twenty-five maps**, and the proof the compression is
  correctly understood is that all twenty-five unpack to exactly 120 bytes.
- **Colours sit below patterns** in video memory, the other way round from
  usual.

The full list is in [Findings](https://antxiko.github.io/MopiRanger-disassembly/FINDINGS.html),
and what is still **not** known in
[Open questions](https://antxiko.github.io/MopiRanger-disassembly/OPEN-QUESTIONS.html).

## Credit where it is due

The hidden Konami mark at the end of the ROM -the catalogue number and the
title in katakana- was discovered by **Manuel Pazos**
([@ManuelPazosMSX](https://twitter.com/ManuelPazosMSX)) in 2021.

## Legal

This is preservation, study and documentation work. The game and its artwork
remain the property of their rights holders; the cartridge image is not
distributed. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md) and [LICENSE](LICENSE).
