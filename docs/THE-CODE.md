# The code

Of the cartridge, **7,789 bytes are code** and 8,595 are data. That is 3,802
instructions across 512 named routines.

## The shape of the program

Everything hangs off the interrupt. Each frame comes in at 0x4043, which
carries its own latch so it cannot re-enter if a frame takes longer than it
lasts, and from there goes out to the scene dispatch.

    interrupt (0x4043)
      +- scene dispatch (0x40AC), on (0xE000)
           +- 9 scenes: title, attract mode, play, start zone,
              lose a life, end of zone, tally, game over, wait

## The dispatcher, and why the tables are never loaded

The index dispatch for the whole cartridge is this routine:

    despacha_por_indice:
        pop hl          ; the return address: the TABLE itself
        call 0x50F2     ; A times two, HL += A, DE = word[HL]
        ex de,hl
        jp (hl)         ; and jump

The `pop hl` recovers the return address, which is **the table sitting right
behind the `call`**. That is why this game's dispatch tables are never loaded
into a register: they are written inline, in the gap between the `call` and the
code that follows.

For the disassembly that matters: a `jp (hl)` cannot be followed statically.
Without declaring those two tables -the nine scenes at 0x40DC and the five
substates at 0x4735- the trace stops at **5.7%**.

## Substates, with no table at all

Inside a scene there is no table: there is a chain of `djnz`.

    escena_de_juego:
        djnz L_41AC        ; if B != 1, on to the next substate
        ...                ; substate 1
    L_41AC:
        ...                ; substate 2

Every `djnz` that does not jump eats one of B, so the code left at the end is
the highest substate's. For five or six cases that is shorter than a table,
which is why there is not one here.

## The house compressor

A single RLE format, with two routines that read it:

    [control] bit 7 says literal or run,
              the other seven are the count
    [bytes]   the payload: C bytes if literal, one if it is a run
    0x00      closes

- **0x454F** unpacks into RAM. It is what stores the twenty-five maps.
- **0x451F** does the same but dumping to the **VDP port**, and takes two extra
  controls: an 0x80 opens another VRAM destination and an 0x00 closes. It is
  what loads patterns and colours.

Neither carries a length: the trailing 0x00 marks it. The honest way to find
where a block ends is to **run the decompressor**, and that is what
`tools/rle.py` does.

## The maps: 2x2 metatiles

Each zone is 120 unpacked bytes, and **each byte is a metatile**: a 2x2 block
of cells whose four indices live in the table at 0x6EF3, four bytes per entry.
The loop at 0x64CD writes two cells, adds 0x20 -a whole row of the name table-
and writes two more.

Twelve metatiles across by ten down. Those two figures do not come from looking
at the picture: they are the `cp 00ch` and the `cp 00ah` the loop counts with.

## Movement, square by square

Everything that moves shares one engine. When something squares up on a cell
-both coordinates multiples of eight- the routine at 0x52DC **reads off the
screen** the patterns of the surrounding cells and stores them in its block.
Everything after that -can it turn, is there floor, is there a ladder- is
answered from those bytes.

Turning ninety degrees requires being squared up; a U-turn is always allowed.
And on turning, the position is **dragged** to the multiple of eight one pixel
at a time in the direction of travel rather than rounded: that is why turns
feel glued to the grid.

## The sound

Three PSG channels, and effects carry a **priority**: a new one does not get in
if what is playing has an equal or higher number. Each effect takes two
channels, with its script pulled from the table of 27 pointers at 0x7CA9.

The routine that requests an effect saves **every** register, IX and IY
included, and disables interrupts: it is called from anywhere in the game and
the handler touches the PSG too.

## How to read this listing

Routine names are descriptive, and the comments are anchored to addresses in
`src/mopiranger.notes` rather than written into the `.asm`. The listing is
commented at **53.0%** and no routine is left below 10%.
