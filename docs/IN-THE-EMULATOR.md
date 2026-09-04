# In the emulator

How to see what this disassembly describes actually running. Everything here
uses **openMSX**, which has a debug console you can use to stop the game at an
address and look at memory.

## Starting it

    openmsx -machine "Philips_VG_8020" -cart mopiranger.rom

## Seeing the 5730-point prize

It is the easiest thing to check and the most satisfying. You need to reach a
bonus stage -zone 5, 10, 15...- and stand on the exact square. From the console
you can go straight there:

    debug set_breakpoint 0x4931 {} {puts "5730 points!"}

That breakpoint fires right on the `ld de,05730h`. If it triggers, the
`KONAMI 5730 PTS` caption is about to appear.

And rather than hunting for the square by hand, you can watch where the
protagonist is while you play:

    debug read_block memory 0xE130 2

First byte is X, second is Y. You want them at 0x90 and 0x39.

## Seeing that the attract mode is a script

Leave the game sitting on the title screen until the attract mode starts, then:

    debug read_block memory 0xE342 77

Those 77 bytes are the recorded keypresses. You can follow the pointer:

    debug set_watchpoint read_mem 0xE342 {} {puts "reading the script"}

And the sharp test: change a byte of the script live and watch the attract mode
do something else.

    debug write_block memory 0xE342 0x08

## Seeing the VDP registers the other way round

To check first-hand that the colours sit below the patterns:

    debug read_block "VDP regs" 0 8

Out come the eight bytes `02 E2 0E 7F 07 76 03 E0`. The fourth (R3=0x7F) is the
colour table and the fifth (R4=0x07) the pattern table.

## Watching the sprite table rotate

    debug set_watchpoint write_mem 0xE057 {} {puts [format "%02X" [debug read memory 0xE057]]}

0xE057 is the offset the sprite dump starts from each frame. It climbs by
sixteen and wraps at 0x80.

## Dumping video memory to check a drawing

This is what separates "the picture looks right" from "the picture IS right".
Dump the VRAM and compare it byte for byte against what the tools in `tools/`
draw:

    debug save_memory VRAM vram.bin

On the Python side, `tools/mapas.py` builds the same VRAM by running what the
cartridge does. If the two match, the format is properly understood.

## A warning about watchpoints

Putting a watchpoint over a large range with an expensive callback **freezes**
the emulator. What works is to start with a narrow probe, measure the write
rate, and only then decide whether the whole range is affordable.
