# The music

Everything you hear here comes from running the cartridge's own sound engine (`atiende_el_sonido`, 0x7B67, and `suena`, 0x7AD4, which hands it the channels; the interrupt calls it at 0x4047) on an emulated Z80, frame by frame at 60 per second, just as the game calls it. What the engine writes to the PSG is turned into sound with an AY-3-8910 (`tools/musica.py`). Each MP3 is the whole piece up to where it starts again, plus 8 seconds of the repeat fading out; those that do not repeat end where the engine ends.

## Checked against openMSX

The PSG writes have been compared frame by frame with those of openMSX (C-BIOS MSX1 japonés). In every frame the PSG ends up the same:

- the zone warning (0x8F), whole, 282 frames, as the game asks for it;
- the entrance (0x8A), whole, 57 frames;
- "game over" (0x92), its first 222 frames.

The timbre is not checked: it is a textbook AY-3-8910, not a recording of the emulator. The probes are `tools/omsx_psg.tcl` and `tools/coteja_psg.py`.

## How a piece is asked for

`suena` takes the number in A. Low numbers are effects and from 0x8A up there is music. Each channel takes fourteen bytes from 0xE018 and 0xE042 holds the copy of the PSG mixer, which start-up leaves at 0xB8. The tracks marked «in the table» are in the track table but no routine asks for them with an `ld a`.

## The tunes

**The zone warning** (0x8F)

Asked for by `suena_el_aviso_de_zona`; lasts 4.7 s.

<audio controls preload="none" src="audio/musica_8F.mp3?v=5b85bcca"></audio>

**The entrance** (0x8A)

Asked for by `tramo_de_entrada`; lasts 0.9 s and starts again at second 0.0.

<audio controls preload="none" src="audio/musica_8A.mp3?v=65d1be6d"></audio>

**Game over** (0x92)

Asked for by `pinta_el_game_over`; lasts 4.1 s.

<audio controls preload="none" src="audio/musica_92.mp3?v=98cdcd31"></audio>

**The tune at 0x50FA** (0x99)

Asked for by `L_50FA`; lasts 0.0 s.

<audio controls preload="none" src="audio/musica_99.mp3?v=719153cf"></audio>

**Table track 0x8B** (0x8B)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 4.7 s and starts again at second 3.8.

<audio controls preload="none" src="audio/musica_8B.mp3?v=8a443c3b"></audio>

**Table track 0x8D** (0x8D)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 4.7 s.

<audio controls preload="none" src="audio/musica_8D.mp3?v=1ca36ae6"></audio>

**Table track 0x8E** (0x8E)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 4.7 s.

<audio controls preload="none" src="audio/musica_8E.mp3?v=45d3f1fc"></audio>

**Table track 0x90** (0x90)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 4.7 s.

<audio controls preload="none" src="audio/musica_90.mp3?v=cbdeed21"></audio>

**Table track 0x91** (0x91)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 4.7 s.

<audio controls preload="none" src="audio/musica_91.mp3?v=2e8c3275"></audio>

**Table track 0x93** (0x93)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 50.3 s.

<audio controls preload="none" src="audio/musica_93.mp3?v=cd77c0d8"></audio>

**Table track 0x94** (0x94)

Asked for by ninguna llamada directa: está en la tabla de pistas; lasts 50.3 s.

<audio controls preload="none" src="audio/musica_94.mp3?v=0c7f4aae"></audio>
