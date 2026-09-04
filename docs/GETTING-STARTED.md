# Getting started

This repository does not ship the game. It ships the **commented
disassembly** of *Mopi Ranger* (Konami, 1985, RC-728) and the tools that
reproduce it.

## What you need

- The cartridge, exactly 16,384 bytes, in the root and named
  `mopiranger.rom`. Its sha256 is
  `89ae5bdd1541c38c2593a91d36bdacf36634c0c8b85977ff2fff046bae4dadbf`.
- `pasmo` and `z80dasm` on the PATH.
- Python 3.
- `make`.

## The check that decides

    make comprueba      # that the dump is the same one
    make                # trace, build the listing, reassemble and check

`make` ends with this, and it is the only line that matters:

    OK: reproducible byte a byte

It means that the listing in `src/mopiranger.asm`, assembled, gives back **the
same 16,384 bytes** as the cartridge. If that fails, nothing else counts.

## What each target does

| target | what it does |
|---|---|
| `make trace` | follows the flow from the entry points in `src/mopiranger.entries` |
| `make listado` | writes `src/mopiranger.asm` from the trace and the notes |
| `make verify` | assembles and compares the sha256 with the original |
| `make sanity` | what reassembly does NOT cover (see below) |
| `make test` | the tests |
| `make densidad` | how much of the listing is commented |
| `make mapas` | draws the zones by unpacking them |
| `make web` | builds these pages |

## Why `verify` is not enough

A listing can reproduce the ROM byte for byte and still be telling lies: bytes
do not change because you read them wrong. What catches that is `make sanity`:

- **that no data comes out as code**: if the tracer walks into a table it
  disassembles it as instructions, and coverage goes up with nothing failing.
- **that no entry point falls inside a data range**, which is how a listing
  ends up contradicting itself.
- **that not one byte is left unexplained**. Here it is 16,384 out of 16,384,
  100%.

## The files

    src/mopiranger.entries   the entry points, each with its reason
    src/mopiranger.nocode    the ranges that are NOT code
    src/mopiranger.notes     what is understood: data blocks and comments
    src/mopiranger.asm       the listing, generated
    tools/                   the tracer, the generator and the drawing tools

The `.asm` is **generated**: what you edit is the `.notes`, because the
comments are anchored to addresses and so survive a re-trace.
