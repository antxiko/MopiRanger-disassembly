# Findings

What turned up when the cartridge was taken apart. Everything here is
**measured** -by running the format, or by reading the constants the code
counts with- not inferred from how the bytes look.

## 5730 points spell KONAMI

On a bonus stage, with the protagonist on the **exact** square X=0x90, Y=0x39,
and only once per game, the cartridge prints `KONAMI 5730 PTS` and awards those
5730 points.

    0x4910   call es_zona_de_bonus
             ret nz                      bonus stages only
             ld a,(0e068h) / and a
             ret nz                      and only once
             ld hl,(0e132h)
             ld a,l / cp 090h / ret nz    the exact X
             ld a,h / sub 039h / ret nz   and the exact Y
             ...
             ld de,05730h
             jp suma_al_marcador

The two figures agree on their own: the caption says 5730 and the instruction
adds 5730.

And the number is not arbitrary. Japanese numbers can be read by their sound:
**5 = go, 7 = na, 3 = mi**, that is ***go-na-mi***. It is an easter egg the
company reused across many of its games, arcade ones included.

## The cartridge defends itself: copy protection

Two instructions in the start-up write inside the cartridge itself:

- **0x406A** puts a `pop hl` and a `ret` over the `djnz` at 0x4146.
  It does it byte by byte, and it does not invent the `0xE1`: it reads
  it from a `pop hl` already in the ROM.
- **0x40A5** leaves a zero at 0x44DF, which is not data: it is the operand of
  the `jp` at 0x44DE. In memory that turns it into `jp 00000h`, a dead reset.

**Neither of them does anything here.** The cartridge runs from ROM, and ROM takes no
writes: that is why they look like dead code. They are not. A pirated cartridge is a
copy loaded into **RAM**, and there the write does land and breaks the game.
Doing nothing on the original is exactly the point.

This is no one-off idea in this cartridge: the same pair —a write over a `djnz`
and another over the operand of a `jp`— turns up in ten cartridges of this
series, always in the same two start-up routines. **Manuel Pazos** identified
them in his disassembly of RC-727, where he named them `ReadKeys_AC` and
`VRAM_writeAC`.

## The attract mode is a recorded game

When nobody is playing, the character moves by itself. No routine decides
anything: there are **77 recorded keypresses**.

They are compressed at 0x5D82, unpacked to 0xE342, and the routine at 0x468F
reads them one every two frames and drops them **where the joystick reading
would go**. The script ends with an 0xFF, which is what clears the flag and
ends the attract mode.

The values are the joystick masks themselves: 0x01 up, 0x02 down, 0x04 left,
0x08 right, 0x10 the button. The first ones are `02 02 02 02 02 02 08 08 08...`
-down six times, then right-. The rest of the game cannot tell whether a person
or the script is playing.

The fit that confirms it: the block unpacks to **exactly 77 bytes** and the
last one is precisely the 0xFF the routine looks for.

## The collision map is the screen itself

This cartridge keeps no walkability map in memory. To find out, it **reads the
screen**: it calls RDVRM and looks at which pattern is drawn on the square.
Below 0x80 is wall -noted down as 0x84- and from 0x90 on you can walk.

That explains a detail that would otherwise look arbitrary: every time an
object is placed, the game notes down **what was underneath**. Otherwise
picking it up would punch a walkable hole in the wall.

## Fifty zones over twenty-five maps

    0x498E   ld a,(0e053h)      the zone number
             ld hl,06522h       the table of 25 maps
             cp 019h            below 25 it goes straight in
             jr c,+
             sub 019h           and from 25 on it repeats

Of the twenty-five maps, four are the same one: entries 4, 9, 14, 19 and 24 all
point at the block at 0x6E87. **One zone in five is a bonus stage.**

The proof that the RLE format is read correctly is not that the maps look
right. It is that all twenty-five, carrying their length nowhere, unpack to
**exactly 120 bytes** each, and fill the ROM from 0x6554 to 0x6EF3 without a
gap.

## Colours sit below patterns

In SCREEN 2 the usual arrangement is patterns at 0x0000 and colours at 0x2000.
Here it is reversed, and the eight bytes the cartridge loads into the VDP say
so: **R3=0x7F** puts colours at 0x0000 and **R4=0x07** patterns at 0x2000.

R3 and R4 are not addresses but base and mask. Reading them backwards does not
fail loudly: it gives correct shapes and striped colours.

## Five enemies, five ways of chasing

The dispatch at 0x569F sends each type to its own routine, and no two do the
same thing:

- **Type 1**: does not go where you are, it goes **where you will be**, adding
  a lead taken from a table according to the direction you are holding.
- **Type 2**: does not chase, it **mirrors**. It copies the player's direction
  with the horizontal axis flipped.
- **Type 3**: heads for your **mirror point**, and so prowls the screen instead
  of following you.
- **Type 4**: like type 1, with a shorter lead.
- **Type 5**, the big one: goes for the **objects**.

The shared engine measures both distances, takes the axis you are furthest
along, and **never picks the U-turn**: that last part is what stops them
dithering in a corridor.

## The sprite table is rotated every frame

The MSX1 only shows four sprites per line, and the first ones in the table
always win. The routine at 0x459A dumps the table **starting sixteen bytes
further along each frame**, wrapping at the end. Since the order shifts, the
one that loses is never the same: instead of an invisible character, shared
flicker.

## The flowing scenery stores not one frame

The background animations have no alternative artwork. The pattern already in
video memory is taken and its bits are **rotated** with `rrca` or `rlca`: one
pixel per turn, eight bytes per pattern. The other variant shifts whole bytes
one row with an `lddr` and wraps the one that falls off.

## An address means nothing without a moment attached

0xE0B0 is **two different things**: while the zone is being built it holds the
unpacked map -120 bytes- and during play it is the **32 sprite attributes**
-128 bytes- dumped in one go to 0x3B00. The same kilobyte does both jobs
because they are never needed at the same time.

## A loop that counts fourteen over a list of thirteen

The routine at 0x41D5 looks up the zone number in the list of those carrying a
big razzon and, failing to find it, prints `NO BIG RAZZON`. It enters with
`ld b,00eh` -fourteen turns- but from 0x609E to 0x60AA there are only
**thirteen bytes**:

    05 06 07 0A 0B 0C 10 11 12 1F 23 25 2B    the thirteen, ascending
    08                                        the fourteenth, already outside

The fourteenth comparison lands on 0x60AB, the first byte of zone 0's block
-exactly where the zone table's first entry points- and reads 0x08. That 0x08
breaks the ascending order of the other thirteen.

The effect can be stated without guessing at intent: **zone 8 matches too**,
and so it never gets the notice even though it is not on the list.

## Code nobody calls

At 0x4575 sit ten bytes that set up a **read** from video memory -`call 0x0050`
and the port taken from 0x0007- the exact twin of the write one that is used.
There is not a single `call` or `jp` to that address in the whole ROM, nor does
it appear as a word in any table. It was left in.
