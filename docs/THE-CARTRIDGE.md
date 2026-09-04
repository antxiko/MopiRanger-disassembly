# The cartridge

*Mopi Ranger* is a **16 KB** MSX1 cartridge, Konami catalogue number
**RC-728**, from 1985. It maps into **page 1**, 0x4000 to 0x7FFF.

## The header

The first ten bytes are the header the BIOS reads:

    41 42 10 40 00 00 00 00 00 00
    A  B  INIT  STATEMENT DEVICE  TEXT

The `AB` is the signature that says a cartridge is there. Of the four
addresses, **only INIT is filled in**, at 0x4010; the other three are zero.

## Everything hangs off the interrupt

INIT does not start the game: it **hooks** it and then stops.

    di / im 1
    ld a,0c3h / ld (0fd9ah),a       a `jp` into H.KEYI
    ld hl,04043h / ld (0fd9bh),hl   and the handler behind it
    ld sp,0e400h                    the stack
    ld hl,0e000h ... ldir           clears the kilobyte of variables
    ...
    ei
    jr $                            and here it stays forever

From that `jr $` on, **the whole game runs from the interrupt**. That matters
when disassembling it: with only INIT declared as an entry point, the trace
stops at **1.3%** of the cartridge.

## The memory map

| where | what |
|---|---|
| 0x4000-0x400F | the header |
| 0x4010-0x5C75 | the code |
| 0x5C76-0x5DB7 | the text and the attract-mode script |
| 0x5E0E-0x5FB7 | patterns, compressed |
| 0x6035-0x64B4 | the fifty zones: pointers and data |
| 0x6522-0x6EF2 | the twenty-five maps, compressed |
| 0x6EF3-0x71F6 | the 193 metatiles |
| 0x722B-0x7AD3 | patterns and colours, compressed |
| 0x7C9D-0x7FC8 | the sound scripts |
| 0x7FC9-0x7FF3 | padding |
| 0x7FF4-0x7FFF | Konami's hidden mark |

In RAM, the variables live from 0xE000 to 0xE3FF with the stack just above.

## The screen

The cartridge loads its eight VDP registers from a table at 0x45F7, which reads
`02 E2 0E 7F 07 76 03 E0`:

| register | value | what it says |
|---|---|---|
| R0 | 0x02 | SCREEN 2 |
| R1 | 0xE2 | display on, interrupt enabled, 16x16 sprites |
| R2 | 0x0E | name table at **0x3800** |
| R3 | 0x7F | colour table at **0x0000** |
| R4 | 0x07 | pattern table at **0x2000** |
| R5 | 0x76 | sprite attributes at **0x3B00** |
| R6 | 0x03 | sprite patterns at **0x1800** |
| R7 | 0xE0 | border and background |

**The colours sit below the patterns**, the other way round from usual. R3 and
R4 are not addresses but base and mask, and reading them backwards gives
correct shapes with striped colours.

## Konami's hidden mark

The last twelve bytes are the mark **Manuel Pazos**
([@ManuelPazosMSX](https://twitter.com/ManuelPazosMSX)) found in 2021: Konami
hid the catalogue number and the title in katakana in many of its MSX
cartridges. The format, reading forwards:

    [title, N bytes, IN REVERSE ORDER] [N] [the two RC digits in BCD] [0xAA]

Here:

    BA B1 B7 8B AC A9 B8 9A A2   09   28   AA

Nine title bytes, the 0x09 saying how many, the **0x28** of **RC-728** and the
0xAA that closes it. The title, read back, is **モピレンジャー** -*Mopi
Renjaa*-, with the handakuten and the dakuten as separate characters.

This cartridge **does** carry it, and that cannot be assumed: of the twenty or
so cartridges by the same company disassembled in this series, fewer than half
have it. It has to be hunted for across the WHOLE ROM and not just at the end,
because it can end up sitting in front of a block of data.
