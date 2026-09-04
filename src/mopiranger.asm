; ==========================================================================
; MOPI RANGER - Konami - MSX1 - cartucho RC-728 de 16 KB en la pagina 1
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS cabecera_del_cartucho: "AB" y la direccion de INIT (0x4010);
;   STATEMENT, DEVICE y TEXT a cero, y los seis bytes reservados tambien
;   0x4000..0x4010  (16 bytes)
DATA_cabecera_del_cartucho:
	defw 04241h,04010h,00000h,00000h,00000h,00000h,00000h,00000h	; 4000

; ======================================================================
; CODIGO 0x4010..0x40dc  (204 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; El INIT que declara la cabecera. Engancha la interrupcion y se queda en un `jr $`: a partir de ahi el juego entero corre desde el gancho de 0x4043.
; ----------------------------------------------------------------------
init_del_cartucho:
	di			;4010   ; sin interrupciones mientras se monta el gancho
	im 1		;4011   ; modo 1: la interrupcion salta a 0x0038, que la BIOS desvia a H.KEYI
	ld a,0c3h		;4013   ; un 0xC3 es el `jp` que se va a escribir en H.KEYI
	ld (0fd9ah),a		;4015   ; H.KEYI (0xFD9A): el gancho que la BIOS ejecuta en cada interrupcion
	ld hl,manejador_de_interrupcion		;4018   ; y detras del `jp`, la direccion del manejador
	ld (0fd9bh),hl		;401b   ; con esto H.KEYI queda como `jp 0x4043`
	ld sp,0e400h		;401e   ; la pila, justo encima del kilobyte de variables
	ld hl,0e000h		;4021   ; borra de un golpe las variables de 0xE000 a 0xE3FF
	ld de,0e001h		;4024
	ld bc,003ffh		;4027
	ld (hl),000h		;402a
	ldir		;402c
	ld a,001h		;402e   ; enciende la bandera de "montando"
	ld (0e006h),a		;4030   ; (0xE006) la mira el manejador para no reentrar
	call 00132h		;4033   ; BIOS CHGCAP - Alternates the CAPS lamp status | apaga la luz de mayusculas
	call arranca_el_vdp		;4036   ; carga los ocho registros del VDP y limpia la pantalla
	xor a			;4039   ; ya esta montado
	ld (0e006h),a		;403a
	call 0013eh		;403d   ; BIOS RDVDP - Reads VDP status register | lee el estado del VDP para desarmar la interrupcion pendiente
	ei			;4040   ; y a partir de aqui manda el gancho
L_4041:
	jr L_4041		;4041   ; el bucle vacio donde INIT se queda para siempre

; ----------------------------------------------------------------------
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; El gancho de H.KEYI, y el motor del juego entero: cada cuadro entra aqui. Lleva su propio candado para no reentrar si un cuadro tarda mas de lo que dura.
; ----------------------------------------------------------------------
manejador_de_interrupcion:
	call 0013eh		;4043   ; BIOS RDVDP - Reads VDP status register | desarma la interrupcion del VDP leyendo su estado
	di			;4046   ; nada de reentrar mientras se atiende
	call atiende_el_sonido		;4047   ; (0xE006) es el candado
	ld hl,0e006h		;404a
	bit 0,(hl)		;404d
	jr nz,L_405D		;404f
	inc (hl)			;4051
	ei			;4052
	call lee_los_mandos		;4053   ; el reparto de escenas, que es el cuerpo del cuadro
	call reparte_la_escena		;4056   ; suelta el candado
	xor a			;4059
	ld (0e006h),a		;405a
L_405D:
	call 0013eh		;405d   ; BIOS RDVDP - Reads VDP status register | y devuelve el control con las interrupciones abiertas
	or a			;4060
	di			;4061
	call m,atiende_el_sonido		;4062
	ei			;4065
	ret			;4066
L_4067:
	ld a,(despacha_por_indice)		;4067
	ld (04146h),a		;406a
	ld a,0c9h		;406d
	ld (04147h),a		;406f
	jp 00047h		;4072   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; HL += A, sin acarreo perdido. La suma de indice mas usada del cartucho.
; ----------------------------------------------------------------------
suma_a_a_hl:
	add a,l			;4075   ; el byte bajo primero
	ld l,a			;4076
	ret nc			;4077
	inc h			;4078   ; si no hubo acarreo ya esta
	ret			;4079   ; y si lo hubo, sube el byte alto

; ----------------------------------------------------------------------
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; Lo mismo pero sobre DE: DE += A. La pareja de suma_a_a_hl.
; ----------------------------------------------------------------------
suma_a_a_de:
	add a,e			;407a   ; el byte bajo de DE
	ld e,a			;407b
	ret nc			;407c   ; sin acarreo, listo
	inc d			;407d   ; con acarreo, sube D
	ret			;407e

; ----------------------------------------------------------------------
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; El reparto por indice de todo el cartucho. El `pop hl` recupera su propia direccion de retorno, que es la TABLA de punteros pegada justo detras del `call`: por eso las tablas de despacho de este juego no se cargan, se escriben en linea.
; ----------------------------------------------------------------------
despacha_por_indice:
	pop hl			;407f   ; HL = la direccion de retorno, o sea la tabla que sigue al call
L_4080:
	call lee_puntero_de_tabla		;4080   ; saca de la tabla el puntero que toca
	ex de,hl			;4083   ; al registro que sabe saltar
	jp (hl)			;4084   ; y salta: el que llamo ya no vuelve aqui

; ----------------------------------------------------------------------
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; De coordenadas de pantalla a direccion en la tabla de nombres. Baja HL tres bits (dividir por ocho, que es el tamano de la celda) y le pone 0x38 arriba, que es donde vive la tabla de nombres segun R2.
; ----------------------------------------------------------------------
celda_de_coordenadas:
	ld a,l			;4085   ; se trabaja sobre el byte bajo
	rra			;4086   ; tres desplazamientos: dividir por ocho la coordenada X
	rra			;4087
	rra			;4088
	rra			;4089
	rr h		;408a   ; y los mismos tres arrastrando H, que es la Y
	rra			;408c
	rr h		;408d
	rra			;408f
	rr h		;4090
	ld l,h			;4092   ; la fila pasa a ser el byte bajo
	and 003h		;4093   ; solo dos bits utiles: 32 celdas de ancho
	add a,038h		;4095   ; 0x3800, la tabla de nombres que declara R2
	ld h,a			;4097   ; y HL ya es la celda
	ret			;4098

; ----------------------------------------------------------------------
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; De numero de patron a su sitio en la tabla: multiplica por ocho, que son los ocho bytes de dibujo de cada celda.
; ----------------------------------------------------------------------
direccion_de_patron:
	add hl,hl			;4099   ; por dos
	add hl,hl			;409a   ; por cuatro
	add hl,hl			;409b   ; por ocho: los bytes que ocupa un patron
	ld a,h			;409c   ; y recoloca el acarreo que se ha ido a H
	rla			;409d
	rla			;409e
	rla			;409f
	and 0f8h		;40a0   ; se queda con los cinco bits altos
	ld h,l			;40a2   ; y cambia los dos bytes de sitio
	ld l,a			;40a3
	ret			;40a4

; ----------------------------------------------------------------------
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; Rellena un trozo de memoria de video llamando a la BIOS. El `ld (044dfh),de` de delante escribe en la propia ROM del cartucho, o sea que NO hace nada: la pagina 1 no admite escritura. Se deja tal cual porque el binario es lo que manda, pero es una instruccion muerta.
; ----------------------------------------------------------------------
borra_trozo_de_vram:
	ld (044dfh),de		;40a5   ; escribe en la ROM: no tiene efecto ninguno
	jp 00056h		;40a9   ; BIOS FILVRM - Fills VRAM with value | y el trabajo lo hace la BIOS

; ----------------------------------------------------------------------
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; El cuerpo de cada cuadro: mira en que estado esta el juego y reparte a la escena que toque, con la tabla de nueve punteros pegada al call.
; ----------------------------------------------------------------------
reparte_la_escena:
	ld hl,0e003h		;40ac   ; el contador de cuadros de la escena
	inc (hl)			;40af   ; que sube uno por cuadro
	ld a,(0e002h)		;40b0   ; las banderas del juego
	and 040h		;40b3   ; el bit 6 dice si hay partida en marcha
	ld c,a			;40b5
	jr z,L_40C5		;40b6   ; sin partida, se salta lo de la pausa
	ld a,(0e06ch)		;40b8   ; la bandera de pausa
	rra			;40bb
	jr c,$+50		;40bc
	ld a,(0e06dh)		;40be
	bit 5,a		;40c1   ; y el bit 5 de la otra
	jr nz,$+90		;40c3
L_40C5:
	ld a,c			;40c5   ; recupera si habia partida
	and a			;40c6
	ld hl,0444bh		;40c7   ; la rutina de fondo con partida
	jr nz,L_40CF		;40ca
	ld hl,046a9h		;40cc   ; y la de fondo sin partida, que es la de la presentacion
L_40CF:
	ld bc,(0e000h)		;40cf   ; el estado del juego, en C, y el subestado en B
	ld a,c			;40d3
	cp 003h		;40d4   ; el estado 3 no lleva rutina de fondo
	jr z,L_40D9		;40d6
	push hl			;40d8   ; los demas la apilan, para que se ejecute al volver
L_40D9:
	call despacha_por_indice		;40d9   ; y a la escena que toque

; ----------------------------------------------------------------------
; DATOS tabla_de_escenas: 9 entradas, indexada por (0xE000); pegada detras del
;   call de 0x40d9
;   0x40dc..0x40ee  (18 bytes)
DATA_tabla_de_escenas:
	defw 04132h,04169h,04196h,041bdh,041c5h,04224h,04250h,04289h	; 40dc
	defw 042aah	; 40ec  -> escena_de_recuento

; ======================================================================
; CODIGO 0x40ee..0x435a  (620 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; La escena que atiende la pausa: si sigue pausado parpadea el rotulo PAUSE encendiendolo y apagandolo con el bit 3 del contador de cuadros, y si se ha soltado devuelve el marcador a su sitio.
; ----------------------------------------------------------------------
escena_de_pausa:
	ld a,(0e06dh)		;40ee   ; la bandera de pausa
	bit 5,a		;40f1
	jr nz,guarda_y_quita_la_pausa		;40f3   ; si se ha soltado, hay que restaurar
	ld hl,05d68h		;40f5   ; el rotulo PAUSE
	ld a,(0e003h)		;40f8   ; el contador de cuadros
	bit 3,a		;40fb   ; el bit 3 va cambiando cada ocho cuadros
	jp nz,escribe_rotulo		;40fd   ; ocho cuadros escrito
	jp borra_rotulo		;4100   ; y ocho borrado: asi parpadea
guarda_y_quita_la_pausa:
	xor a			;4103   ; baja la bandera de pausa
	ld (0e06ch),a		;4104
	ld hl,0e250h		;4107   ; el bloque de estado que la pausa habia tapado
	ld de,0e018h		;410a   ; su copia de seguridad
	ld b,02ah		;410d   ; son 42 bytes
mueve_y_borra:
	ld a,(hl)			;410f   ; byte a byte
	ld (de),a			;4110
	ld (hl),000h		;4111   ; dejando a cero lo que se lleva
	inc hl			;4113
	inc de			;4114
	djnz mueve_y_borra		;4115   ; los 42
	ld hl,05d68h		;4117   ; y por ultimo quita el rotulo PAUSE
	jp borra_rotulo		;411a

; ----------------------------------------------------------------------
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; Al entrar en pausa devuelve el bloque de 42 bytes a su sitio y levanta la bandera.
; ----------------------------------------------------------------------
entra_en_pausa:
	ld hl,0e018h		;411d   ; la copia
	ld de,0e250h		;4120   ; al bloque de estado
	ld bc,0002ah		;4123   ; los 42 bytes
	ldir		;4126
	ld a,001h		;4128   ; y levanta la bandera de pausa
	ld (0e06ch),a		;412a
	ld a,018h		;412d   ; el sonido que suena al pausar
	jp suena		;412f

; ----------------------------------------------------------------------
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; La primera escena: monta la pantalla de titulo. Los subestados van al reves, del mas alto al mas bajo, gastandose con los djnz de la cabecera.
; ----------------------------------------------------------------------
escena_de_arranque:
	djnz espera_del_arranque		;4132   ; subestado 1: pinta el rotulo
	ld a,(0e003h)		;4134   ; el contador de cuadros
	rra			;4137   ; solo uno de cada dos
	ret nc			;4138
	call avanza_la_cortinilla		;4139   ; mira si hay que esperar
	ret nz			;413c
	ld de,05d1eh		;413d   ; el bloque grafico del titulo
	call L_4517		;4140   ; y a la memoria de video
	xor a			;4143
	jr espera_cuadros		;4144
espera_del_arranque:
	djnz comprueba_el_arranque		;4146   ; subestado 2
	ld hl,0e004h		;4148   ; la cuenta atras
	dec (hl)			;414b   ; hasta que llegue a cero no se sigue
	ret nz			;414c
	call limpia_para_la_escena		;414d
	jr pasa_al_subestado_siguiente		;4150
comprueba_el_arranque:
	djnz monta_la_pantalla_de_titulo		;4152   ; subestado 3
	call monta_la_pantalla_de_titulo_grande		;4154   ; con acarreo se queda esperando
	ret c			;4157
	jp pasa_a_la_escena_siguiente		;4158

; ----------------------------------------------------------------------
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; El subestado mas alto, el que se ejecuta primero: deja los registros del VDP y los graficos cargados.
; ----------------------------------------------------------------------
monta_la_pantalla_de_titulo:
	call borra_la_pantalla		;415b
	call carga_registros_del_vdp		;415e   ; los ocho registros del VDP
	call L_5DB8		;4161   ; los patrones y colores de los tres tercios
	call prepara_la_cortinilla		;4164   ; y el resto de la pantalla
	jr pasa_al_subestado_siguiente		;4167

; ----------------------------------------------------------------------
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; La escena de la demostracion, la que corre sola cuando nadie juega.
; ----------------------------------------------------------------------
escena_de_demostracion:
	djnz espera_de_la_demostracion		;4169   ; subestado 1
	call avanza_la_coreografia		;416b   ; avanza la demostracion un paso
	ld hl,0e015h		;416e   ; la bandera de "se acabo"
	ld a,(hl)			;4171
	rra			;4172
	ret nc			;4173   ; si no se ha acabado, sigue
	xor a			;4174   ; la baja
	ld (hl),a			;4175
	ld a,07eh		;4176   ; y pide el cambio de escena
	jr espera_cuadros		;4178
espera_de_la_demostracion:
	djnz arranca_la_demostracion		;417a   ; subestado 2
	ld hl,0e004h		;417c   ; la cuenta atras
	dec (hl)			;417f
	ret nz			;4180   ; hasta cero no se sigue
	call L_50FA		;4181
	jr espera_treinta_y_dos		;4184
arranca_la_demostracion:
	call esconde_los_sprites		;4186   ; elige por donde empieza
	ld h,a			;4189   ; el mismo valor en las dos mitades
	ld l,a			;418a
	ld (0e016h),hl		;418b   ; el paso de la demostracion
	ld (0e015h),a		;418e   ; y su bandera
	call L_50FA		;4191
	jr pasa_al_subestado_siguiente		;4194

; ----------------------------------------------------------------------
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; La escena de jugar: mueve todo lo que se mueve y mira si la partida ha terminado.
; ----------------------------------------------------------------------
escena_de_juego:
	djnz arranca_el_juego		;4196   ; subestado 1
	ld hl,0e005h		;4198   ; el contador que da la vuelta cada 16
	inc (hl)			;419b
	ld a,(hl)			;419c
	and 00fh		;419d   ; y de ahi no pasa
	ld (hl),a			;419f
	call mueve_todo		;41a0   ; mueve enemigos y protagonista
	ld a,(0e055h)		;41a3   ; la bandera de fin de partida
	and a			;41a6
	ret nz			;41a7   ; si no esta puesta, sigue jugando
termina_la_partida:
	xor a			;41a8   ; al estado 0
	jp espera_treinta_y_dos_cuadros		;41a9   ; con veinte cuadros de espera
arranca_el_juego:
	call borra_columna_de_entrada		;41ac   ; espera a que acabe la entrada
	ret p			;41af   ; si aun no, se sale
	call arranca_la_partida		;41b0   ; monta la zona
	ld a,020h		;41b3   ; y 32 cuadros de margen

; ----------------------------------------------------------------------
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; Deja en la cuenta atras los cuadros que la escena quiere esperar y pasa al subestado siguiente.
; ----------------------------------------------------------------------
espera_cuadros:
	ld (0e004h),a		;41b5   ; los cuadros a esperar
pasa_al_subestado_siguiente:
	ld hl,0e001h		;41b8   ; el subestado
	inc (hl)			;41bb   ; uno mas
	ret			;41bc
L_41BD:
	call L_50FA		;41bd
	call prepara_partida_nueva		;41c0
	jr espera_treinta_y_dos		;41c3

; ----------------------------------------------------------------------
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; Anuncia la zona nueva. Escribe el rotulo ZONE y, si la zona no esta en la lista de las que llevan razzon grande, avisa con NO BIG RAZZON.
; ----------------------------------------------------------------------
escena_de_empezar_zona:
	djnz escena_de_montar_zona		;41c5   ; subestado 1
	ld hl,05d09h		;41c7   ; el rotulo ZONE
	call pinta_el_rotulo_de_zona		;41ca
	ld a,(0e053h)		;41cd   ; la zona actual
	ld b,00eh		;41d0   ; catorce vueltas, aunque la lista tenga trece
	ld hl,0609eh		;41d2   ; la lista de zonas con razzon grande
busca_la_zona_en_la_lista:
	cp (hl)			;41d5   ; la compara con la de la lista
	jr z,suena_el_aviso_de_zona		;41d6   ; si aparece, no hay aviso que dar
	inc hl			;41d8   ; el siguiente de la lista
	djnz busca_la_zona_en_la_lista		;41d9   ; hasta agotar las catorce
	ld hl,05d70h		;41db   ; no esta: el aviso de que no hay razzon grande
	call escribe_rotulo		;41de
suena_el_aviso_de_zona:
	ld a,08fh		;41e1   ; el sonido de zona nueva
	call suena		;41e3
	ld a,094h		;41e6   ; y 148 cuadros de espera
	jr espera_cuadros		;41e8
escena_de_montar_zona:
	djnz escena_de_perder_vida		;41ea   ; subestado 2
	ld hl,0e004h		;41ec   ; la cuenta atras
	dec (hl)			;41ef
	ret nz			;41f0   ; hasta cero no se sigue
	call monta_la_zona		;41f1   ; descomprime el mapa y lo pinta
	ld hl,0e055h		;41f4   ; la bandera de fin de partida
	ld (hl),001h		;41f7   ; puesta mientras se monta
	ld a,090h		;41f9   ; y 144 cuadros
	jr L_41FF		;41fb
espera_treinta_y_dos:
	ld a,020h		;41fd   ; los 32 cuadros de siempre
L_41FF:
	ld (0e004h),a		;41ff
pasa_a_la_escena_siguiente:
	ld hl,0e000h		;4202   ; el estado del juego
	inc (hl)			;4205   ; uno mas
reinicia_el_subestado:
	xor a			;4206   ; el subestado vuelve a cero al cambiar de escena
	ld (0e001h),a		;4207
	ret			;420a

; ----------------------------------------------------------------------
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; Descuenta una vida y vuelve a montar la zona.
; ----------------------------------------------------------------------
escena_de_perder_vida:
	call borra_columna_de_entrada		;420b   ; espera a que acabe la entrada
	ret p			;420e
	ld hl,0e050h		;420f   ; las vidas
	dec (hl)			;4212   ; una menos
	inc hl			;4213
	ld a,(hl)			;4214   ; y el marcador que va al lado
	sub 001h		;4215   ; se descuenta en BCD
	daa			;4217
	ld (hl),a			;4218
	ld hl,03000h		;4219   ; el trozo de memoria de video donde se repinta
	ld (0e058h),hl		;421c
	call pinta_el_marco		;421f   ; y a repintar
	jr pasa_al_subestado_siguiente		;4222
escena_de_fin_de_zona:
	djnz espera_del_fin_de_zona		;4224   ; subestado 1
	call mueve_todo		;4226   ; sigue moviendo lo que quede
	ld a,(0e00bh)		;4229   ; la bandera de bonus
	or a			;422c
	jr nz,va_al_estado_ocho		;422d   ; con bonus, otro camino
	ld a,(0e055h)		;422f   ; la de fin de partida
	or a			;4232
	ret nz			;4233   ; si esta puesta, se sale
	jr espera_treinta_y_dos		;4234
va_al_estado_ocho:
	ld a,008h		;4236   ; estado 8
	ld c,030h		;4238   ; con 48 cuadros
	jr fija_estado_y_espera		;423a
espera_del_fin_de_zona:
	ld hl,0e004h		;423c   ; la cuenta atras
	dec (hl)			;423f
	ret nz			;4240   ; hasta cero no se sigue
	call es_zona_de_bonus		;4241   ; mira si quedan vidas
	ld a,08ah		;4244   ; el sonido de zona superada
	jr z,L_424A		;4246
	ld a,008h		;4248   ; o el de perder
L_424A:
	call suena		;424a
	jp pasa_al_subestado_siguiente		;424d

; ----------------------------------------------------------------------
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; Decide si la partida sigue o se acaba: con vidas, a repetir zona; sin vidas, GAME OVER.
; ----------------------------------------------------------------------
escena_de_perder:
	call es_zona_de_bonus		;4250   ; quedan vidas?
	jr z,marca_fin_de_partida		;4253   ; si no, se acabo
	ld a,(0e050h)		;4255   ; las vidas
	or a			;4258
	jr z,pinta_el_game_over		;4259   ; a cero, fin de partida
vuelve_a_la_zona:
	ld a,004h		;425b   ; estado 4
espera_treinta_y_dos_cuadros:
	ld c,020h		;425d   ; 32 cuadros
fija_estado_y_espera:
	ld (0e000h),a		;425f   ; el estado nuevo
	ld a,c			;4262
	ld (0e004h),a		;4263   ; y su espera
	jr reinicia_el_subestado		;4266
pinta_el_game_over:
	call borra_columna_de_entrada		;4268   ; espera a que acabe la entrada
	ret p			;426b
	ld a,092h		;426c   ; el sonido de fin de partida
	call suena		;426e
	ld hl,05cfch		;4271   ; el rotulo GAME OVER
	call escribe_rotulo		;4274
	ld a,006h		;4277   ; estado 6
	ld (0e000h),a		;4279
	xor a			;427c   ; sin espera
	jr L_41FF		;427d
marca_fin_de_partida:
	ld a,001h		;427f   ; levanta la bandera de fin de partida
	ld (0e055h),a		;4281
	ld (0e00bh),a		;4284   ; y la de bonus
	jr va_al_estado_ocho		;4287
escena_de_espera:
	call atiende_el_menu		;4289   ; atiende el mando
	ld a,(0e000h)		;428c   ; el estado
	cp 007h		;428f   ; el 7 espera con cuenta atras
	ld de,0e002h		;4291   ; las banderas del juego
	jr z,espera_con_cuenta_atras		;4294
	ld a,(de)			;4296   ; baja el bit 6: ya no hay partida
	and 0bfh		;4297
	ld (de),a			;4299
	pop de			;429a   ; se come la rutina de fondo que apilo el reparto
	jp L_50FA		;429b
espera_con_cuenta_atras:
	ld hl,0e004h		;429e   ; la cuenta atras
	dec (hl)			;42a1
	ret nz			;42a2   ; hasta cero no se sigue
	ld a,(de)			;42a3   ; baja el bit 6 de las banderas
	and 0bfh		;42a4
	ld (de),a			;42a6
	jp termina_la_partida		;42a7   ; y termina la partida

; ----------------------------------------------------------------------
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; El recuento de fin de zona: convierte en puntos lo que queda de tiempo y de bonus, de diez en diez y con su sonido, hasta que los dos contadores llegan a cero.
; ----------------------------------------------------------------------
escena_de_recuento:
	ld hl,0e004h		;42aa   ; la cuenta atras entre paso y paso
	dec (hl)			;42ad   ; uno menos
	ld a,(hl)			;42ae
	cp 0ffh		;42af   ; hasta que da la vuelta no toca contar
	ret nz			;42b1
	inc (hl)			;42b2   ; y la deja como estaba
	ld a,(0e069h)		;42b3   ; la bandera del bonus pendiente
	and a			;42b6
	jr z,recuenta_el_tiempo		;42b7   ; sin bonus, va a por el tiempo
	ld a,007h		;42b9   ; el sonido de contar
	call suena		;42bb
	ld de,00010h		;42be   ; diez de golpe
	ld hl,0e06ah		;42c1   ; el bonus pendiente
	call resta_bcd_de_dos_bytes		;42c4   ; descontados del contador
	call pinta_el_bonus		;42c7   ; y repinta la cifra
	ld de,00100h		;42ca   ; cien puntos por cada diez
	call suma_al_marcador		;42cd   ; al marcador
	ld hl,(0e06ah)		;42d0   ; el bonus que queda
	ld a,l			;42d3
	or h			;42d4
	ret nz			;42d5   ; si queda, sigue contando
	ld (0e069h),a		;42d6   ; y a cero, baja la bandera
	ret			;42d9

; ----------------------------------------------------------------------
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; Lo mismo con el tiempo que sobra, pero a diez puntos por unidad en vez de cien.
; ----------------------------------------------------------------------
recuenta_el_tiempo:
	ld hl,(0e058h)		;42da   ; el tiempo que queda
	ld a,l			;42dd
	or h			;42de
	jr z,premia_el_fin_de_zona		;42df   ; si no queda, se acabo el recuento
	ld a,007h		;42e1   ; el sonido de contar
	call suena		;42e3
	ld de,00010h		;42e6   ; diez de golpe
	ld hl,0e058h		;42e9
	call resta_bcd_de_dos_bytes		;42ec   ; descontados
	call pinta_el_tiempo		;42ef   ; y repinta la cifra
	ld de,00010h		;42f2   ; diez puntos por cada diez de tiempo
	call suma_al_marcador		;42f5   ; al marcador
	ld hl,(0e058h)		;42f8
	ld a,l			;42fb   ; si queda tiempo, otra vuelta
	or h			;42fc
	ret nz			;42fd
	ld a,030h		;42fe   ; y al acabar, 48 cuadros de pausa
	ld (0e004h),a		;4300
	ret			;4303

; ----------------------------------------------------------------------
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; Lo que se lleva el jugador al superar una zona: dos vidas mas, la zona siguiente y, si no se ha muerto, una marca mas en el contador de 0xE017.
; ----------------------------------------------------------------------
premia_el_fin_de_zona:
	ld hl,0e050h		;4304   ; las vidas
	inc (hl)			;4307   ; dos mas
	inc (hl)			;4308
	inc hl			;4309
	ld a,(hl)			;430a   ; el marcador de vidas que se ve
	add a,002h		;430b   ; tambien dos, en BCD
	daa			;430d
	ld (hl),a			;430e
	inc hl			;430f
	ld a,(hl)			;4310   ; la zona
	add a,001h		;4311   ; la siguiente
	daa			;4313
	ld (hl),a			;4314
	cp 051h		;4315   ; pasada la 50 vuelve a empezar
	jr nz,L_4320		;4317
	ld (hl),001h		;4319   ; por la 1
	inc hl			;431b
	ld (hl),000h		;431c   ; y el contador de vueltas a cero
	jr apunta_zona_sin_morir		;431e
L_4320:
	inc hl			;4320
	inc (hl)			;4321   ; si no ha dado la vuelta, uno mas
apunta_zona_sin_morir:
	ld a,(0e33fh)		;4322   ; la bandera de haber muerto
	and a			;4325
	jr nz,vuelve_a_jugar		;4326   ; si murio, no cuenta
	ld hl,0e017h		;4328   ; el contador de zonas limpias
	ld a,(hl)			;432b
	cp 010h		;432c   ; tope en 16
	jr z,vuelve_a_jugar		;432e
	add a,001h		;4330   ; y uno mas, en BCD
	daa			;4332
	ld (hl),a			;4333
vuelve_a_jugar:
	xor a			;4334   ; baja la bandera de bonus
	ld (0e00bh),a		;4335
	jp vuelve_a_la_zona		;4338   ; y otra vez a la zona

; ----------------------------------------------------------------------
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; Deja el bloque de estado en blanco y le copia los valores de arranque: vidas, marcador y la posicion inicial.
; ----------------------------------------------------------------------
prepara_partida_nueva:
	ld hl,0e04dh		;433b   ; el bloque de estado
	ld bc,00343h		;433e   ; 0x343 bytes
	ld d,h			;4341   ; el truco de siempre: DE = HL + 1 y un ldir que arrastra el cero
	ld e,l			;4342
	inc e			;4343
	ld (hl),000h		;4344   ; el cero que se propaga
	ldir		;4346
	ld hl,0435ah		;4348   ; los seis valores de arranque
	ld de,0e050h		;434b   ; a las vidas y el marcador
	ld bc,00006h		;434e   ; seis bytes
	ldir		;4351
	ld hl,00300h		;4353   ; y la posicion de partida
	ld (0e016h),hl		;4356
	ret			;4359

; ----------------------------------------------------------------------
; DATOS tabla_435a: 6 bytes; la carga 0x4348
;   0x435a..0x4360  (6 bytes)
DATA_tabla_435a:
	defb 003h,003h,001h,000h,001h,002h	; 435a

; ======================================================================
; CODIGO 0x4360..0x4575  (533 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; Monta una partida desde cero: contadores a su sitio, la zona pintada y el bloque comprimido de 0x5d82 descomprimido en 0xE342.
; ----------------------------------------------------------------------
arranca_la_partida:
	xor a			;4360   ; el contador de 0xE00C
	ld (0e00ch),a		;4361
	ld (0e005h),a		;4364   ; y el que da la vuelta cada 16
	inc a			;4367   ; levanta la bandera de fin de partida mientras monta
	ld (0e055h),a		;4368
	ld hl,00809h		;436b   ; la posicion de partida, 8 y 9
	ld (0e052h),hl		;436e
	ld hl,03000h		;4371   ; el bonus de tiempo, 0x3000
	ld (0e058h),hl		;4374
	call pinta_el_marco		;4377   ; pinta el marco
	call monta_la_zona		;437a   ; monta la zona
	ld hl,05d82h		;437d   ; el bloque comprimido
	ld de,0e342h		;4380   ; a su buffer
	jp descomprime_rle		;4383   ; y lo descomprime

; ----------------------------------------------------------------------
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; La cortinilla de entrada: cada cuadro borra una columna entera de la pantalla, veintidos celdas de alto, hasta que se agota el contador. Devuelve con el signo puesto mientras quede columna, que es lo que miran las escenas para esperar.
; ----------------------------------------------------------------------
borra_columna_de_entrada:
	ld hl,0e003h		;4386   ; el contador de cuadros de la escena
	dec (hl)			;4389   ; uno menos
	inc hl			;438a
	dec (hl)			;438b   ; y el de columnas
	ret m			;438c   ; mientras queden, se sale con el signo puesto
	ld a,(hl)			;438d   ; la columna que toca
	ld h,038h		;438e   ; la tabla de nombres esta en 0x3800
	xor 05fh		;4390   ; el 0x5F la va recorriendo del reves
	ld l,a			;4392
	ld b,016h		;4393   ; veintidos celdas de alto
	xor a			;4395   ; y se borran con el patron 0
borra_celda_de_la_columna:
	call 0004dh		;4396   ; BIOS WRTVRM - Writes data in VRAM | la celda, a cero
	ld de,00020h		;4399   ; una fila entera: 32 celdas
	add hl,de			;439c
	djnz borra_celda_de_la_columna		;439d   ; hasta las veintidos

; ----------------------------------------------------------------------
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; Esconde los treinta y dos sprites de golpe poniendo 0xE0 en la coordenada Y de cada uno, que es el valor con el que el VDP los deja fuera de pantalla. Los atributos van de cuatro en cuatro, por eso los cuatro `inc hl`.
; ----------------------------------------------------------------------
esconde_los_sprites:
	ld hl,0e0b0h		;439f   ; el buffer de atributos de sprite
	ld c,0e0h		;43a2   ; 0xE0: la Y que esconde un sprite
	ld b,020h		;43a4   ; los treinta y dos
esconde_un_sprite:
	ld (hl),c			;43a6   ; la Y del sprite
	inc hl			;43a7   ; y salta los otros tres bytes del atributo
	inc hl			;43a8
	inc hl			;43a9
	inc hl			;43aa
	djnz esconde_un_sprite		;43ab   ; hasta los treinta y dos
	call L_5FD8		;43ad   ; y los vuelca a la memoria de video
	xor a			;43b0
	ret			;43b1

; ----------------------------------------------------------------------
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; Suma DE al marcador, en BCD y con los `daa` de rigor. El marcador son tres bytes en 0xE04D, o sea seis cifras, y al desbordar se queda clavado en 999999. Ojo al leer el listado: los `ld de,07000h` que llaman aqui son SIETE MIL PUNTOS, no una direccion de la ROM.
; ----------------------------------------------------------------------
suma_al_marcador:
	ld a,(0e002h)		;43b2   ; las banderas del juego
	add a,a			;43b5
	ret p			;43b6   ; sin partida en marcha no se suma nada
	ld hl,0e04dh		;43b7   ; el marcador, tres bytes en BCD
	ld a,(hl)			;43ba
	add a,e			;43bb   ; las dos cifras de abajo
	daa			;43bc   ; que la suma sea decimal
	ld (hl),a			;43bd
	ld e,a			;43be
	inc l			;43bf
	ld a,(hl)			;43c0   ; las dos del medio, con el acarreo
	adc a,d			;43c1
	daa			;43c2
	ld (hl),a			;43c3
	ld d,a			;43c4
	inc hl			;43c5   ; y las dos de arriba
	jr nc,compara_con_el_record		;43c6   ; sin acarreo, ya esta
	ld a,(hl)			;43c8
	add a,001h		;43c9   ; la cifra mas alta
	daa			;43cb
	ld (hl),a			;43cc
	jr nc,compara_con_el_record		;43cd   ; si tampoco desborda, listo
	ld bc,09999h		;43cf   ; y si desborda, se clava en 999999
	ld (0e047h),bc		;43d2   ; el marcador
	ld (0e048h),bc		;43d6   ; y el record
	jr pinta_el_record		;43da

; ----------------------------------------------------------------------
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; Mira si el marcador ha pasado al record y lo actualiza. Compara primero la cifra alta y solo si empatan baja a las cuatro de abajo.
; ----------------------------------------------------------------------
compara_con_el_record:
	ld a,(0e049h)		;43dc   ; la cifra alta del record
	ld b,(hl)			;43df   ; y la del marcador
	sub b			;43e0
	jr c,guarda_el_record		;43e1   ; si el marcador es mayor, hay record
	jr nz,pinta_el_marcador		;43e3   ; si no empatan, no lo hay
	ld hl,(0e047h)		;43e5   ; empatan: hay que mirar las cuatro cifras de abajo
	sbc hl,de		;43e8   ; y si el record es menor, tambien hay record
	jr nc,pinta_el_marcador		;43ea
guarda_el_record:
	ld (0e047h),de		;43ec   ; las cuatro cifras de abajo
	ld a,b			;43f0   ; y la alta
	ld (0e049h),a		;43f1
	jr pinta_el_record		;43f4

; ----------------------------------------------------------------------
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; Deja la pantalla de juego con todo lo fijo: los rotulos del marcador y las cuatro cifras que lo acompanan.
; ----------------------------------------------------------------------
pinta_el_marco:
	ld hl,05c76h		;43f6   ; los rotulos HI y ZONE
	call escribe_rotulo		;43f9
	call pinta_las_vidas		;43fc   ; el marcador de vidas
	call pinta_el_numero_de_zona		;43ff   ; el numero de zona
	call pinta_el_tiempo		;4402   ; el tiempo
pinta_el_record:
	ld de,0e049h		;4405   ; el record, tres bytes
	ld hl,03810h		;4408   ; su sitio en la pantalla
	call pinta_seis_cifras		;440b
pinta_el_marcador:
	ld hl,03806h		;440e   ; el sitio del marcador
	ld de,0e04fh		;4411   ; y sus tres bytes en BCD
pinta_seis_cifras:
	ld b,003h		;4414   ; tres bytes son seis cifras
	jr pinta_cifras_bcd		;4416
pinta_el_tiempo:
	ld hl,03828h		;4418   ; el sitio del tiempo
	ld de,0e059h		;441b   ; y su contador
	jr pinta_cuatro_cifras		;441e
pinta_el_bonus:
	ld hl,039ach		;4420   ; el sitio del bonus
	ld de,0e06bh		;4423   ; y su contador
pinta_cuatro_cifras:
	ld b,002h		;4426   ; dos bytes son cuatro cifras
	jr pinta_cifras_bcd		;4428
pinta_el_numero_de_zona:
	ld hl,0383ch		;442a   ; el sitio del numero de zona
	ld de,0e052h		;442d   ; y la zona, en BCD
pinta_dos_cifras:
	ld b,001h		;4430   ; un byte son dos cifras

; ----------------------------------------------------------------------
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; Escribe B bytes en BCD como cifras en la pantalla, dos por byte y de mayor a menor. Al medio byte le suma 0x10, que es donde esta el patron del '0': la misma cuenta que la fuente de los rotulos, indice = ASCII menos 0x20.
; ----------------------------------------------------------------------
pinta_cifras_bcd:
	ld a,(de)			;4432   ; el byte en BCD
	rra			;4433   ; se queda con el medio byte de arriba
	rra			;4434
	rra			;4435
	rra			;4436
	and 00fh		;4437   ; solo cuatro bits
	add a,010h		;4439   ; y 0x10 es el patron del '0'
	call 0004dh		;443b   ; BIOS WRTVRM - Writes data in VRAM | la cifra, a la pantalla
	inc hl			;443e   ; la celda de al lado
	ld a,(de)			;443f   ; el mismo byte otra vez
	and 00fh		;4440   ; ahora el medio byte de abajo
	add a,010h		;4442   ; tambien desde el '0'
	call 0004dh		;4444   ; BIOS WRTVRM - Writes data in VRAM | y su cifra
	dec de			;4447   ; los bytes se recorren hacia atras: el mas alto esta al final
	inc hl			;4448
	djnz pinta_cifras_bcd		;4449   ; hasta acabar los B
	ret			;444b
pinta_las_vidas:
	ld hl,0381ch		;444c   ; el sitio de las vidas
	ld de,0e051h		;444f   ; y su contador en BCD
	jr pinta_dos_cifras		;4452

; ----------------------------------------------------------------------
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; Enciende y apaga el rotulo BONUS del marcador, cada 32 cuadros, cuando hay bonus que anunciar.
; ----------------------------------------------------------------------
pinta_el_aviso_de_bonus:
	ld a,(0e067h)		;4454   ; las banderas de aviso
	rra			;4457
	jr c,L_445D		;4458   ; con el bit 0, se anuncia
	rra			;445a
	jr c,apaga_el_aviso		;445b   ; con el bit 1, tambien
L_445D:
	ld a,h			;445d   ; si no queda nada, no hay aviso
	or l			;445e
	jr z,apaga_el_aviso		;445f
	ld a,(0e003h)		;4461   ; el contador de cuadros
	and 020h		;4464   ; el bit 5: cambia cada 32 cuadros
	ld hl,05c93h		;4466   ; el rotulo BONUS
	jr nz,L_446E		;4469   ; encendido media vuelta
apaga_el_aviso:
	ld hl,05c9ch		;446b   ; y los cinco patrones en blanco la otra media
L_446E:
	jp escribe_rotulo		;446e

; ----------------------------------------------------------------------
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; Escribe ZONE y el numero, salvo en las zonas de bonus, que llevan BONUS STAGE en su lugar.
; ----------------------------------------------------------------------
pinta_el_rotulo_de_zona:
	call es_zona_de_bonus		;4471   ; mira si esta zona es de bonus
	jr nz,pinta_zona_y_numero		;4474   ; si no lo es, el rotulo normal
	ld hl,05d10h		;4476   ; y si lo es, BONUS STAGE
	jr L_446E		;4479
pinta_zona_y_numero:
	call escribe_rotulo		;447b   ; el rotulo ZONE
	ld de,0e052h		;447e   ; el numero de zona
	ld hl,03932h		;4481   ; y su sitio en la pantalla
	jr pinta_dos_cifras		;4484
L_4486:
	call limpia_para_la_escena		;4486

; ----------------------------------------------------------------------
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; Monta el rotulo grande del titulo: rellena un bloque de patrones, escribe tres filas de veinte celdas con indices consecutivos -o sea un dibujo grande hecho de celdas seguidas- y remata con dos filas de relleno.
; ----------------------------------------------------------------------
monta_la_pantalla_de_titulo_grande:
	ld hl,0e043h		;4489   ; el contador que alterna el color
	inc (hl)			;448c   ; uno mas cada vez
	ld a,(hl)			;448d
	rra			;448e   ; su bit 0 elige entre los dos colores
	ld a,0d0h		;448f   ; un color
	jr c,L_4495		;4491
	ld a,0c0h		;4493   ; y el otro
L_4495:
	ld hl,00600h		;4495   ; el bloque de patrones del rotulo
	ld bc,001e0h		;4498   ; 480 bytes, o sea sesenta celdas
	call 00056h		;449b   ; BIOS FILVRM - Fills VRAM with value | pintados del color que toque
	ld d,0c0h		;449e   ; el primer patron del rotulo
	ld c,003h		;44a0   ; tres filas
	ld hl,03887h		;44a2   ; la esquina donde empieza
escribe_fila_del_rotulo:
	push hl			;44a5   ; guarda el principio de la fila
	ld b,014h		;44a6   ; veinte celdas de ancho
escribe_celda_del_rotulo:
	ld a,d			;44a8   ; el patron que toca
	call 0004dh		;44a9   ; BIOS WRTVRM - Writes data in VRAM | a la pantalla
	inc hl			;44ac   ; la celda siguiente
	inc d			;44ad   ; y el patron siguiente: van seguidos
	djnz escribe_celda_del_rotulo		;44ae   ; las veinte
	pop hl			;44b0   ; recupera el principio de la fila
	ld a,020h		;44b1   ; y baja una fila entera
	call suma_a_a_hl		;44b3
	dec c			;44b6   ; hasta las tres
	jr nz,escribe_fila_del_rotulo		;44b7
remata_el_rotulo:
	ld hl,03ac0h		;44b9   ; la fila de abajo del todo
	ld bc,00020h		;44bc   ; treinta y dos celdas
	push bc			;44bf
	ld a,0beh		;44c0   ; con un patron
	call 00056h		;44c2   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03ae0h		;44c5   ; y la ultima fila
	pop bc			;44c8
	inc a			;44c9   ; con el siguiente
	call 00056h		;44ca   ; BIOS FILVRM - Fills VRAM with value
	ld hl,05ca4h		;44cd   ; y encima, el texto de la presentacion
	call escribe_rotulo		;44d0
	xor a			;44d3
	ret			;44d4
limpia_para_la_escena:
	xor a			;44d5   ; la bandera de 0xE00D
	ld (0e00dh),a		;44d6
	call borra_la_pantalla		;44d9   ; borra la pantalla
	ld b,0e0h		;44dc   ; y prepara la cortinilla de 224 columnas
	jp L_45FF		;44de

; ----------------------------------------------------------------------
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; HL -= A, la pareja de suma_a_a_hl.
; ----------------------------------------------------------------------
resta_a_a_hl:
	ld b,a			;44e1
	ld a,l			;44e2   ; el byte bajo primero
	sub b			;44e3
	ld l,a			;44e4
	ret nc			;44e5   ; sin acarreo ya esta
	dec h			;44e6   ; y con acarreo baja el alto
	ret			;44e7

; ----------------------------------------------------------------------
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; Quita cuatro a las dos mitades de HL a la vez: es el ajuste de una coordenada de sprite de 16x16 a su centro.
; ----------------------------------------------------------------------
encoge_cuatro:
	ld a,l			;44e8   ; cuatro a la coordenada de abajo
	sub 004h		;44e9
	ld l,a			;44eb
	ld a,h			;44ec   ; y cuatro a la de arriba
	sub 004h		;44ed
	ld h,a			;44ef
	ret			;44f0

; ----------------------------------------------------------------------
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; Resta E a un contador de dos bytes en BCD, con el prestamo bien llevado. Es lo que gasta el tiempo y el bonus durante el recuento.
; ----------------------------------------------------------------------
resta_bcd_de_dos_bytes:
	ld a,(hl)			;44f1   ; la cifra baja
	sub e			;44f2
	daa			;44f3   ; en decimal
	ld (hl),a			;44f4
	ret nc			;44f5   ; sin prestamo, ya esta
	inc hl			;44f6   ; y con prestamo, uno menos arriba
	ld a,(hl)			;44f7
	sub 001h		;44f8
	daa			;44fa
	ld (hl),a			;44fb
	ret			;44fc

; ----------------------------------------------------------------------
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; Dice si la zona actual es de bonus: devuelve con Z si el numero de zona acaba en 0 o en 5, o sea una de cada cinco. Es la misma regla de cinco que reparte tabla_de_mapas.
; ----------------------------------------------------------------------
es_zona_de_bonus:
	ld a,(0e052h)		;44fd   ; el numero de zona, en BCD
	and 00fh		;4500   ; solo la cifra de las unidades
	ret z			;4502   ; acaba en 0: es de bonus
	cp 005h		;4503   ; y acaba en 5: tambien
	ret			;4505

; ----------------------------------------------------------------------
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; Esconde los sprites y borra la tabla de nombres entera, las 768 celdas.
; ----------------------------------------------------------------------
borra_la_pantalla:
	call esconde_los_sprites		;4506
	ld hl,03800h		;4509   ; la tabla de nombres
	ld bc,00300h		;450c   ; sus 768 celdas
	xor a			;450f   ; al patron 0
	jp 00056h		;4510   ; BIOS FILVRM - Fills VRAM with value

; ----------------------------------------------------------------------
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; Un salto a LDIRVM de la BIOS con los registros ya cambiados: copia BC bytes de HL a la memoria de video en DE.
; ----------------------------------------------------------------------
vuelca_a_vram:
	ex de,hl			;4513   ; la BIOS los quiere al reves
	jp 0005ch		;4514   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_4517:
	ld c,000h		;4517

; ----------------------------------------------------------------------
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; Lee del bloque la palabra con el destino en VRAM y sigue descomprimiendo alli. Es lo que permite que un bloque se reparta por varias zonas de la memoria de video.
; ----------------------------------------------------------------------
abre_destino_de_vram:
	ex de,hl			;4519
	ld e,(hl)			;451a   ; byte bajo del destino
	inc hl			;451b
	ld d,(hl)			;451c   ; y byte alto
	ex de,hl			;451d
	inc de			;451e   ; DE vuelve a apuntar a los datos

; ----------------------------------------------------------------------
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; El bucle que escribe al puerto del VDP. Mismo formato que descomprime_rle y dos controles de mas: 0x80 abre otro destino y 0x00 cierra.
; ----------------------------------------------------------------------
vuelca_rle_al_vdp:
	call prepara_escritura_de_vram		;451f   ; prepara el VDP para escribir desde HL
L_4522:
	ld a,(de)			;4522   ; el byte de control
	and 07fh		;4523   ; los siete bits de la cuenta
	ld b,a			;4525
	ld a,(de)			;4526   ; y el control entero otra vez
	inc de			;4527
	jr z,L_4543		;4528   ; cuenta cero: es uno de los dos controles
	cp b			;452a   ; si A sigue valiendo la cuenta, el bit 7 estaba a 0: repeticion
	jr z,L_4537		;452b
L_452D:
	ld a,(de)			;452d   ; literal: un byte del bloque
	inc de			;452e
	exx			;452f   ; el puerto vive en el juego alternativo de registros
	out (c),a		;4530   ; y sale por el puerto de datos del VDP
	exx			;4532
	djnz L_452D		;4533   ; B bytes, uno a uno
	jr L_4522		;4535
L_4537:
	ld a,(de)			;4537   ; repeticion: el byte, una sola vez
	inc de			;4538
L_4539:
	exx			;4539   ; y al puerto tantas veces como diga B
	out (c),a		;453a
	exx			;453c
	push hl			;453d   ; un `push/pop` que no mueve nada: es tiempo, para no ir mas rapido que el VDP
	pop hl			;453e
	djnz L_4539		;453f
	jr L_4522		;4541
L_4543:
	cp b			;4543   ; A cero y B cero: fin del bloque
	jr nz,abre_destino_de_vram		;4544   ; si no, era 0x80: otro destino de VRAM
	ei			;4546   ; y devuelve las interrupciones
	ret			;4547

; ----------------------------------------------------------------------
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; El RLE volcado al puerto del VDP en vez de a la RAM: HL es la direccion de VRAM y DE el bloque. Con el se cargan los patrones y los colores de la pantalla.
; ----------------------------------------------------------------------
descomprime_a_vram:
	ld c,000h		;4548   ; C=0 marca que aun no se ha abierto ningun destino
	jr vuelca_rle_al_vdp		;454a

; ----------------------------------------------------------------------
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; El descompresor con el destino fijo en 0xE0B0, que es donde se monta el mapa de la zona.
; ----------------------------------------------------------------------
descomprime_a_e0b0:
	ld de,0e0b0h		;454c   ; el buffer del mapa, 120 bytes

; ----------------------------------------------------------------------
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; El descompresor RLE del cartucho: HL es el origen y DE el destino. El byte de control lleva la cuenta en los siete bits de abajo y en el bit 7 si lo que sigue se copia tal cual o se repite; un control de 0x00 cierra. Con el se guardan los 25 mapas de zona, que descomprimen a 120 bytes clavados cada uno.
; ----------------------------------------------------------------------
descomprime_rle:
	ld a,(hl)			;454f   ; el byte de control
	and a			;4550   ; un 0x00 termina el bloque
	ret z			;4551
	and 07fh		;4552   ; los siete bits de abajo son la cuenta
	ld c,a			;4554
	ld a,(hl)			;4555   ; recupera el control entero, que `and` se lo habia comido
	ld b,000h		;4556
	inc hl			;4558   ; y ya apunta al primer byte de la carga
	rla			;4559   ; el bit 7 al acarreo: decide literal o repeticion
	jr nc,L_4560		;455a   ; sin bit 7, es una repeticion
	ldir		;455c   ; con bit 7, copia C bytes tal cual
	jr descomprime_rle		;455e   ; y a por el control siguiente
L_4560:
	ld a,(hl)			;4560   ; el byte que hay que repetir
	ld b,c			;4561   ; tantas veces como diga la cuenta
L_4562:
	ld (de),a			;4562   ; escribiendolo del tiron
	inc de			;4563
	djnz L_4562		;4564
	inc hl			;4566   ; pasa por encima del byte repetido
	jr descomprime_rle		;4567   ; y sigue con el control siguiente

; ----------------------------------------------------------------------
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; Deja el VDP listo para escribir en HL y el puerto de datos en C, sacado de la ROM de la BIOS (0x0006) en vez de escrito a mano.
; ----------------------------------------------------------------------
prepara_escritura_de_vram:
	ex af,af'			;4569   ; guarda A, que el llamador lo necesita
	call 00053h		;456a   ; BIOS SETWRT - Enables VDP to write | abre la escritura en la direccion de HL
	exx			;456d
	ld a,(00006h)		;456e   ; la BIOS guarda ahi el puerto de datos del VDP
	ld c,a			;4571   ; a C, que es donde lo quiere `out (c),a`
	exx			;4572
	ex af,af'			;4573   ; y devuelve A como estaba
	ret			;4574

; ----------------------------------------------------------------------
; DATOS prepara_lectura_de_vram: la gemela de L_4569 para LEER: `call 0x0050`
;   (SETRD) y C = (0x0007), el puerto de lectura del VDP. NADIE la llama: no
;   hay un solo call ni jp a 0x4575 en toda la ROM, ni aparece como palabra en
;   ninguna tabla. Es codigo muerto del cartucho
;   0x4575..0x457f  (10 bytes)
DATA_prepara_lectura_de_vram:
	defb 0cdh,050h,000h,0d9h,03ah,007h,000h,04fh,0d9h,0c9h	; 4575  .P..:..O..

; ======================================================================
; CODIGO 0x457f..0x45f7  (120 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; El interprete de rotulos: el guion es [destino en VRAM][indices de patron], con 0xFE para saltar a otro destino y 0xFF para acabar. La fuente esta ordenada como el ASCII desde el espacio, o sea que el indice es el codigo menos 0x20.
; ----------------------------------------------------------------------
escribe_rotulo:
	ld c,0ffh		;457f   ; la mascara 0xFF deja pasar el byte tal cual
lee_destino_del_guion:
	ld e,(hl)			;4581   ; byte bajo del destino en VRAM
	inc hl			;4582
	ld d,(hl)			;4583   ; y byte alto
	inc hl			;4584
pinta_caracter_del_guion:
	ld a,(hl)			;4585   ; el siguiente byte del guion
	inc hl			;4586
	ld b,a			;4587   ; se prueba sumandole uno, que sale mas barato que dos comparaciones
	inc b			;4588
	ret z			;4589   ; era 0xFF: fin del guion
	inc b			;458a   ; otra vez, para probar el 0xFE
	jr z,lee_destino_del_guion		;458b   ; era 0xFE: a por otro destino
	and c			;458d   ; la mascara, que distingue escribir de borrar
	ex de,hl			;458e
	call 0004dh		;458f   ; BIOS WRTVRM - Writes data in VRAM | y el caracter a la memoria de video
	ex de,hl			;4592
	inc de			;4593   ; la celda siguiente
	jr pinta_caracter_del_guion		;4594

; ----------------------------------------------------------------------
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; La misma rutina con la mascara a cero: recorre el mismo guion pero escribe ceros, o sea que borra el rotulo sin tener que guardar aparte donde estaba.
; ----------------------------------------------------------------------
borra_rotulo:
	ld c,000h		;4596   ; con la mascara a cero, todo byte sale 0
	jr lee_destino_del_guion		;4598

; ----------------------------------------------------------------------
; Vuelca los atributos de sprite a la memoria de video, pero EMPEZANDO CADA CUADRO POR OTRO SITIO: dieciseis bytes mas adelante que el anterior, dando la vuelta al llegar al final. Asi ningun sprite se queda siempre el ultimo.
; Vuelca los atributos de sprite a la memoria de video, pero EMPEZANDO CADA CUADRO POR OTRO SITIO: dieciseis bytes mas adelante que el anterior, dando la vuelta al llegar al final. Asi ningun sprite se queda siempre el ultimo.
; ----------------------------------------------------------------------
reparte_la_prioridad_de_sprites:
	ld a,(0e057h)		;459a   ; el desplazamiento del cuadro anterior
	add a,010h		;459d   ; dieciseis mas: cuatro sprites
	ld (0e057h),a		;459f   ; guardado para el cuadro siguiente
	and 070h		;45a2   ; y da la vuelta a los 0x80
	ld (0e056h),a		;45a4   ; el desplazamiento de este cuadro
	ld c,a			;45a7
	ld de,0e0b0h		;45a8   ; el buffer de atributos
	ld l,a			;45ab
	ld h,000h		;45ac
	add hl,de			;45ae   ; mas el desplazamiento
	ex de,hl			;45af
	ld a,080h		;45b0   ; lo que queda hasta el final del buffer
	sub c			;45b2
	ld c,a			;45b3
	ld b,000h		;45b4
	ld hl,03b00h		;45b6   ; la tabla de sprites de la memoria de video
	call vuelca_a_vram		;45b9   ; y se vuelca ese trozo
	ld a,(0e056h)		;45bc
	and a			;45bf
	ret z			;45c0
	ld b,a			;45c1
	ld c,a			;45c2
	ld a,080h		;45c3
	sub b			;45c5
	ld b,000h		;45c6
	ld hl,03b00h		;45c8
	ld e,a			;45cb
	ld d,b			;45cc
	add hl,de			;45cd
	ld de,0e0b0h		;45ce
	jp vuelca_a_vram		;45d1

; ----------------------------------------------------------------------
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; Deja la maquina lista: borra los 16 KB de memoria de video y carga los ocho registros del VDP desde la tabla de 0x45f7.
; ----------------------------------------------------------------------
arranca_el_vdp:
	ld a,0b8h		;45d4   ; el color de borde y fondo
	call apaga_los_canales		;45d6
	call L_50FA		;45d9
	ld de,00000h		;45dc   ; desde el principio de la memoria de video
	ld bc,04000h		;45df   ; los 16 KB enteros
	xor a			;45e2   ; a cero
	call borra_trozo_de_vram		;45e3
carga_registros_del_vdp:
	ld hl,045f7h		;45e6   ; la tabla de los ocho registros
	ld d,008h		;45e9   ; son ocho registros
	ld c,000h		;45eb   ; empezando por el 0
L_45ED:
	ld b,(hl)			;45ed   ; el valor que toca
	call 00047h		;45ee   ; BIOS WRTVDP - Writes data in the VDP-register | y al registro C
	inc hl			;45f1
	inc c			;45f2   ; el registro siguiente
	dec d			;45f3
	jr nz,L_45ED		;45f4
	ret			;45f6

; ----------------------------------------------------------------------
; DATOS tabla_45f7: 8 bytes; la carga 0x45e6
;   0x45f7..0x45ff  (8 bytes)
DATA_tabla_45f7:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e0h	; 45f7  .....v..

; ======================================================================
; CODIGO 0x45ff..0x4735  (310 bytes)
; ======================================================================


L_45FF:
	ld c,007h		;45ff
	jp L_4067		;4601

; ----------------------------------------------------------------------
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; Lee lo que el jugador esta haciendo. Con partida en marcha junta mando y teclado; sin partida, es la demostracion la que pone las pulsaciones.
; ----------------------------------------------------------------------
lee_los_mandos:
	ld hl,0e002h		;4604   ; las banderas del juego
	bit 6,(hl)		;4607   ; el bit 6 dice si hay partida
	jr nz,junta_mando_y_teclado		;4609   ; con partida, se leen los mandos de verdad
	call reproduce_la_demostracion		;460b   ; y sin partida, manda el guion de la demostracion
	jr saca_las_pulsaciones_nuevas		;460e
junta_mando_y_teclado:
	call lee_el_mando		;4610   ; el mando, por el PSG
	push af			;4613   ; guardado, que la lectura del teclado lo pisa
	call lee_el_teclado		;4614   ; el teclado
	pop bc			;4617   ; y los dos bits juntos: da igual con que se juegue
	or b			;4618

; ----------------------------------------------------------------------
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; De lo que esta pulsado ahora saca lo que se acaba de pulsar: guarda lo de antes, lo compara con un XOR y se queda con lo que ha cambiado a pulsado. Asi un boton mantenido no cuenta como pulsacion nueva.
; ----------------------------------------------------------------------
saca_las_pulsaciones_nuevas:
	ld hl,0e00ah		;4619   ; lo que estaba pulsado en el cuadro anterior
	ld c,(hl)			;461c   ; C se queda con lo de antes
	ld (hl),a			;461d   ; y ahi se apunta lo de ahora
	ld b,a			;461e
	xor c			;461f   ; el XOR da lo que ha cambiado
	ld c,a			;4620
	and (hl)			;4621   ; y de eso, solo lo que ahora esta pulsado
	dec hl			;4622
	ld (hl),a			;4623   ; las pulsaciones nuevas
	ld d,a			;4624
	ld a,c			;4625   ; lo que ha cambiado
	and 00fh		;4626   ; solo las cuatro direcciones
	ret z			;4628   ; si no ha cambiado ninguna, no hay nada que decidir
	ld a,d			;4629   ; las pulsaciones nuevas
	and 00fh		;462a   ; otra vez las cuatro direcciones
	jr nz,elige_una_sola_direccion		;462c   ; si hay direccion nueva, esa manda
	ld a,b			;462e   ; y si no, se queda con lo que siga pulsado
	ld d,a			;462f

; ----------------------------------------------------------------------
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; Deja UNA sola direccion, probandolas por orden de prioridad: arriba, abajo, izquierda y derecha. En diagonal gana la primera de la lista, y si no queda ninguna se sale con cero.
; ----------------------------------------------------------------------
elige_una_sola_direccion:
	and 001h		;4630   ; arriba
	jr nz,guarda_la_direccion		;4632   ; y si es esa, ya esta
	ld a,d			;4634
	and 002h		;4635   ; abajo
	jr nz,guarda_la_direccion		;4637
	ld a,d			;4639
	and 004h		;463a   ; izquierda
	jr nz,guarda_la_direccion		;463c
	ld a,d			;463e
	and 008h		;463f   ; derecha
	jr nz,guarda_la_direccion		;4641
	xor a			;4643   ; y si no hay ninguna, cero
guarda_la_direccion:
	ld (0e010h),a		;4644   ; la direccion elegida, para el resto del cuadro
	ret			;4647

; ----------------------------------------------------------------------
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; Lee el mando por el PSG: el registro 15 elige el puerto y el 14 trae las lineas. Vienen con la logica invertida -pulsado es cero-, y por eso el `cpl`.
; ----------------------------------------------------------------------
lee_el_mando:
	ld e,08fh		;4648   ; selecciona el puerto del mando
	ld a,00fh		;464a   ; el registro 15 del PSG
	call 00093h		;464c   ; BIOS WRTPSG - Writes data to PSG-register | y se lo dice al PSG
	ld a,00eh		;464f   ; el registro 14 es el que trae las lineas
	di			;4651   ; sin interrupciones: la BIOS tambien toca el PSG
	call 00096h		;4652   ; BIOS RDPSG - Reads value from PSG-register | lee las lineas
	ei			;4655
	cpl			;4656   ; pulsado es cero, asi que se le da la vuelta
	and 03fh		;4657   ; y solo los seis bits que valen
	ret			;4659

; ----------------------------------------------------------------------
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; Lee tres filas de la matriz del teclado y las recoloca hasta dejarlas en el MISMO formato de seis bits que el mando. Todo el trabajo de `rrca` de aqui es eso: cuadrar los bits para que arriba caiga donde el mando pone arriba.
; ----------------------------------------------------------------------
lee_el_teclado:
	ld a,006h		;465a   ; la fila 6: las teclas de control
	call 00141h		;465c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | a la BIOS
	cpl			;465f   ; pulsado es cero tambien aqui
	ld hl,0e04ah		;4660   ; lo que estaba pulsado antes
	ld c,(hl)			;4663
	ld (hl),a			;4664
	xor c			;4665   ; el XOR, otra vez, para las teclas nuevas
	and (hl)			;4666
	ld (0e06dh),a		;4667   ; que las mira la escena de la pausa
	ld a,007h		;466a   ; la fila 7
	call 00141h		;466c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;466f
	rrca			;4670   ; su bit al sitio del segundo boton
	and 020h		;4671
	ld e,a			;4673
	ld a,008h		;4674   ; y la fila 8, la de los cursores
	call 00141h		;4676   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4679
	rrca			;467a   ; dos bits a la derecha
	rrca			;467b
	ld b,a			;467c
	and 004h		;467d   ; el bit del disparo
	or e			;467f   ; junto al anterior
	ld c,a			;4680
	ld a,b			;4681
	rrca			;4682   ; otros dos
	rrca			;4683
	ld b,a			;4684
	and 018h		;4685   ; dos direcciones mas
	or c			;4687
	ld c,a			;4688
	ld a,b			;4689
	rrca			;468a   ; y los dos ultimos
	and 003h		;468b
	or c			;468d   ; con lo que ya habia: seis bits como los del mando
	ret			;468e

; ----------------------------------------------------------------------
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; Aqui la maquina no juega sola: LEE una partida grabada. El guion son 77 pulsaciones que se descomprimieron a 0xE342, y avanza una cada dos cuadros. El 0xFF del final es lo que baja la bandera y termina la demostracion.
; ----------------------------------------------------------------------
reproduce_la_demostracion:
	ld hl,0e00ch		;468f   ; el paso de la demostracion
	ld a,(0e005h)		;4692   ; el contador que da la vuelta cada 16
	or a			;4695
	jr nz,L_4699		;4696   ; solo avanza cuando esta a cero
	inc (hl)			;4698   ; o sea uno de cada dos cuadros
L_4699:
	ld a,(hl)			;4699   ; el paso actual
	ld hl,0e342h		;469a   ; el guion descomprimido
	call suma_a_a_hl		;469d   ; indexado por el paso
	ld a,(hl)			;46a0   ; la pulsacion grabada, que sale como si fuera del mando
	cp 0ffh		;46a1   ; el 0xFF cierra el guion
	ret nz			;46a3
	xor a			;46a4   ; y con el se baja la bandera
	ld (0e055h),a		;46a5   ; para que la demostracion termine
	ret			;46a8

; ----------------------------------------------------------------------
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; El mando durante la presentacion: cualquier tecla salta la demostracion, y el disparo empieza la partida.
; ----------------------------------------------------------------------
atiende_el_menu:
	call lee_el_mando		;46a9   ; el mando
	ld d,a			;46ac
	call lee_el_teclado		;46ad   ; y el teclado
	or d			;46b0   ; juntos
	ld b,a			;46b1
	ld hl,0e044h		;46b2   ; lo que estaba pulsado
	ld c,(hl)			;46b5
	ld (hl),a			;46b6
	inc hl			;46b7
	ld (hl),c			;46b8   ; se guarda para el cuadro siguiente
	ld hl,0e000h		;46b9   ; el estado del juego
	ld a,001h		;46bc   ; el estado 1 es la presentacion
	cp (hl)			;46be
	ld a,b			;46bf
	jr z,empieza_la_partida		;46c0   ; en la presentacion se mira el disparo
	and 03fh		;46c2   ; en los demas, cualquier cosa vale
	ret z			;46c4   ; si no hay nada pulsado, se sale
	xor a			;46c5   ; la cuenta atras a cero
	ld (0e004h),a		;46c6
	inc a			;46c9   ; al estado 1
	ld (hl),a			;46ca
	inc hl			;46cb
	ld (hl),000h		;46cc   ; sin subestado
	jp L_4486		;46ce   ; y a montar la pantalla de titulo
empieza_la_partida:
	ld hl,0e045h		;46d1   ; lo que estaba pulsado antes
	xor (hl)			;46d4   ; solo las pulsaciones nuevas
	and b			;46d5
	and 010h		;46d6   ; el bit 4, el disparo
	ret z			;46d8   ; sin disparo no se empieza
	ld a,040h		;46d9   ; levanta el bit 6: hay partida
	ld (0e002h),a		;46db
	ld hl,00003h		;46de   ; al estado 3, sin subestado
	ld (0e000h),hl		;46e1
	ret			;46e4
prepara_la_cortinilla:
	ld a,00eh		;46e5   ; catorce pasos de cortinilla
	ld (0e00dh),a		;46e7
	ld hl,03aaah		;46ea   ; la fila por donde empieza
	ld (0e00eh),hl		;46ed
	ld b,0e4h		;46f0   ; y 228 columnas que borrar
	jp L_45FF		;46f2

; ----------------------------------------------------------------------
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; Abre la cortinilla del titulo: cada cuadro sube una fila y pinta tres tramos de celdas con indices consecutivos, dejando el hueco de en medio en blanco.
; ----------------------------------------------------------------------
avanza_la_cortinilla:
	ld hl,(0e00eh)		;46f5   ; la fila actual
	ld de,0ffe0h		;46f8   ; menos 32: una fila mas arriba
	add hl,de			;46fb
	ld (0e00eh),hl		;46fc   ; y se guarda
	ld a,040h		;46ff   ; el primer patron del tramo
	ld b,003h		;4701   ; tres celdas
	call pinta_tramo_de_cortinilla		;4703
	ld bc,00b0ch		;4706   ; once celdas y doce de salto
	call pinta_tramo_de_cortinilla		;4709
	ld b,c			;470c   ; y otras doce
	call pinta_tramo_de_cortinilla		;470d
	xor a			;4710   ; el hueco, en blanco
	call 00056h		;4711   ; BIOS FILVRM - Fills VRAM with value
	ld hl,0e00dh		;4714   ; los pasos que quedan
	dec (hl)			;4717   ; uno menos
	ret			;4718
pinta_tramo_de_cortinilla:
	push hl			;4719   ; guarda el principio del tramo
pinta_celda_del_tramo:
	call 0004dh		;471a   ; BIOS WRTVRM - Writes data in VRAM | la celda
	inc hl			;471d   ; la siguiente
	inc a			;471e   ; y el patron siguiente, que van seguidos
	djnz pinta_celda_del_tramo		;471f   ; las B celdas del tramo
	pop de			;4721   ; el principio del tramo
	ld hl,00020h		;4722   ; y baja una fila entera
	add hl,de			;4725
	ret			;4726

; ----------------------------------------------------------------------
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; El reloj de la pantalla de titulo: sube el contador de 16 bits y reparte al tramo que diga su byte alto, con la tabla de cinco de 0x4735.
; ----------------------------------------------------------------------
avanza_la_coreografia:
	ld hl,(0e016h)		;4727   ; el contador de la coreografia
	inc hl			;472a   ; un paso mas
	ld (0e016h),hl		;472b
	ld a,h			;472e   ; el byte alto elige el tramo
	ld hl,04735h		;472f   ; la tabla de los cinco tramos
	jp L_4080		;4732   ; y al despachador, saltandose el `pop hl`

; ----------------------------------------------------------------------
; DATOS tabla_de_subestados: 5 punteros, indexados por el byte alto de
;   (0xE016)
;   0x4735..0x473f  (10 bytes)
DATA_tabla_de_subestados:
	defw 0473fh,04766h,047b8h,047e7h,047feh	; 4735

; ======================================================================
; CODIGO 0x473f..0x4806  (199 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; El primer tramo: carga los sprites del titulo y coloca las ocho figuras en su sitio de partida.
; ----------------------------------------------------------------------
tramo_de_entrada:
	ld a,(0e016h)		;473f   ; el paso dentro del tramo
	cp 020h		;4742   ; en el paso 0x20 suena el aviso
	jr nz,carga_los_sprites_del_titulo		;4744
	ld a,08ah		;4746   ; el sonido de entrada
	call suena		;4748
	ld a,0ffh		;474b   ; y el contador se pone a -1 para que el `inc` lo deje en el tramo siguiente
	ld (0e016h),a		;474d
carga_los_sprites_del_titulo:
	ld de,079aah		;4750   ; el bloque de patrones de sprite
	ld hl,01800h		;4753   ; a 0x1800, que es lo que dice R6
	call descomprime_a_vram		;4756
	ld hl,04806h		;4759   ; los ocho atributos de partida
	ld de,0e0b0h		;475c   ; al buffer de sprites
	ld bc,00020h		;475f   ; los 32 bytes que ocupan
	ldir		;4762
	jr vuelca_los_sprites		;4764

; ----------------------------------------------------------------------
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; El tramo largo: las figuras cruzan la pantalla. Solo se mueve en los cuadros pares, y cada dieciseis se corrigen dos de ellas con el rebote de 0x47ab.
; ----------------------------------------------------------------------
tramo_de_paseo:
	ld a,(0e016h)		;4766   ; el paso del tramo
	ld c,a			;4769
	and 001h		;476a   ; solo los cuadros pares
	ret nz			;476c
	ld a,c			;476d
	and 00fh		;476e   ; cada dieciseis pasos
	jr nz,mueve_las_figuras		;4770
	ld hl,0e0ceh		;4772   ; la Y de una de las figuras
	ld bc,02810h		;4775   ; con 0x28 de paso y 0x10 de tope
	call rebota_la_figura		;4778
	ld hl,0e0b2h		;477b   ; y otra
	ld bc,02c08h		;477e   ; con 0x2C y 0x08
	call rebota_la_figura		;4781
mueve_las_figuras:
	ld e,007h		;4784   ; la mascara del ritmo
	ld b,e			;4786   ; y las figuras que se mueven
primera_figura:
	ld hl,0e0b1h		;4787   ; la X de la primera figura
avanza_una_figura:
	inc (hl)			;478a   ; un pixel a la derecha
	inc hl			;478b   ; y al atributo siguiente, que son cuatro bytes
	inc hl			;478c
	inc hl			;478d
	inc hl			;478e
	djnz avanza_una_figura		;478f   ; todas las figuras del tramo
	ld a,(0e016h)		;4791   ; el ritmo lento
	and e			;4794
	jr nz,vuelca_los_sprites		;4795   ; si no toca, ya esta
	ld hl,0e0beh		;4797   ; otras dos figuras
	ld bc,03028h		;479a
	call rebota_la_figura		;479d
	ld hl,0e0c2h		;47a0   ; con su paso y su tope
	ld bc,03428h		;47a3
	call rebota_la_figura		;47a6
	jr vuelca_los_sprites		;47a9

; ----------------------------------------------------------------------
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; Suma C a la coordenada y, si llega justo al tope B, le da la vuelta al paso restandolo del doble. Es el rebote de las figuras que van y vienen.
; ----------------------------------------------------------------------
rebota_la_figura:
	ld a,(hl)			;47ab   ; la coordenada
	add a,c			;47ac   ; mas el paso
	cp b			;47ad   ; si llega al tope, hay que rebotar
	jr z,L_47B6		;47ae
	ld b,a			;47b0   ; se guarda la coordenada
	ld a,c			;47b1
	add a,a			;47b2   ; el paso, por dos
	ld c,a			;47b3
	ld a,b			;47b4   ; y la coordenada menos ese doble: el paso cambia de signo
	sub c			;47b5
L_47B6:
	ld (hl),a			;47b6   ; y la coordenada, de vuelta
	ret			;47b7

; ----------------------------------------------------------------------
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; Mete en escena la figura que faltaba, la novena, colocandola ocho pixeles por debajo de otra.
; ----------------------------------------------------------------------
tramo_de_la_novena_figura:
	ld hl,04826h		;47b8   ; su atributo de partida
	ld de,0e0cch		;47bb   ; al noveno hueco del buffer
	ld bc,00004h		;47be   ; cuatro bytes
	ldir		;47c1
	ld a,(0e0b5h)		;47c3   ; la Y de la figura de referencia
	add a,008h		;47c6   ; ocho pixeles mas abajo
	ld (0e0cdh),a		;47c8
	ld a,020h		;47cb   ; y la X de otra, a 0x20
	ld (0e0b2h),a		;47cd
	ld a,(0e016h)		;47d0   ; el paso del tramo
	cp 004h		;47d3   ; en el paso 4 suena
	jr nz,vuelca_los_sprites		;47d5
	ld a,086h		;47d7   ; el sonido
	call suena		;47d9
	ld a,0b0h		;47dc   ; y salta al paso 0xB0
	ld (0e016h),a		;47de
vuelca_los_sprites:
	ld bc,00020h		;47e1   ; los 32 bytes de atributos
	jp L_5FDB		;47e4   ; a la tabla de sprites de la memoria de video

; ----------------------------------------------------------------------
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; El ultimo tramo: las figuras se van a paso lento, y al llegar a 0xC0 el contador se reinicia y la coreografia vuelve a empezar.
; ----------------------------------------------------------------------
tramo_de_salida:
	ld a,(0e016h)		;47e7   ; el paso del tramo
	ld c,a			;47ea
	and 001h		;47eb   ; solo los cuadros pares
	ret nz			;47ed
	ld a,c			;47ee
	cp 0c0h		;47ef   ; al llegar a 0xC0 se acaba
	jr nz,L_47F8		;47f1
	ld a,0ffh		;47f3   ; y vuelve a empezar por el primer tramo
	ld (0e016h),a		;47f5
L_47F8:
	ld e,01fh		;47f8   ; el ritmo, mas lento aqui
	ld b,008h		;47fa   ; y ocho figuras
	jr primera_figura		;47fc
termina_la_coreografia:
	call esconde_los_sprites		;47fe   ; quita las figuras
	inc a			;4801   ; y avisa de que ha terminado
	ld (0e015h),a		;4802
	ret			;4805

; ----------------------------------------------------------------------
; DATOS estado_inicial_e0b0: 8 estructuras de cuatro bytes copiadas a 0xE0B0
;   por el ldir de 0x4759
;   0x4806..0x4826  (32 bytes)
DATA_estado_inicial_e0b0:
	defb 0a0h,008h,024h,001h	; 4806
	defb 098h,000h,000h,00fh	; 480a
	defb 098h,010h,004h,00fh	; 480e
	defb 0a8h,000h,008h,00fh	; 4812
	defb 0a8h,010h,00ch,00fh	; 4816
	defb 0ach,000h,010h,006h	; 481a
	defb 0ach,010h,014h,006h	; 481e
	defb 09ch,0a4h,018h,00eh	; 4822

; ----------------------------------------------------------------------
; DATOS estado_inicial_e0cc: la novena estructura, copiada aparte a 0xE0CC por
;   el ldir de 0x47b8
;   0x4826..0x482a  (4 bytes)
DATA_estado_inicial_e0cc:
	defb 08eh,000h,01ch,00eh	; 4826

; ======================================================================
; CODIGO 0x482a..0x4b18  (750 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; El cuerpo del cuadro mientras se juega: mueve el marcador, el protagonista y los enemigos, y luego mira si el protagonista esta en un sitio donde pueda pasar algo.
; ----------------------------------------------------------------------
mueve_todo:
	call reparte_la_prioridad_de_sprites		;482a   ; el marcador que se desplaza
	call anima_los_patrones		;482d   ; el protagonista
	call parpadea_las_dos_sueltas		;4830   ; los enemigos
	ld hl,(0e130h)		;4833   ; la posicion del protagonista
	ld a,l			;4836
	cp 018h		;4837   ; el borde de la izquierda
	jr c,cuenta_el_bonus		;4839
	cp 0b1h		;483b   ; y el de la derecha
	jr nc,cuenta_el_bonus		;483d
	ld a,h			;483f
	cp 020h		;4840   ; el de arriba
	jr c,cuenta_el_bonus		;4842
	cp 0d9h		;4844   ; y el de abajo
	jr nc,cuenta_el_bonus		;4846
	call es_zona_de_bonus		;4848   ; en las zonas de bonus no hace falta la comprobacion de mas
	jr z,mira_si_esta_en_una_celda		;484b
	ld a,(0e2b5h)		;484d   ; el estado del protagonista
	cp 01fh		;4850   ; el 0x1F es el que no cuenta
	jr z,cuenta_el_bonus		;4852

; ----------------------------------------------------------------------
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; Solo pasa algo cuando el protagonista esta CUADRADO con la rejilla: las dos coordenadas multiplo de ocho. Entre celda y celda no se comprueba nada.
; ----------------------------------------------------------------------
mira_si_esta_en_una_celda:
	ld a,(0e130h)		;4854   ; la coordenada X
	and 007h		;4857   ; multiplo de ocho?
	jr z,mira_que_pasa_en_la_celda		;4859
	ld a,(0e131h)		;485b   ; y la Y
	and 007h		;485e   ; las dos: esta en una celda
	jr z,mira_que_pasa_en_la_celda		;4860
cuenta_el_bonus:
	ld a,(0e003h)		;4862   ; el contador de cuadros
	and 00fh		;4865   ; uno de cada dieciseis
	ret nz			;4867
	ld a,(0e280h)		;4868   ; la fase del bonus
	cp 001h		;486b   ; la primera
	jr nz,avanza_la_fase_del_bonus		;486d
	ld (0e00bh),a		;486f   ; levanta la bandera de bonus
	dec a			;4872
	ld (0e01ah),a		;4873   ; y pone a cero el contador
	call premio_de_veinte_mil		;4876
	jp estalla_el_protagonista		;4879
avanza_la_fase_del_bonus:
	ld hl,0e2dch		;487c   ; el contador de la fase
	inc (hl)			;487f   ; uno mas
	ld a,(hl)			;4880
	cp 001h		;4881   ; en el primero se pasa de fase
	jr nz,L_489E		;4883
	ld hl,0e280h		;4885   ; la fase del bonus
	inc (hl)			;4888   ; la siguiente
	call L_50FA		;4889   ; y su sonido

; ----------------------------------------------------------------------
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; El premio gordo: veinte mil puntos, sumados en tres veces porque el sumador trabaja en BCD y no le caben de una. OJO al leerlo: los `ld de,07000h` son SIETE MIL PUNTOS, no una direccion de la ROM.
; ----------------------------------------------------------------------
premio_de_veinte_mil:
	ld de,07000h		;488c   ; siete mil
	call suma_al_marcador		;488f
	ld de,07000h		;4892   ; y otros siete mil
	call suma_al_marcador		;4895
	ld de,06000h		;4898   ; mas seis mil: veinte mil en total
	jp suma_al_marcador		;489b
L_489E:
	rra			;489e
	ret nc			;489f
estalla_el_protagonista:
	ld hl,(0e281h)		;48a0   ; donde estaba
	ld a,0b7h		;48a3   ; y el dibujo de la explosion
	jp coge_el_objeto		;48a5

; ----------------------------------------------------------------------
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; Con el protagonista cuadrado en una celda, decide que toca: seguir jugando, gastar tiempo o rematar la zona.
; ----------------------------------------------------------------------
mira_que_pasa_en_la_celda:
	ld a,(0e067h)		;48a8   ; el estado de la partida
	and 003h		;48ab   ; con los dos bits de abajo puestos, esta acabando
	jp nz,remata_la_zona		;48ad
	ld a,(0e06dh)		;48b0   ; las teclas nuevas
	bit 6,a		;48b3   ; el bit 6 corta por lo sano
	jr nz,pasa_al_recuento		;48b5
	jr gasta_el_tiempo		;48b7
acaba_la_zona:
	call es_zona_de_bonus		;48b9   ; en las de bonus se acaba de otra manera
	jr nz,L_48E3		;48bc
pasa_al_recuento:
	ld a,002h		;48be   ; el estado 2: a contar
	ld (0e067h),a		;48c0   ; y ahi se queda
	ret			;48c3

; ----------------------------------------------------------------------
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; El reloj de la zona: baja diez de tiempo cada dieciseis cuadros, y cuando se acaba se termina la zona.
; ----------------------------------------------------------------------
gasta_el_tiempo:
	ld hl,(0e058h)		;48c4   ; el tiempo que queda
	ld a,l			;48c7
	or h			;48c8
	jr z,acaba_la_zona		;48c9   ; si se acabo, fin de zona
	ld a,(0e003h)		;48cb   ; el contador de cuadros
	and 00fh		;48ce   ; uno de cada dieciseis
	jr nz,mira_si_queda_poco		;48d0
	ld hl,0e058h		;48d2   ; el tiempo
	ld de,00010h		;48d5   ; diez menos
	call resta_bcd_de_dos_bytes		;48d8   ; restados en BCD
mira_si_queda_poco:
	ld hl,(0e058h)		;48db   ; el tiempo que queda
	ld a,h			;48de
	cp 010h		;48df   ; por debajo de 0x1000 empieza el aviso
	jr nc,mueve_a_todos		;48e1
L_48E3:
	call pinta_el_aviso_de_bonus		;48e3

; ----------------------------------------------------------------------
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; La lista de todo lo que hay que mover en un cuadro de juego, en el orden en que el cartucho lo hace. Ese orden IMPORTA: quien se mueve antes decide quien choca con quien.
; ----------------------------------------------------------------------
mueve_a_todos:
	call pinta_el_tiempo		;48e6   ; repinta el tiempo
	call anima_el_decorado		;48e9
	call mueve_al_protagonista		;48ec
	call coloca_el_sprite_del_protagonista		;48ef
	call elige_el_dibujo_del_protagonista		;48f2
	call mira_los_cuatro_objetos		;48f5
	call mira_los_choques		;48f8
	call lanza_el_martillo		;48fb
	call busca_el_enemigo_mas_cercano		;48fe
	call vuela_el_martillo		;4901
	call busca_el_enemigo_mas_cercano		;4904
	call mira_si_le_pilla_el_derrumbe		;4907
	call mira_si_ha_llegado_arriba		;490a
	call parpadea_los_objetos		;490d

; ----------------------------------------------------------------------
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; EL HUEVO DE PASCUA DE LA CASA. Los 5730 puntos no son una cifra
; ----------------------------------------------------------------------
	call es_zona_de_bonus		;4910   ; el premio escondido solo esta en las zonas de bonus
	ret nz			;4913
	ld a,(0e068h)		;4914   ; y solo se cobra una vez
	and a			;4917
	ret nz			;4918
	ld hl,(0e132h)		;4919   ; donde esta el protagonista
	ld a,l			;491c
	cp 090h		;491d   ; la X exacta
	ret nz			;491f
	ld a,h			;4920
	sub 039h		;4921   ; y la Y exacta: 0x39
	ret nz			;4923
	inc a			;4924   ; se marca como cobrado
	ld (0e068h),a		;4925
	ld hl,05d2fh		;4928   ; el rotulo KONAMI 5730 PTS
	call escribe_rotulo		;492b
	call suena_el_objeto		;492e   ; y su sonido
	ld de,05730h		;4931   ; 5730 puntos: en japones 5-7-3 se lee go-na-mi, o sea KONAMI
	jp suma_al_marcador		;4934
remata_la_zona:
	rra			;4937   ; el bit 0 separa los dos finales
	jr c,termina_la_zona_bien		;4938
	call pinta_el_aviso_de_bonus		;493a   ; el aviso del marcador
	ld hl,0e2ddh		;493d   ; el contador del remate
	inc (hl)			;4940   ; uno mas
	ld a,(hl)			;4941
	sub 080h		;4942   ; a los 128 se acaba
	jr nz,sigue_el_remate		;4944
	ld (0e055h),a		;4946   ; y baja la bandera de partida
	ret			;4949
sigue_el_remate:
	call anima_el_fin_de_zona		;494a   ; mueve lo que quede
	ld a,0e0h		;494d   ; esconde un sprite
	ld (0e0c0h),a		;494f
	jp anima_el_decorado		;4952   ; y repinta

; ----------------------------------------------------------------------
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; El final bueno de una zona: en las de bonus, si se ha llegado entero, da el PERFECT BONUS y pone 0x1000 de bonus por cobrar.
; ----------------------------------------------------------------------
termina_la_zona_bien:
	ld hl,0e066h		;4955   ; el contador del final
	inc (hl)			;4958   ; uno mas
	ld a,(hl)			;4959
	dec a			;495a   ; solo en el primero se dan los premios
	jr nz,avanza_el_final_de_zona		;495b
	push hl			;495d
	call es_zona_de_bonus		;495e   ; y solo en las zonas de bonus
	jr nz,L_497F		;4961
	ld hl,05d42h		;4963   ; el rotulo PERFECT BONUS
	call escribe_rotulo		;4966
	ld hl,03988h		;4969   ; la fila donde va
	ld bc,00010h		;496c   ; dieciseis celdas
	ld a,084h		;496f   ; rellenas con su patron
	call 00056h		;4971   ; BIOS FILVRM - Fills VRAM with value
	ld hl,01000h		;4974   ; y 0x1000 de bonus
	ld (0e06ah),hl		;4977
	ld a,001h		;497a
	ld (0e069h),a		;497c   ; con su bandera puesta
L_497F:
	pop hl			;497f
avanza_el_final_de_zona:
	ld a,(hl)			;4980   ; el contador del final
	cp 080h		;4981   ; hasta 128 sigue el remate
	jp c,parpadea_al_protagonista		;4983
	sub 0c0h		;4986   ; y a 0xC0 se acaba
	ret nz			;4988
	inc a			;4989
	ld (0e00bh),a		;498a   ; levantando la bandera de bonus
	ret			;498d

; ----------------------------------------------------------------------
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; Monta la zona entera: saca su mapa de la tabla, lo descomprime, lo pinta y coloca a todo el mundo en su sitio de partida. Las zonas de la 25 a la 49 vuelven a usar los mapas de la 0 a la 24, que es lo que hace el `sub 019h`.
; ----------------------------------------------------------------------
monta_la_zona:
	ld a,(0e053h)		;498e   ; la zona, de 0 a 49
	ld hl,06522h		;4991   ; la tabla de los 25 mapas
	cp 019h		;4994   ; por debajo de 25 va directa
	jr c,L_499A		;4996
	sub 019h		;4998   ; y de 25 en adelante se repite el mapa
L_499A:
	call lee_puntero_de_tabla		;499a   ; el puntero al mapa comprimido
	ex de,hl			;499d
	call descomprime_a_e0b0		;499e   ; descomprimido a 0xE0B0
	call pinta_el_mapa_de_la_zona		;49a1   ; y pintado en la pantalla
	call es_zona_de_bonus		;49a4   ; en las zonas de bonus
	jr nz,coloca_a_todo_el_mundo		;49a7
	ld hl,03968h		;49a9   ; se rellenan dos filas
	ld bc,00010h		;49ac
	push bc			;49af
	ld a,0b6h		;49b0   ; con su patron
	call 00056h		;49b2   ; BIOS FILVRM - Fills VRAM with value
	pop bc			;49b5
	ld hl,039a8h		;49b6
	call 00056h		;49b9   ; BIOS FILVRM - Fills VRAM with value

; ----------------------------------------------------------------------
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; Deja el bloque de estado en blanco y siembra las posiciones de partida: el protagonista, los cuatro enemigos y sus velocidades.
; ----------------------------------------------------------------------
coloca_a_todo_el_mundo:
	ld hl,0e05ah		;49bc   ; el bloque de estado del juego
	ld bc,00336h		;49bf   ; 822 bytes
	ld d,h			;49c2   ; el truco del ldir que arrastra el cero
	ld e,l			;49c3
	inc de			;49c4
	ld (hl),000h		;49c5
	ldir		;49c7
	ld hl,02400h		;49c9   ; lee de la memoria de video
	ld de,0e2b8h		;49cc   ; una copia de 32 bytes
	ld bc,00020h		;49cf
	call 00059h		;49d2   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld a,0ffh		;49d5   ; los dos estados que empiezan apagados
	ld (0e2b5h),a		;49d7
	ld (0e149h),a		;49da
	ld hl,07818h		;49dd   ; la posicion de partida del protagonista
	ld (0e130h),hl		;49e0
	ld hl,0e4e0h		;49e3   ; la de los enemigos
	ld (0e160h),hl		;49e6
	ld (0e1c0h),hl		;49e9
	ld h,014h		;49ec   ; y la de los otros dos
	ld (0e190h),hl		;49ee
	ld (0e1f0h),hl		;49f1
	ld a,001h		;49f4   ; sus estados iniciales
	ld (0e165h),a		;49f6
	ld (0e169h),a		;49f9
	ld (0e1c5h),a		;49fc
	ld (0e1c9h),a		;49ff
	ld a,008h		;4a02   ; y sus velocidades
	ld (0e17fh),a		;4a04
	rlca			;4a07
	ld h,a			;4a08
	rlca			;4a09
	ld l,a			;4a0a
	ld (0e1afh),a		;4a0b
	rlca			;4a0e
	ld (0e1dfh),a		;4a0f
	ld a,060h		;4a12
	ld (0e20fh),a		;4a14
	ld (0e23fh),hl		;4a17
	call pinta_el_marco_de_la_zona		;4a1a   ; coloca los sprites
	ld hl,071f7h		;4a1d   ; el guion del marco de la zona
	call escribe_rotulo		;4a20
	call monta_el_decorado_de_la_zona		;4a23   ; el decorado que toca a esta zona
	call L_602C		;4a26   ; los patrones del fondo
	call L_5FB8		;4a29
	ld de,00030h		;4a2c   ; cuatro bloques de estado, de 0x30 en 0x30
	ld bc,05c60h		;4a2f
	ld ix,0e160h		;4a32   ; el primer enemigo
	ld hl,0e0b8h		;4a36   ; y su hueco de sprite
	call coloca_un_enemigo		;4a39
	add ix,de		;4a3c   ; el siguiente bloque
	ld hl,0e0c4h		;4a3e
	call coloca_un_enemigo		;4a41
	add ix,de		;4a44
	ld hl,0e0d0h		;4a46
	call coloca_un_enemigo		;4a49
	add ix,de		;4a4c
	ld hl,0e0e0h		;4a4e
	call coloca_un_enemigo		;4a51
	jp L_5FD8		;4a54   ; y todos los sprites a la memoria de video
coloca_un_enemigo:
	ld a,(ix+019h)		;4a57   ; el enemigo esta en juego?
	and a			;4a5a
	ret z			;4a5b   ; si no, no se coloca
	ld (ix+000h),c		;4a5c   ; su posicion de partida
	ld (hl),b			;4a5f   ; y su hueco de sprite
	ret			;4a60

; ----------------------------------------------------------------------
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; Dibuja el marco del area de juego: las dos filas de arriba y abajo con un patron, y las cuatro columnas de los lados celda a celda.
; ----------------------------------------------------------------------
pinta_el_marco_de_la_zona:
	ld hl,03844h		;4a61   ; la fila de arriba del area
	ld a,0a3h		;4a64   ; su patron
	ld bc,00018h		;4a66   ; veinticuatro celdas de ancho
	push bc			;4a69
	call 00056h		;4a6a   ; BIOS FILVRM - Fills VRAM with value | rellenas de un tiron
	ld hl,03ae4h		;4a6d   ; la fila de abajo
	ld a,0a2h		;4a70   ; con otro patron
	pop bc			;4a72
	call 00056h		;4a73   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03842h		;4a76   ; la columna de la izquierda
	ld c,097h		;4a79   ; su patron
	ld b,016h		;4a7b   ; y veintidos celdas de alto
	call pinta_columna_del_marco		;4a7d
	ld hl,03863h		;4a80   ; la segunda columna
	ld c,0a5h		;4a83
	ld b,014h		;4a85
	call pinta_columna_del_marco		;4a87
	ld hl,0387ch		;4a8a   ; la tercera
	ld c,0a1h		;4a8d
	ld b,014h		;4a8f
	call pinta_columna_del_marco		;4a91
	ld hl,0385dh		;4a94   ; y la cuarta
	ld c,097h		;4a97
	ld b,016h		;4a99
pinta_columna_del_marco:
	ld a,c			;4a9b   ; el patron de la columna
	call 0004dh		;4a9c   ; BIOS WRTVRM - Writes data in VRAM | a la celda
	ld de,00020h		;4a9f   ; y una fila mas abajo
	add hl,de			;4aa2
	djnz pinta_columna_del_marco		;4aa3   ; hasta las B celdas
	ret			;4aa5

; ----------------------------------------------------------------------
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; Lee el guion de la zona y va sembrando la pantalla. Las posiciones no vienen enteras: son desplazamientos que se suman a un puntero que empieza en la tabla de nombres.
; ----------------------------------------------------------------------
monta_el_decorado_de_la_zona:
	ld a,(0e002h)		;4aa6   ; las banderas del juego
	add a,a			;4aa9   ; el bit 7 elige entre el guion propio y el comun
	ld de,064a1h		;4aaa   ; el guion comun
	jp p,lee_la_lista_de_objetos		;4aad
	ld a,(0e053h)		;4ab0   ; la zona
	ld hl,06035h		;4ab3   ; la tabla de las cincuenta
	call lee_puntero_de_tabla		;4ab6
lee_la_lista_de_objetos:
	ld hl,0e280h		;4ab9   ; cuantos objetos lleva la zona
	ld a,(de)			;4abc
	ld (hl),a			;4abd
	and a			;4abe   ; si no lleva ninguno, se salta la lista
	jr z,lee_las_dos_posiciones		;4abf
	inc hl			;4ac1
	push hl			;4ac2   ; IX recorre la lista de posiciones
	pop ix		;4ac3
	ld hl,03800h		;4ac5   ; y el puntero arranca en la tabla de nombres
suma_un_desplazamiento:
	inc de			;4ac8   ; el siguiente desplazamiento
	ld a,(de)			;4ac9
	cp 0ffh		;4aca   ; el 0xFF cierra la lista
	jr z,lee_las_dos_posiciones		;4acc
	ld c,a			;4ace   ; se suma al puntero
	ld b,000h		;4acf
	add hl,bc			;4ad1
	cp 0feh		;4ad2   ; y el 0xFE solo suma, sin apuntar nada: asi se pasa de 255
	jr z,suma_un_desplazamiento		;4ad4
	ld (ix+000h),l		;4ad6   ; la posicion, guardada entera
	inc ix		;4ad9
	ld (ix+000h),h		;4adb   ; los dos bytes
	inc ix		;4ade
	jr suma_un_desplazamiento		;4ae0
lee_las_dos_posiciones:
	inc de			;4ae2
	ex de,hl			;4ae3
	ld e,(hl)			;4ae4   ; la primera posicion suelta
	inc hl			;4ae5
	ld d,(hl)			;4ae6
	ld (0e2b0h),de		;4ae7   ; guardada
	ld a,e			;4aeb
	or d			;4aec   ; si es cero, no hay segunda
	jr z,elige_el_reparto_de_la_zona		;4aed
	inc hl			;4aef
	ld e,(hl)			;4af0   ; y si la hay, se lee
	inc hl			;4af1
	ld d,(hl)			;4af2
elige_el_reparto_de_la_zona:
	ld (0e2b2h),de		;4af3   ; la segunda posicion
	ex de,hl			;4af7
	inc de			;4af8
	call es_zona_de_bonus		;4af9   ; las zonas de bonus van por otro camino
	jr nz,$+34		;4afc
	ld a,(0e052h)		;4afe   ; el numero de zona
	cp 051h		;4b01   ; por encima de 50 se resta una vuelta
	jr c,indexa_por_decenas		;4b03
	sub 050h		;4b05
indexa_por_decenas:
	srl a		;4b07   ; cuatro desplazamientos: la cifra de las decenas
	srl a		;4b09
	srl a		;4b0b
	srl a		;4b0d
	ld hl,04b18h		;4b0f   ; la tabla de 0x4b18
	call suma_a_a_hl		;4b12   ; indexada por esa cifra
	ld a,(hl)			;4b15
	jr $+9		;4b16

; ----------------------------------------------------------------------
; DATOS tabla_4b18: 6 bytes (00 00 01 02 03 04); la carga 0x4b0f
;   0x4b18..0x4b1e  (6 bytes)
DATA_tabla_4b18:
	defb 000h,000h,001h,002h,003h,004h	; 4b18

; ======================================================================
; CODIGO 0x4b1e..0x4c68  (330 bytes)
; ======================================================================


L_4B1E:
	ld a,(de)			;4b1e
siembra_los_enemigos:
	and a			;4b1f   ; sin enemigos no hay nada que sembrar
	jr z,lee_la_segunda_lista		;4b20
	ld b,a			;4b22
	ld hl,0e179h		;4b23   ; el primer bloque de enemigo
	push de			;4b26
	ld de,06099h		;4b27   ; los cinco bytes de arranque
siembra_un_enemigo:
	ld a,(de)			;4b2a   ; el valor de arranque
	ld (hl),a			;4b2b
	inc hl			;4b2c   ; y el byte de al lado, a cero
	ld (hl),000h		;4b2d
	ld a,02fh		;4b2f   ; 0x2F: lo que ocupa un bloque de enemigo menos uno
	call suma_a_a_hl		;4b31
	inc de			;4b34
	djnz siembra_un_enemigo		;4b35   ; hasta los B enemigos
	pop de			;4b37
lee_la_segunda_lista:
	inc de			;4b38
	ld a,(de)			;4b39   ; cuantas celdas lleva la segunda lista
	and a			;4b3a
	jr z,lee_lo_que_habia_debajo		;4b3b   ; si no lleva, se acabo
	ld b,a			;4b3d
	ld hl,03800h		;4b3e   ; el puntero, otra vez desde la tabla de nombres
	ld ix,0e2dfh		;4b41   ; donde se guardan las posiciones
	ld iy,0e090h		;4b45   ; y donde lo que habia antes
siembra_una_celda:
	inc de			;4b49   ; el desplazamiento
	ld a,(de)			;4b4a
	cp 0ffh		;4b4b   ; el 0xFF cierra
	jr z,lee_lo_que_habia_debajo		;4b4d
	ld c,a			;4b4f
	ld b,000h		;4b50
	add hl,bc			;4b52   ; sumado al puntero
	cp 0feh		;4b53   ; y el 0xFE solo suma
	jr z,siembra_una_celda		;4b55
	ld (ix+000h),l		;4b57   ; la posicion, guardada
	inc ix		;4b5a
	ld (ix+000h),h		;4b5c
	inc ix		;4b5f
	push hl			;4b61
	call 0004ah		;4b62   ; BIOS RDVRM - Reads the content of VRAM | lee lo que habia en esa celda
	pop hl			;4b65
	ld (iy+000h),a		;4b66   ; y lo guarda, para poder devolverlo
	inc iy		;4b69
	ld a,0b6h		;4b6b   ; el patron que se pone encima
	call 0004dh		;4b6d   ; BIOS WRTVRM - Writes data in VRAM
	push hl			;4b70
	ld hl,0e2b5h		;4b71   ; y una celda mas en la cuenta
	inc (hl)			;4b74
	pop hl			;4b75
	jr siembra_una_celda		;4b76

; ----------------------------------------------------------------------
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; Se apunta que habia en la pantalla debajo de cada objeto, para poder restaurarlo cuando el objeto desaparezca. Es lo que evita tener que repintar la zona entera.
; ----------------------------------------------------------------------
lee_lo_que_habia_debajo:
	ld a,(0e280h)		;4b78   ; cuantos objetos
	ld b,a			;4b7b
	and a			;4b7c
	ret z			;4b7d   ; sin objetos, nada que guardar
	ld ix,0e281h		;4b7e   ; sus posiciones
	ld de,0e295h		;4b82   ; y donde guardar lo que habia
guarda_una_celda_de_debajo:
	call lee_la_posicion		;4b85
	call 0004ah		;4b88   ; BIOS RDVRM - Reads the content of VRAM | lo que hay en la celda
	ld (de),a			;4b8b   ; guardado
	inc ix		;4b8c   ; la posicion siguiente, que son dos bytes
	inc ix		;4b8e
	inc de			;4b90
	djnz guarda_una_celda_de_debajo		;4b91   ; hasta acabarlos
	call pinta_las_dos_sueltas		;4b93
pinta_los_objetos:
	ld c,0b7h		;4b96   ; el patron de los objetos
pinta_los_objetos_con_patron:
	ld a,(0e280h)		;4b98   ; cuantos hay
	ld b,a			;4b9b
	and a			;4b9c
	ret z			;4b9d   ; sin objetos, se sale
	ld ix,0e281h		;4b9e   ; sus posiciones
pinta_un_objeto:
	call lee_la_posicion		;4ba2   ; la posicion del objeto
	ld a,h			;4ba5
	or l			;4ba6
	ret z			;4ba7   ; la posicion cero es un objeto ya cogido
	ld a,c			;4ba8
	bit 7,h		;4ba9   ; el bit alto marca los de otro tipo
	jr z,L_4BAF		;4bab
	sub 002h		;4bad   ; que llevan un patron dos mas abajo
L_4BAF:
	call 0004dh		;4baf   ; BIOS WRTVRM - Writes data in VRAM | y a la pantalla
	inc ix		;4bb2   ; el objeto siguiente
	inc ix		;4bb4
	djnz pinta_un_objeto		;4bb6
	ret			;4bb8
pinta_las_dos_sueltas:
	ld b,0b4h		;4bb9   ; su patron
L_4BBB:
	ld hl,(0e2b0h)		;4bbb   ; la primera
	call pinta_una_suelta		;4bbe
	ld hl,(0e2b2h)		;4bc1   ; y la segunda
pinta_una_suelta:
	ld a,h			;4bc4   ; si es cero no hay nada que pintar
	or l			;4bc5
	ret z			;4bc6
	ld a,b			;4bc7   ; su patron
	jp 0004dh		;4bc8   ; BIOS WRTVRM - Writes data in VRAM | y a la pantalla

; ----------------------------------------------------------------------
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; Un cuadro del protagonista: lee el mando, decide a donde puede ir, lo mueve y elige el dibujo.
; ----------------------------------------------------------------------
mueve_al_protagonista:
	ld ix,0e130h		;4bcb   ; el bloque del protagonista
	call traduce_el_mando		;4bcf
	call elige_el_dibujo		;4bd2
	call decide_el_giro		;4bd5
	call lee_el_decorado_alrededor		;4bd8
	call recoloca_si_hace_falta		;4bdb
	call es_zona_de_bonus		;4bde   ; en las zonas de bonus no hay enemigos que valgan
	jr z,decide_el_paso		;4be1
	call empuja_el_bloque		;4be3
decide_el_paso:
	ld ix,0e130h		;4be6   ; el bloque del protagonista
	call anima_al_protagonista		;4bea
	ld a,(ix+00ah)		;4bed   ; su estado
	and 00fh		;4bf0
	cp 002h		;4bf2   ; el 2 es el de estar subiendo
	jr z,sube_por_la_escalera		;4bf4
anda_por_el_suelo:
	ld a,(ix+009h)		;4bf6   ; las banderas de movimiento
	and 00ch		;4bf9
	ret nz			;4bfb   ; si esta ocupado, no se le manda nada nuevo
	ld a,(ix+00ah)		;4bfc
	and a			;4bff   ; parado?
	jr nz,comprueba_el_estado		;4c00
	ld hl,(0e058h)		;4c02   ; el tiempo que queda
	ld a,h			;4c05
	or l			;4c06
	ld c,007h		;4c07   ; con tiempo, uno de cada ocho cuadros
	jr nz,L_4C0D		;4c09
	ld c,003h		;4c0b   ; y sin tiempo, uno de cada cuatro: corre mas
L_4C0D:
	ld a,(0e003h)		;4c0d
	and c			;4c10   ; si no toca, se sale
	ret nz			;4c11
mira_si_puede_avanzar:
	ld a,(ix+02fh)		;4c12   ; la bandera de poder pasar
	and a			;4c15
	jr nz,prueba_las_direcciones		;4c16
	ld a,(ix+008h)		;4c18   ; su altura
	cp 090h		;4c1b   ; por debajo de 0x90 no se comprueba
	ret nc			;4c1d
prueba_las_direcciones:
	call esta_en_el_suelo		;4c1e   ; mira si hay suelo
	jr c,cae_o_se_agarra		;4c21   ; con acarreo, esta en el aire
	call va_en_la_direccion_pedida		;4c23   ; mira la direccion pedida
	jr nz,acepta_la_direccion		;4c26
	call esta_cuadrado		;4c28   ; y si se puede ir por ahi
	jr nz,acepta_la_direccion		;4c2b
	call esta_en_el_suelo		;4c2d   ; otra vez el suelo
	ret nc			;4c30   ; sin suelo, no se mueve
acepta_la_direccion:
	ld a,c			;4c31   ; la direccion nueva
	ld (ix+005h),a		;4c32
	call recoloca_si_hace_falta		;4c35   ; y se recoloca
	jr aplica_el_paso		;4c38
cae_o_se_agarra:
	call va_en_la_direccion_pedida		;4c3a   ; la direccion pedida
	jr z,aplica_el_paso		;4c3d
	xor c			;4c3f   ; comparada con la que llevaba
	cp 001h		;4c40   ; solo vale si es la contraria
	ret nz			;4c42
aplica_el_paso:
	ld a,(ix+009h)		;4c43   ; las dos direcciones posibles
	and 003h		;4c46
	jp anda_una_celda		;4c48   ; y a mover
sube_por_la_escalera:
	ld a,(ix+02fh)		;4c4b   ; la bandera de paso libre
	and a			;4c4e
	jr nz,L_4C56		;4c4f
	call esta_en_el_suelo		;4c51   ; mira si sigue habiendo escalera
	jr nc,anda_por_el_suelo		;4c54   ; si no, vuelve a andar
L_4C56:
	ld a,(ix+005h)		;4c56   ; y si si, sigue en la misma direccion
	jp anda_una_celda		;4c59
comprueba_el_estado:
	call va_en_la_direccion_pedida		;4c5c   ; la direccion pedida
	ret nz			;4c5f
	ld a,(ix+00ah)		;4c60   ; el estado
	cp 003h		;4c63   ; solo el 3 sigue
	ret nz			;4c65
	jr mira_si_puede_avanzar		;4c66

; ----------------------------------------------------------------------
; DATOS direcciones_4c68: las cuatro direcciones de una celda: (0,1) (0,-1)
;   (1,0) (-1,0); la cargan 0x509d y 0x53e2
;   0x4c68..0x4c70  (8 bytes)
DATA_direcciones_4c68:
	defb 000h,001h	; 4c68
	defb 000h,0ffh	; 4c6a
	defb 001h,000h	; 4c6c
	defb 0ffh,000h	; 4c6e

; ======================================================================
; CODIGO 0x4c70..0x4ebd  (589 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; El protagonista se dibuja con DOS sprites en el mismo sitio -0xE0B0 y 0xE0B4-, que es como se le da mas de un color en una maquina de un color por sprite.
; ----------------------------------------------------------------------
coloca_el_sprite_del_protagonista:
	ld hl,(0e130h)		;4c70   ; su posicion
	call encoge_cuatro		;4c73   ; centrada para un sprite de 16x16
	ld (0e0b0h),hl		;4c76   ; el primer sprite
	ld (0e0b4h),hl		;4c79   ; y el segundo, encima
	ret			;4c7c
coloca_el_sprite_del_martillo:
	ld hl,(0e154h)		;4c7d   ; donde esta
	call encoge_cuatro		;4c80   ; centrado
	ld (0e0c0h),hl		;4c83   ; y a su hueco de sprite
	ret			;4c86

; ----------------------------------------------------------------------
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; Atiende el boton de disparo. Solo sale martillo si no hay uno volando ya y si el protagonista esta bastante arriba.
; ----------------------------------------------------------------------
lanza_el_martillo:
	ld a,(0e153h)		;4c87   ; el estado del martillo
	bit 7,a		;4c8a   ; el bit 7 dice que ya hay uno volando
	jp nz,vuela_el_martillo		;4c8c
	ld a,(0e009h)		;4c8f   ; las pulsaciones nuevas
	and 010h		;4c92   ; el bit 4 es el disparo
	ret z			;4c94   ; sin disparo no hay martillo
	ld a,(0e067h)		;4c95   ; el estado de la partida
	and 003h		;4c98
	ret nz			;4c9a   ; acabando la zona, tampoco
	ld a,(0e137h)		;4c9b   ; la altura del protagonista
	cp 090h		;4c9e
	ret nc			;4ca0   ; por debajo de 0x90 no se lanza
	ld ix,0e130h		;4ca1
	call esta_cuadrado		;4ca5   ; mira si esta bien colocado
	jr z,saca_el_martillo		;4ca8
	ld a,(0e157h)		;4caa   ; la altura del martillo anterior
	cp 090h		;4cad
	ret nc			;4caf
saca_el_martillo:
	ld a,(0e135h)		;4cb0   ; la direccion del protagonista
	ld c,a			;4cb3
	ld a,(0e153h)		;4cb4   ; el estado del martillo
	set 7,a		;4cb7   ; el bit 7: ya esta volando
	add a,c			;4cb9   ; con la direccion pegada
	ld (0e153h),a		;4cba
	ld a,(0e135h)		;4cbd   ; la direccion, otra vez
	add a,a			;4cc0   ; por cuatro
	add a,a			;4cc1
	add a,040h		;4cc2   ; mas 0x40: el patron del martillo que toca
	ld (0e0c2h),a		;4cc4   ; a su hueco de sprite
	ld hl,0539eh		;4cc7   ; la tabla de las cuatro direcciones
	ld a,(0e135h)		;4cca
	call suma_el_paso		;4ccd   ; el paso que le corresponde
	ld (0e154h),hl		;4cd0   ; y ahi arranca
	ld a,(0e157h)		;4cd3   ; la altura del protagonista
	ld (0e156h),a		;4cd6
	call coloca_el_sprite_del_martillo		;4cd9   ; coloca el sprite
	ld a,084h		;4cdc   ; y suena el lanzamiento
	jp suena		;4cde

; ----------------------------------------------------------------------
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; Mide a que distancia esta cada uno de los cuatro enemigos del martillo y se queda con el mas cercano. Segun la direccion mira la fila o la columna, y por eso intercambia D y E antes de empezar.
; ----------------------------------------------------------------------
busca_el_enemigo_mas_cercano:
	ld de,(0e154h)		;4ce1   ; donde esta el martillo
	ld ix,0e160h		;4ce5   ; el primer enemigo
	ld iy,0e161h		;4ce9   ; y su otra coordenada
	ld a,(0e153h)		;4ced   ; la direccion del martillo
	bit 1,a		;4cf0   ; el bit 1 separa horizontal de vertical
	jr nz,mide_los_cuatro		;4cf2
	dec iy		;4cf4   ; en horizontal se miran las coordenadas cambiadas
	inc ix		;4cf6
	ld a,e			;4cf8   ; y las del martillo tambien
	ld e,d			;4cf9
	ld d,a			;4cfa
mide_los_cuatro:
	ld b,004h		;4cfb   ; los cuatro enemigos
	ld hl,0e2a0h		;4cfd   ; donde se apuntan las cuatro distancias
mide_un_enemigo:
	push de			;4d00   ; guarda la posicion del martillo
	ld a,d			;4d01
	ld d,(iy+000h)		;4d02   ; la coordenada del enemigo
	cp d			;4d05   ; si no comparten fila, no cuenta
	ld a,07fh		;4d06   ; 0x7F es la distancia de "ni se le acerca"
	jr nz,apunta_la_distancia		;4d08
	ld d,(ix+000h)		;4d0a   ; comparten: se mide de verdad
	ld a,e			;4d0d
	sub d			;4d0e   ; la resta
	jr nc,apunta_la_distancia		;4d0f
	neg		;4d11   ; en valor absoluto
apunta_la_distancia:
	ld (hl),a			;4d13   ; la distancia de este enemigo
	inc hl			;4d14
	ld de,00030h		;4d15   ; el bloque de enemigo mide 0x30
	add ix,de		;4d18
	pop de			;4d1a
	djnz mide_un_enemigo		;4d1b   ; los cuatro
	ld b,003h		;4d1d   ; ahora se compara: quedan tres comparaciones
	ld e,000h		;4d1f   ; el indice del mejor
	ld hl,0e2a0h		;4d21   ; la primera distancia
	ld a,(hl)			;4d24
	inc hl			;4d25
busca_la_menor:
	ld c,(hl)			;4d26   ; la siguiente distancia
	cp c			;4d27   ; si la de antes es menor, se queda
	jr c,pasa_a_la_siguiente		;4d28
	inc e			;4d2a   ; y si no, este es el nuevo mejor
	ld a,c			;4d2b
pasa_a_la_siguiente:
	inc hl			;4d2c
	djnz busca_la_menor		;4d2d   ; hasta las tres
	ld b,e			;4d2f   ; el indice del mas cercano
	ld a,e			;4d30
	and a			;4d31
	ld ix,0e160h		;4d32   ; el primer bloque de enemigo
	ld iy,0e05eh		;4d36   ; y su hueco de estado
	jr z,prueba_el_golpe_en_todos		;4d3a   ; si es el primero, ya esta
	ld de,00030h		;4d3c   ; cada bloque mide 0x30
salta_al_enemigo_elegido:
	add ix,de		;4d3f   ; el bloque siguiente
	inc iy		;4d41   ; y su hueco de estado, de dos en dos
	inc iy		;4d43
	djnz salta_al_enemigo_elegido		;4d45   ; hasta llegar al elegido

; ----------------------------------------------------------------------
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; Prueba el golpe primero en el enemigo mas cercano y luego en los cuatro por orden. Asi el mas cercano tiene preferencia aunque dos esten a tiro.
; ----------------------------------------------------------------------
prueba_el_golpe_en_todos:
	call prueba_el_golpe		;4d47   ; el mas cercano, primero
	ld ix,0e160h		;4d4a   ; y luego los cuatro por orden
	ld iy,0e05eh		;4d4e
	call prueba_el_golpe		;4d52
	ld ix,0e190h		;4d55
	ld iy,0e060h		;4d59
	call prueba_el_golpe		;4d5d
	ld ix,0e1c0h		;4d60
	ld iy,0e062h		;4d64
	call prueba_el_golpe		;4d68
	ld ix,0e1f0h		;4d6b
	ld iy,0e064h		;4d6f

; ----------------------------------------------------------------------
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; Mira si el martillo alcanza a este enemigo y, si lo alcanza, lo mata: cien puntos, el sonido y el enemigo escondido.
; ----------------------------------------------------------------------
prueba_el_golpe:
	ld a,(ix+019h)		;4d73   ; el enemigo esta en juego?
	and a			;4d76
	ret z			;4d77   ; si no, no hay nada que golpear
	call es_zona_de_bonus		;4d78   ; las zonas de bonus van por otro camino
	jp z,L_4E2B		;4d7b
	ld a,(0e2b5h)		;4d7e   ; el estado del protagonista
	cp 01fh		;4d81   ; el 0x1F no golpea
	ret z			;4d83
	ld a,(ix+001h)		;4d84   ; la altura del enemigo
	cp 020h		;4d87
	ret c			;4d89   ; fuera del area de juego, no cuenta
	cp 0d9h		;4d8a
	ret nc			;4d8c
	ld hl,(0e154h)		;4d8d   ; donde esta el martillo
	ld e,(ix+000h)		;4d90   ; y donde el enemigo
	ld d,(ix+001h)		;4d93
	ld a,d			;4d96
	cp 028h		;4d97   ; los bordes de la zona util
	jr c,mira_la_franja_central		;4d99
	cp 0d0h		;4d9b   ; por arriba
	jr c,comprueba_el_alcance		;4d9d
mira_la_franja_central:
	ld a,e			;4d9f   ; la otra coordenada
	cp 050h		;4da0   ; y su franja
	jr c,comprueba_el_alcance		;4da2
	cp 070h		;4da4
	jp c,aplasta_al_enemigo		;4da6
comprueba_el_alcance:
	ld c,006h		;4da9   ; seis pixeles de margen
	call estan_cerca		;4dab   ; estan lo bastante cerca?
	ret nc			;4dae   ; si no, no hay golpe
	ld a,(0e153h)		;4daf   ; la direccion del martillo
	and 07fh		;4db2
	cp 002h		;4db4   ; las direcciones 0 y 2 se cuadran a la rejilla
	jr z,cuadra_a_la_rejilla		;4db6
	and a			;4db8
	jr z,cuadra_a_la_rejilla		;4db9
	ld l,e			;4dbb   ; y las otras dos van tal cual
	ld h,d			;4dbc
	jr golpea_al_enemigo		;4dbd

; ----------------------------------------------------------------------
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; Redondea la posicion del golpe a la celda de ocho en ocho, hacia arriba: asi el destello sale centrado en la casilla y no a medio camino.
; ----------------------------------------------------------------------
cuadra_a_la_rejilla:
	ld a,e			;4dbf   ; la coordenada
	and 007h		;4dc0   ; ya es multiplo de ocho?
	ld a,e			;4dc2
	jr z,cuadra_la_otra		;4dc3
	and 0f8h		;4dc5   ; si no, se baja a multiplo
	add a,008h		;4dc7   ; y se sube una celda
cuadra_la_otra:
	ld l,a			;4dc9
	ld a,d			;4dca
	and 007h		;4dcb   ; la otra coordenada
	ld a,d			;4dcd
	jr z,L_4DD4		;4dce
	and 0f8h		;4dd0   ; igual
	add a,008h		;4dd2
L_4DD4:
	ld h,a			;4dd4
golpea_al_enemigo:
	call celda_de_coordenadas		;4dd5   ; la celda de la pantalla
	ld (iy+000h),l		;4dd8   ; guardada
	ld (iy+001h),h		;4ddb
	push hl			;4dde
	call 0004ah		;4ddf   ; BIOS RDVRM - Reads the content of VRAM | lo que hay en esa celda
	cp 0b6h		;4de2   ; si es el patron de relleno, no vale
	pop hl			;4de4
	ret z			;4de5
	ld c,a			;4de6
	ld de,(0e252h)		;4de7   ; la casilla del protagonista
	ld a,l			;4deb
	cp e			;4dec   ; no se golpea en la propia casilla
	jr nz,mata_al_enemigo		;4ded
	ld a,h			;4def
	cp d			;4df0
	ret z			;4df1
mata_al_enemigo:
	push hl			;4df2
	call apunta_el_destello		;4df3   ; el destello del golpe
	ld hl,0e33fh		;4df6   ; el contador de enemigos cazados
	inc (hl)			;4df9   ; uno mas
	ld (ix+01dh),081h		;4dfa   ; el enemigo pasa a estado de muerto
	ld e,(ix+000h)		;4dfe   ; donde estaba
	ld d,(ix+001h)		;4e01
	ld (ix+000h),0e0h		;4e04   ; y su sprite, escondido
	ld a,0ffh		;4e08   ; con el patron apagado
	ld (ix+002h),a		;4e0a
	ld (ix+003h),a		;4e0d
	push ix		;4e10
	ld c,00ah		;4e12   ; diez pasos de animacion
	call contagia_a_los_vecinos		;4e14
	pop ix		;4e17
	pop hl			;4e19
	call direccion_de_patron		;4e1a   ; la celda donde estaba
	ex de,hl			;4e1d
	ld c,00ah		;4e1e   ; y otros diez
	call contagia_a_los_vecinos		;4e20
	ld de,00100h		;4e23   ; cien puntos por enemigo
	call suma_al_marcador		;4e26
	jr suena_el_golpe		;4e29
L_4E2B:
	ld hl,(0e154h)		;4e2b
	ld e,(ix+000h)		;4e2e
	ld d,(ix+001h)		;4e31
aplasta_al_enemigo:
	ld c,006h		;4e34   ; seis pixeles de margen
	call estan_cerca		;4e36   ; estan lo bastante cerca?
	ret nc			;4e39
	ld (ix+01dh),001h		;4e3a   ; el enemigo pasa a aplastado
	ld (ix+000h),0e0h		;4e3e   ; y su sprite se esconde
	ld a,0ffh		;4e42
	ld (ix+002h),a		;4e44   ; con el patron apagado
	ld (ix+003h),a		;4e47
suena_el_golpe:
	call guarda_el_martillo		;4e4a   ; apunta la baja
	ld a,005h		;4e4d   ; y su sonido
	jp suena		;4e4f

; ----------------------------------------------------------------------
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; Cuando cae un enemigo, los otros se enteran: la tabla de 0x4ebd dice, para cada uno, cuales son sus tres vecinos, y a esos se les da la vuelta.
; ----------------------------------------------------------------------
contagia_a_los_vecinos:
	ld a,(ix+019h)		;4e52   ; cual ha caido
	ld hl,04ebdh		;4e55   ; la tabla de vecinos
	dec a			;4e58   ; la fila que le toca
	add a,a			;4e59   ; de cuatro en cuatro
	add a,a			;4e5a
	call suma_a_a_hl		;4e5b
	ld (0e2a2h),hl		;4e5e   ; la fila, guardada
	ld b,003h		;4e61   ; tres vecinos por enemigo
contagia_a_un_vecino:
	push bc			;4e63
	ld hl,(0e2a2h)		;4e64   ; la fila de vecinos
	ld a,(hl)			;4e67   ; el vecino que toca
	inc hl			;4e68
	ld (0e2a2h),hl		;4e69   ; y se apunta el siguiente
	push de			;4e6c
	ld ix,0e160h		;4e6d   ; el primer bloque de enemigo
	dec a			;4e71   ; el vecino 1 es ese mismo
	jr z,da_la_vuelta_al_vecino		;4e72
	ld b,a			;4e74
salta_al_bloque_del_vecino:
	ld de,00030h		;4e75   ; cada bloque mide 0x30
	add ix,de		;4e78
	djnz salta_al_bloque_del_vecino		;4e7a   ; hasta llegar al vecino
da_la_vuelta_al_vecino:
	pop de			;4e7c
	ld a,(ix+019h)		;4e7d   ; el vecino esta en juego?
	and a			;4e80
	jr z,sigue_con_los_vecinos		;4e81   ; si no, no se le da la vuelta
	ld a,(ix+01dh)		;4e83   ; ya esta muerto?
	and a			;4e86
	jr nz,sigue_con_los_vecinos		;4e87
	ld a,(ix+026h)		;4e89   ; o ya se ha dado la vuelta este cuadro?
	and a			;4e8c
	jr nz,sigue_con_los_vecinos		;4e8d
	call lee_la_posicion		;4e8f   ; donde esta
	call estan_cerca		;4e92   ; esta lo bastante cerca?
	jr nc,sigue_con_los_vecinos		;4e95   ; si no, no se entera
	ld a,(ix+005h)		;4e97   ; su direccion
	and 002h		;4e9a   ; el bit 1 se queda
	ld c,a			;4e9c
	ld a,(ix+005h)		;4e9d
	cpl			;4ea0   ; y el bit 0 se invierte: media vuelta
	and 001h		;4ea1
	or c			;4ea3
	ld (ix+004h),a		;4ea4   ; la direccion nueva
	push de			;4ea7
	call elige_el_dibujo		;4ea8   ; se recoloca
	ld a,(ix+004h)		;4eab
	ld (ix+005h),a		;4eae
	call recoloca_si_hace_falta		;4eb1
	pop de			;4eb4
	ld (ix+026h),001h		;4eb5   ; y se marca para no repetirlo este cuadro
sigue_con_los_vecinos:
	pop bc			;4eb9
	djnz contagia_a_un_vecino		;4eba   ; los tres
	ret			;4ebc

; ----------------------------------------------------------------------
; DATOS tabla_4ebd: cuatro filas de cuatro; la carga 0x4e55
;   0x4ebd..0x4ecd  (16 bytes)
DATA_tabla_4ebd:
	defb 002h,003h,004h,005h	; 4ebd
	defb 001h,002h,003h,005h	; 4ec1
	defb 001h,002h,004h,005h	; 4ec5
	defb 001h,003h,004h,005h	; 4ec9

; ======================================================================
; CODIGO 0x4ecd..0x511c  (591 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; Mira si el protagonista ha alcanzado la fila de meta, que son las alturas 0xB4 y 0xB5.
; ----------------------------------------------------------------------
mira_si_ha_llegado_arriba:
	ld a,(0e137h)		;4ecd   ; su altura
	cp 0b4h		;4ed0   ; la fila de meta
	jr z,L_4ED7		;4ed2
	cp 0b5h		;4ed4   ; o la de al lado
	ret nz			;4ed6
L_4ED7:
	ld ix,0e130h		;4ed7
	call esta_cuadrado		;4edb   ; y bien colocado
	ret nz			;4ede
marca_la_llegada:
	ld hl,0e067h		;4edf   ; las banderas del final
	bit 0,(hl)		;4ee2   ; si ya esta acabando, no se toca
	ret nz			;4ee4
	set 1,(hl)		;4ee5   ; y si no, se marca la llegada
	ret			;4ee7

; ----------------------------------------------------------------------
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; Mira las cuatro esquinas del protagonista, una por una, por si alguna cae sobre un objeto que se pueda coger.
; ----------------------------------------------------------------------
mira_los_cuatro_objetos:
	ld de,0e13bh		;4ee8   ; la primera esquina
	ld hl,(0e141h)		;4eeb   ; y su posicion
	call mira_una_esquina		;4eee
	ld de,0e13ch		;4ef1   ; la segunda
	ld hl,(0e143h)		;4ef4
	call mira_una_esquina		;4ef7
	ld de,0e13dh		;4efa   ; la tercera
	ld hl,(0e145h)		;4efd
	call mira_una_esquina		;4f00
	ld de,0e13eh		;4f03   ; y la cuarta
	ld hl,(0e147h)		;4f06
mira_una_esquina:
	ld a,(de)			;4f09   ; lo que hay en esa esquina

; ----------------------------------------------------------------------
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; Si en la casilla hay un objeto de los que se cogen -los patrones 0xB7 y 0xB8-, lo borra devolviendo lo que habia debajo y da los puntos.
; ----------------------------------------------------------------------
coge_el_objeto:
	ld (0e13fh),hl		;4f0a   ; la casilla, guardada
	cp 0b7h		;4f0d   ; el patron de objeto
	jr z,quita_el_objeto_cogido		;4f0f
	cp 0b8h		;4f11   ; o el otro
	ret nz			;4f13   ; cualquier otra cosa no se coge
quita_el_objeto_cogido:
	call busca_la_casilla_en_la_lista		;4f14   ; busca la casilla en la lista de objetos
	and a			;4f17
	ret z			;4f18   ; si no esta, no era un objeto de la lista
	dec a			;4f19   ; su posicion en la lista
	ld (0e2a0h),a		;4f1a
	ld hl,0e295h		;4f1d   ; lo que habia debajo
	call suma_a_a_hl		;4f20
	ld a,(hl)			;4f23   ; ese patron
	ld hl,(0e13fh)		;4f24   ; en la casilla del objeto
	call 0004dh		;4f27   ; BIOS WRTVRM - Writes data in VRAM | devuelto a la pantalla
	ld a,(0e2a0h)		;4f2a   ; el objeto que se ha cogido
	ld hl,0e281h		;4f2d   ; se saca de la lista de posiciones
	call borra_la_posicion		;4f30
	ld hl,0e281h		;4f33   ; y de la de lo que habia debajo
	ld de,0e295h		;4f36
	ld b,00ah		;4f39   ; los diez huecos
	call saca_de_la_lista		;4f3b
	ld de,(0e016h)		;4f3e   ; los puntos, que suben con el reloj de la zona
	call suma_al_marcador		;4f42
	ld hl,0e280h		;4f45   ; los objetos que quedan
	dec (hl)			;4f48   ; uno menos
	jr nz,suena_el_objeto		;4f49   ; si quedan, sigue la zona
	ld a,(0e2b5h)		;4f4b   ; el estado del protagonista
	cp 01fh		;4f4e
	jr z,suena_el_objeto		;4f50
	ld a,001h		;4f52   ; no queda ninguno: la zona esta hecha
	ld (0e067h),a		;4f54
	ld a,08ch		;4f57   ; y suena el aviso
	jr L_4F5D		;4f59
suena_el_objeto:
	ld a,086h		;4f5b   ; el sonido de coger
L_4F5D:
	jp suena		;4f5d

; ----------------------------------------------------------------------
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; Mueve todo lo que se mueve de fondo, alternando dos juegos de animaciones segun el bit 0 del contador de cuadros.
; ----------------------------------------------------------------------
anima_el_decorado:
	ld a,(0e003h)		;4f60   ; el contador de cuadros
	rra			;4f63   ; su bit 0 alterna los dos juegos
	jr c,anima_el_otro_juego		;4f64
	ld hl,(0e2b6h)		;4f66   ; el reloj de la animacion
	inc hl			;4f69   ; uno mas
	ld (0e2b6h),hl		;4f6a
	call dibuja_al_enemigo_uno		;4f6d
	call dibuja_al_enemigo_dos		;4f70
	jr L_4F7E		;4f73
anima_el_otro_juego:
	call dibuja_al_enemigo_tres		;4f75
	call dibuja_al_enemigo_cuatro		;4f78
	call mueve_al_enemigo_grande		;4f7b
L_4F7E:
	ld a,(0e003h)		;4f7e   ; el contador de cuadros
	bit 1,a		;4f81   ; el bit 1
	jr z,reparte_el_dibujo_del_final		;4f83
	ld hl,0e341h		;4f85   ; el otro reloj de animacion
	inc (hl)			;4f88
reparte_el_dibujo_del_final:
	ld a,(0e340h)		;4f89   ; el estado del final de zona
	ld c,a			;4f8c
	and a			;4f8d
	jp z,cuenta_para_el_derrumbe		;4f8e   ; sin estado, el dibujo normal
	rra			;4f91   ; el bit 0 elige entre los otros dos
	jp c,busca_por_donde_derrumbar		;4f92
	jp anima_el_derrumbe		;4f95

; ----------------------------------------------------------------------
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; Los objetos parpadean cambiando de patron cada dieciseis cuadros.
; ----------------------------------------------------------------------
parpadea_los_objetos:
	ld a,(0e003h)		;4f98   ; el contador de cuadros
	ld c,a			;4f9b
	and 00fh		;4f9c   ; uno de cada dieciseis
	ret nz			;4f9e
	ld a,c			;4f9f
	and 010h		;4fa0   ; el bit 4 elige el patron
	jp nz,pinta_los_objetos		;4fa2
	ld c,0b8h		;4fa5   ; y el otro
	jp pinta_los_objetos_con_patron		;4fa7
parpadea_las_dos_sueltas:
	ld hl,0e2b4h		;4faa   ; su reloj
	inc (hl)			;4fad   ; uno mas
	ld a,(hl)			;4fae
	and 003h		;4faf   ; tres de cada cuatro con un patron
	jp nz,pinta_las_dos_sueltas		;4fb1
	ld b,0b5h		;4fb4   ; y uno con el otro
	jp L_4BBB		;4fb6

; ----------------------------------------------------------------------
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; La animacion del decorado que fluye. Cuando queda tiempo va a un ritmo y cuando se acaba, al doble: es la prisa que mete el juego al final de la zona.
; ----------------------------------------------------------------------
anima_los_patrones:
	ld hl,(0e058h)		;4fb9   ; el tiempo que queda
	ld a,h			;4fbc
	or l			;4fbd
	ld bc,00307h		;4fbe   ; con tiempo, ritmo normal
	jr nz,elige_la_animacion		;4fc1
	ld bc,00107h		;4fc3   ; sin tiempo, el doble de rapido
elige_la_animacion:
	ld a,(0e003h)		;4fc6   ; el contador de cuadros
	ld d,a			;4fc9
	and b			;4fca   ; si no toca, se sale
	ret nz			;4fcb
	ld a,d			;4fcc
	and c			;4fcd   ; el otro ritmo
	bit 2,a		;4fce   ; y el bit 2 elige cual de las dos animaciones
	jr z,desplaza_los_patrones		;4fd0
	ld hl,0e2b8h		;4fd2   ; los ocho patrones que rotan
	ld b,008h		;4fd5   ; los ocho bytes del primero
rota_a_la_derecha:
	ld a,(hl)			;4fd7   ; el byte del dibujo
	rrca			;4fd8   ; rotado un pixel: eso es toda la animacion
	ld (hl),a			;4fd9
	inc hl			;4fda
	djnz rota_a_la_derecha		;4fdb
	ld b,008h		;4fdd   ; y los ocho del segundo
rota_a_la_izquierda:
	ld a,(hl)			;4fdf   ; el byte
	rlca			;4fe0   ; rotado al otro lado
	ld (hl),a			;4fe1
	inc hl			;4fe2
	djnz rota_a_la_izquierda		;4fe3   ; los ocho
	ld hl,0e2b8h		;4fe5   ; el bloque animado
	ld (0e2a0h),hl		;4fe8
	ld e,l			;4feb
	ld d,h			;4fec
	ld hl,02400h		;4fed   ; y su sitio en la memoria de video
	jr vuelca_a_los_tres_tercios		;4ff0

; ----------------------------------------------------------------------
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; La otra animacion: en vez de rotar los bits de cada byte, mueve los BYTES enteros una fila, con un `lddr` en un sentido y un `ldir` en el otro, y da la vuelta al que se sale. Un desplazamiento vertical en vez de horizontal.
; ----------------------------------------------------------------------
desplaza_los_patrones:
	ld hl,0e2ceh		;4ff2   ; el ultimo byte del bloque
	ld de,0e2cfh		;4ff5
	ld a,(de)			;4ff8   ; se guarda, que se va a perder
	ld bc,00007h		;4ff9   ; siete bytes
	lddr		;4ffc   ; bajados una fila
	ld (0e2c8h),a		;4ffe   ; y el que sobraba, arriba del todo
	ld hl,0e2d1h		;5001   ; el segundo bloque
	ld de,0e2d0h		;5004
	ld a,(de)			;5007
	ld bc,00007h		;5008
	ldir		;500b   ; subidos una fila
	ld (0e2d7h),a		;500d   ; y el que sobraba, abajo
	ld hl,0e2c8h		;5010
	ld (0e2a0h),hl		;5013   ; el bloque animado
	ld e,l			;5016
	ld d,h			;5017
	ld hl,02410h		;5018   ; y su sitio

; ----------------------------------------------------------------------
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; Los bloques animados hay que dejarlos en los TRES tercios de la pantalla, porque en este modo cada tercio tiene su propia copia de los patrones. De ahi los dos saltos de 0x800.
; ----------------------------------------------------------------------
vuelca_a_los_tres_tercios:
	push hl			;501b
	ld bc,00010h		;501c   ; dieciseis bytes
	call vuelca_a_vram		;501f   ; al primer tercio
	pop hl			;5022
	ld de,00800h		;5023   ; 0x800 es lo que ocupa un tercio
	add hl,de			;5026
	push hl			;5027
	ld de,(0e2a0h)		;5028
	ld bc,00010h		;502c
	call vuelca_a_vram		;502f   ; al segundo
	pop hl			;5032
	ld de,00800h		;5033
	add hl,de			;5036   ; y otro tercio mas
	ld de,(0e2a0h)		;5037
	ld bc,00010h		;503b
	jp vuelca_a_vram		;503e   ; al tercero

; ----------------------------------------------------------------------
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; Busca una casilla en la lista de objetos y devuelve su numero, o cero si no esta.
; ----------------------------------------------------------------------
busca_la_casilla_en_la_lista:
	ld bc,00a01h		;5041   ; diez objetos, empezando a contar en 1
	ld de,0e281h		;5044   ; la lista de posiciones
compara_una_posicion:
	ld a,(de)			;5047   ; el byte bajo
	inc de			;5048
	cp l			;5049   ; comparado
	jr nz,pasa_al_siguiente_objeto		;504a
	ld a,(de)			;504c   ; y el alto
	cp h			;504d
	jr nz,pasa_al_siguiente_objeto		;504e
	ld a,c			;5050   ; coinciden: este es
	ret			;5051
pasa_al_siguiente_objeto:
	inc c			;5052   ; el numero siguiente
	inc de			;5053
	djnz compara_una_posicion		;5054   ; hasta los diez
	xor a			;5056   ; y si no esta, cero
	ret			;5057

; ----------------------------------------------------------------------
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; Saca un elemento de las dos listas paralelas -posiciones y lo que hay debajo- y aprieta las dos con sendos `ldir` para que no queden huecos.
; ----------------------------------------------------------------------
saca_de_la_lista:
	push hl			;5058   ; la otra lista, guardada
	ld a,(0e2a0h)		;5059   ; cual se saca
	inc a			;505c
	ld c,a			;505d
	ld a,b			;505e
	sub c			;505f   ; cuantos quedan por detras
	jr z,saca_el_ultimo		;5060   ; si es el ultimo, mas facil
	ld c,a			;5062
	ld a,(0e2a0h)		;5063
	call suma_a_a_de		;5066   ; al elemento que se saca
	ld a,c			;5069
	ld l,e			;506a
	ld h,d			;506b
	inc hl			;506c   ; el de detras
	ld b,000h		;506d
	ldir		;506f   ; y todos hacia delante
	add a,a			;5071
	ld c,a			;5072
	xor a			;5073
	ld (de),a			;5074   ; el hueco del final, a cero
	ld a,(0e2a0h)		;5075
	add a,a			;5078   ; en la otra lista los elementos son de dos bytes
	pop hl			;5079
	ex de,hl			;507a
	call suma_a_a_de		;507b   ; al que se saca
	ld l,e			;507e
	ld h,d			;507f
	inc hl			;5080
	inc hl			;5081
	ld b,000h		;5082
	ldir		;5084   ; y todos hacia delante
	xor a			;5086
	ld (de),a			;5087   ; con los dos bytes del final a cero
	inc de			;5088
	ld (de),a			;5089
	ret			;508a
saca_el_ultimo:
	dec b			;508b   ; el ultimo
	ld a,b			;508c
	call suma_a_a_de		;508d
	xor a			;5090   ; a cero
	ld (de),a			;5091
	pop hl			;5092
	ld a,b			;5093
borra_la_posicion:
	add a,a			;5094   ; dos bytes por elemento
	call suma_a_a_hl		;5095
	xor a			;5098
	ld (hl),a			;5099   ; la posicion, a cero
	inc hl			;509a
	ld (hl),a			;509b   ; los dos bytes
	ret			;509c
anda_una_celda:
	ld hl,04c68h		;509d   ; las cuatro direcciones de una celda
	call suma_el_paso		;50a0
	ld (ix+000h),l		;50a3   ; la posicion nueva
	ld (ix+001h),h		;50a6
	ret			;50a9
anda_ocho_pixeles:
	ld hl,0539eh		;50aa   ; las cuatro direcciones de ocho pixeles

; ----------------------------------------------------------------------
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; Suma a la posicion el paso que dice la tabla para la direccion A.
; ----------------------------------------------------------------------
suma_el_paso:
	call lee_puntero_de_tabla		;50ad   ; el paso de esa direccion
	ld l,(ix+000h)		;50b0   ; la posicion actual
	ld h,(ix+001h)		;50b3
	ld a,l			;50b6
	add a,e			;50b7   ; sumado el paso en X
	ld l,a			;50b8
	ld a,h			;50b9
	add a,d			;50ba   ; y en Y
	ld h,a			;50bb
	ret			;50bc

; ----------------------------------------------------------------------
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; Dice si esta cuadrado en la rejilla: las dos coordenadas multiplo de ocho. Devuelve Z cuando lo esta, y es lo que se pregunta antes de dejar girar.
; ----------------------------------------------------------------------
esta_cuadrado:
	ld a,(ix+000h)		;50bd   ; la X
	and 007h		;50c0   ; multiplo de ocho?
	ld l,a			;50c2
	ld a,(ix+001h)		;50c3   ; y la Y
	and 007h		;50c6
	or l			;50c8   ; las dos a la vez
	ret			;50c9
esta_en_el_suelo:
	ld a,(ix+007h)		;50ca   ; lo que hay bajo los pies
	cp 090h		;50cd   ; por debajo de 0x90 hay suelo
	ret			;50cf

; ----------------------------------------------------------------------
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; Dice si dos puntos estan a menos de C pixeles, mirando las dos coordenadas por separado. Es una caja, no un circulo: mas barato y suficiente.
; ----------------------------------------------------------------------
estan_cerca:
	ld a,l			;50d0   ; la diferencia en X
	sub e			;50d1
	jr nc,L_50D6		;50d2
	neg		;50d4   ; en valor absoluto
L_50D6:
	cp c			;50d6   ; comparada con el margen
	ret nc			;50d7   ; si se pasa, no estan cerca
	ld a,h			;50d8
	sub d			;50d9   ; y ahora en Y
	jr nc,L_50DE		;50da
	neg		;50dc
L_50DE:
	cp c			;50de   ; contra el mismo margen
	ret			;50df
va_en_la_direccion_pedida:
	ld a,(ix+009h)		;50e0   ; la direccion que permite el decorado
	and 003h		;50e3
	ld c,a			;50e5
	ld a,(ix+005h)		;50e6   ; y la que lleva
	cp c			;50e9   ; comparadas
	ret			;50ea
lee_la_posicion:
	ld l,(ix+000h)		;50eb   ; la X
	ld h,(ix+001h)		;50ee   ; y la Y
	ret			;50f1

; ----------------------------------------------------------------------
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; DE = tabla[A], con la tabla en HL y entradas de 16 bits. Es la mitad de abajo del despachador, y tambien se llama suelta para leer tablas de DATOS: diez sitios del cartucho la usan.
; ----------------------------------------------------------------------
lee_puntero_de_tabla:
	add a,a			;50f2   ; A por dos, que las entradas son palabras
	call suma_a_a_hl		;50f3   ; HL apunta ya a la entrada
	ld e,(hl)			;50f6   ; byte bajo del puntero
	inc hl			;50f7
	ld d,(hl)			;50f8   ; y byte alto: DE = tabla[A]
	ret			;50f9
L_50FA:
	ld a,099h		;50fa
	jp suena		;50fc

; ----------------------------------------------------------------------
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; Convierte el bit del mando en un numero de direccion de 0 a 3, o 0xFF si no hay ninguna pulsada. Es el numero con el que se indexan las tablas de pasos.
; ----------------------------------------------------------------------
traduce_el_mando:
	ld a,(0e010h)		;50ff   ; la direccion pulsada
	ld c,000h		;5102   ; empezando por la 3
	rra			;5104   ; arriba
	jr c,direccion_cero		;5105
	rra			;5107   ; abajo
	jr c,L_5115		;5108
	rra			;510a   ; izquierda
	jr c,L_5116		;510b
	rra			;510d   ; derecha
	jr c,guarda_la_direccion_pedida		;510e
	ld c,0ffh		;5110   ; y sin nada pulsado, 0xFF
	jr guarda_la_direccion_pedida		;5112
direccion_cero:
	inc c			;5114   ; cada `inc` que se salta sube el numero
L_5115:
	inc c			;5115
L_5116:
	inc c			;5116
guarda_la_direccion_pedida:
	ld a,c			;5117   ; la direccion, de 0 a 3
	ld (0e134h),a		;5118   ; guardada para el resto del cuadro
	ret			;511b

; ----------------------------------------------------------------------
; DATOS mascaras_de_direccion: 08 04 02 01, los cuatro bits de direccion del
;   mando
;   0x511c..0x5120  (4 bytes)
DATA_mascaras_de_direccion:
	defb 008h,004h,002h,001h	; 511c

; ======================================================================
; CODIGO 0x5120..0x5286  (358 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; Decide si el giro que se pide se puede hacer. Media vuelta se permite siempre, aunque no se este cuadrado; girar noventa grados exige estar en el centro de una casilla.
; ----------------------------------------------------------------------
decide_el_giro:
	ld a,(ix+004h)		;5120   ; la direccion pedida
	inc a			;5123   ; 0xFF es "ninguna"
	jr z,sigue_recto		;5124
	ld a,(ix+005h)		;5126   ; la que lleva
	ld c,a			;5129
	ld a,(ix+004h)		;512a
	ld b,a			;512d
	cp c			;512e   ; si es la misma, no hay giro
	jr z,marca_si_esta_cuadrado		;512f
	xor c			;5131   ; comparadas
	cp 001h		;5132   ; si difieren en el bit 0, es media vuelta
	jr nz,L_513C		;5134
	ld (ix+02fh),001h		;5136   ; y esa se puede siempre
	jr acepta_el_giro		;513a
L_513C:
	call marca_si_esta_cuadrado		;513c   ; si no, hay que estar cuadrado
	call esta_cuadrado		;513f
	ret nz			;5142   ; y si no lo esta, no gira
acepta_el_giro:
	ld a,(ix+006h)		;5143   ; lo que hay en esa direccion
	cp 090h		;5146   ; con 0x90 o mas se puede pasar
	ret nc			;5148
	ld a,(ix+004h)		;5149   ; la direccion pedida
	ld (ix+005h),a		;514c   ; pasa a ser la que lleva
	ld a,(ix+02fh)		;514f
	and a			;5152
	call nz,cuadra_a_la_casilla		;5153   ; y si era media vuelta, se recoloca
	ret			;5156
sigue_recto:
	ld a,(ix+00ah)		;5157   ; el estado
	and a			;515a
	ret nz			;515b   ; ocupado, no se mira nada
	call esta_cuadrado		;515c   ; esta cuadrado?
	jr z,se_para		;515f
	ld a,(ix+005h)		;5161   ; la direccion que lleva
	call lee_la_posicion		;5164
	bit 0,a		;5167   ; el bit 0 separa las dos parejas
	jr nz,mira_la_casilla_de_delante		;5169
	call anda_ocho_pixeles		;516b   ; y mira ocho pixeles por delante
mira_la_casilla_de_delante:
	call celda_de_coordenadas		;516e   ; la casilla
	call 0004ah		;5171   ; BIOS RDVRM - Reads the content of VRAM | y lo que hay dibujado en ella
	ld b,a			;5174
	and 003h		;5175   ; los dos bits de abajo dicen por donde se sale
	ld c,a			;5177
	ld a,(ix+005h)		;5178   ; la direccion que lleva
	cp c			;517b   ; si coincide, se puede seguir
	jr z,guarda_lo_que_hay_delante		;517c
	xor c			;517e
	cp 001h		;517f   ; y media vuelta tambien
	ret nz			;5181
guarda_lo_que_hay_delante:
	ld a,b			;5182   ; el patron
	cp 080h		;5183   ; por debajo de 0x80 es pared
	jr nc,L_5189		;5185
	ld a,084h		;5187   ; y la pared se apunta como 0x84
L_5189:
	ld (ix+009h),a		;5189   ; lo que hay delante
	ret			;518c
se_para:
	ld a,(ix+009h)		;518d   ; lo que hay delante
	ld c,a			;5190
	and 00ch		;5191   ; si esta bloqueado, se queda
	ret nz			;5193
	ld a,c			;5194
	and 003h		;5195   ; y si no, sigue en su direccion
	ld (ix+005h),a		;5197
	ret			;519a
marca_si_esta_cuadrado:
	call esta_cuadrado		;519b   ; esta cuadrado?
	ret nz			;519e
	ld (ix+02fh),a		;519f   ; y se apunta
	ret			;51a2

; ----------------------------------------------------------------------
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; Lo mismo que el giro del protagonista, pero para los enemigos, y con una excepcion: el enemigo de tipo 5 puede pasar tambien por las tres casillas de meta.
; ----------------------------------------------------------------------
decide_el_giro_del_enemigo:
	ld a,(ix+004h)		;51a3   ; la direccion pedida
	inc a			;51a6
	jr z,sigue_recto_el_enemigo		;51a7   ; sin direccion, sigue recto
	ld a,(ix+005h)		;51a9   ; la que lleva
	ld c,a			;51ac
	ld a,(ix+004h)		;51ad
	ld b,a			;51b0
	cp c			;51b1   ; la misma: nada que hacer
	ret z			;51b2
	xor c			;51b3
	cp 001h		;51b4   ; media vuelta se permite siempre
	jr z,mira_si_puede_pasar		;51b6
	call esta_cuadrado		;51b8   ; y girar exige estar cuadrado
	ret nz			;51bb
mira_si_puede_pasar:
	ld a,(ix+019h)		;51bc   ; el tipo de enemigo
	cp 005h		;51bf   ; el tipo 5 tiene permiso especial
	jr nz,exige_paso_libre		;51c1
	ld a,(ix+006h)		;51c3   ; lo que hay delante
	cp 0b6h		;51c6   ; las tres casillas de meta
	jr z,acepta_el_giro_del_enemigo		;51c8
	cp 0b4h		;51ca   ; la segunda
	jr z,acepta_el_giro_del_enemigo		;51cc
	cp 0b5h		;51ce   ; y la tercera
	jr z,acepta_el_giro_del_enemigo		;51d0
exige_paso_libre:
	ld a,(ix+006h)		;51d2   ; lo que hay delante
	cp 090h		;51d5   ; con menos de 0x90 no se pasa
	ret nc			;51d7
acepta_el_giro_del_enemigo:
	ld a,(ix+004h)		;51d8   ; la direccion pedida
	ld (ix+005h),a		;51db   ; pasa a ser la suya
	ret			;51de
sigue_recto_el_enemigo:
	ld a,(ix+019h)		;51df   ; el tipo
	cp 002h		;51e2   ; el tipo 2 no cambia solo
	ret z			;51e4
	ld a,(ix+009h)		;51e5   ; lo que dice el decorado
	and 003h		;51e8
	ld (ix+005h),a		;51ea   ; y por ahi se va
	ret			;51ed

; ----------------------------------------------------------------------
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; El paso de la animacion del protagonista: da la vuelta cada cuatro y solo avanza mientras haya algo pulsado, para que quieto no mueva las piernas.
; ----------------------------------------------------------------------
anima_al_protagonista:
	ld hl,0e13ah		;51ee   ; el paso de la animacion
	ld a,(hl)			;51f1
	and a			;51f2   ; a cero se queda parado
	jr z,avanza_si_se_mueve		;51f3
	inc (hl)			;51f5   ; uno mas
	ld a,(hl)			;51f6
	sub 004h		;51f7   ; y vuelve a cero al llegar a cuatro
	ret nz			;51f9
	ld (hl),a			;51fa
avanza_si_se_mueve:
	ld a,(0e010h)		;51fb   ; lo que hay pulsado
	and 00fh		;51fe
	ret z			;5200   ; sin nada pulsado no se anima
	inc (hl)			;5201   ; y con algo, un paso
	ret			;5202

; ----------------------------------------------------------------------
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; Mira lo que hay dibujado en la casilla propia y en la de ocho pixeles mas alla, y se lo guarda. Es la lectura del mapa que hace de colision, y solo se hace estando cuadrado.
; ----------------------------------------------------------------------
lee_el_decorado_alrededor:
	call esta_cuadrado		;5203   ; solo estando cuadrado
	ret nz			;5206
	call lee_la_posicion		;5207   ; la posicion
	call celda_de_coordenadas		;520a   ; su casilla
	call 0004ah		;520d   ; BIOS RDVRM - Reads the content of VRAM | y el patron que hay ahi
	cp 080h		;5210   ; por debajo de 0x80 es pared
	jr nc,L_5216		;5212
	ld a,084h		;5214   ; apuntada como 0x84
L_5216:
	ld (ix+009h),a		;5216   ; lo que hay aqui
	and 003h		;5219   ; la direccion que dice el decorado
	call anda_ocho_pixeles		;521b   ; ocho pixeles mas alla
	call celda_de_coordenadas		;521e   ; su casilla
	call 0004ah		;5221   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;5224
	jr nc,L_522A		;5226
	ld a,084h		;5228   ; la pared, otra vez como 0x84
L_522A:
	ld (ix+008h),a		;522a   ; lo que hay debajo
	ret			;522d
elige_el_dibujo:
	ld a,(ix+004h)		;522e   ; la direccion pedida
	inc a			;5231   ; sin direccion, vale la que lleva
	jr nz,L_5239		;5232
	ld a,(ix+005h)		;5234
	jr mira_por_donde_va		;5237
L_5239:
	dec a			;5239   ; y con ella, la de antes
mira_por_donde_va:
	ld c,a			;523a   ; el paso, guardado
	ld a,(ix+005h)		;523b   ; la direccion
	and a			;523e
	jr z,tabla_de_la_direccion_cero		;523f   ; la 0 tiene su tabla
	cp 002h		;5241   ; la 2, la suya
	jr z,tabla_de_la_direccion_dos		;5243
	ld hl,0528eh		;5245   ; y las otras dos, otra
	jr lee_dos_casillas_del_camino		;5248
tabla_de_la_direccion_dos:
	ld hl,05296h		;524a   ; la tabla de la direccion 2
	jr lee_dos_casillas_del_camino		;524d
tabla_de_la_direccion_cero:
	ld hl,05286h		;524f   ; la de la direccion 0
lee_dos_casillas_del_camino:
	ld a,c			;5252
	push bc			;5253
	call suma_el_paso		;5254   ; avanza el paso
	call celda_de_coordenadas		;5257   ; y saca su casilla
	push hl			;525a
	ld (ix+02bh),l		;525b   ; la casilla, guardada
	ld (ix+02ch),h		;525e
	call 0004ah		;5261   ; BIOS RDVRM - Reads the content of VRAM | lo que hay dibujado en ella
	cp 080h		;5264   ; por debajo de 0x80 es pared
	jr nc,guarda_lo_de_delante		;5266
	ld a,084h		;5268   ; apuntada como 0x84
guarda_lo_de_delante:
	ld (ix+006h),a		;526a   ; lo que hay delante
	pop hl			;526d
	ld a,(ix+004h)		;526e
	pop bc			;5271
	ld a,c			;5272
	call suma_el_paso		;5273   ; otro paso mas
	call celda_de_coordenadas		;5276   ; su casilla
	call 0004ah		;5279   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;527c
	jr nc,guarda_lo_de_mas_alla		;527e
	ld a,084h		;5280
guarda_lo_de_mas_alla:
	ld (ix+02dh),a		;5282   ; lo que hay dos casillas mas alla
	ret			;5285

; ----------------------------------------------------------------------
; DATOS tres_tablas_de_ocho: tres tablas de 8 bytes que cargan 0x5245
;   (0x528e), 0x524a (0x5296) y 0x524f (0x5286)
;   0x5286..0x529e  (24 bytes)
DATA_tres_tablas_de_ocho:
	defb 000h,008h,000h,0ffh,008h,007h,0ffh,007h	; 5286  ........
	defb 000h,008h,000h,0ffh,008h,000h,0ffh,000h	; 528e  ........
	defb 007h,008h,007h,0ffh,008h,000h,0ffh,000h	; 5296  ........

; ======================================================================
; CODIGO 0x529e..0x539e  (256 bytes)
; ======================================================================


recoloca_si_hace_falta:
	ld a,(ix+019h)		;529e   ; el tipo
	inc a			;52a1   ; el 0xFF es el protagonista
	jr nz,L_52A9		;52a2
	call esta_en_el_suelo		;52a4   ; que necesita suelo debajo
	jr nc,cuadra_a_la_casilla		;52a7
L_52A9:
	call esta_cuadrado		;52a9   ; y estar cuadrado
	ret nz			;52ac

; ----------------------------------------------------------------------
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; Empuja la posicion hasta el multiplo de ocho mas cercano EN EL SENTIDO DE LA MARCHA, de uno en uno. No redondea: arrastra, y por eso el giro se siente pegado a la rejilla.
; ----------------------------------------------------------------------
cuadra_a_la_casilla:
	ld a,(ix+005h)		;52ad   ; la direccion
	call lee_la_posicion		;52b0   ; y la posicion
	and a			;52b3
	jr z,cuadra_hacia_arriba		;52b4   ; la 0 va hacia arriba
	dec a			;52b6
	jr z,cuadra_hacia_abajo		;52b7   ; la 1, hacia abajo
	dec a			;52b9
	jr z,cuadra_a_la_izquierda		;52ba   ; y la 2, a la izquierda
cuadra_a_la_derecha:
	ld a,l			;52bc
	and 007h		;52bd   ; ya es multiplo de ocho?
	jr z,radiografia_el_entorno		;52bf
	inc l			;52c1   ; y si no, un pixel mas
	jr cuadra_a_la_derecha		;52c2
cuadra_a_la_izquierda:
	ld a,l			;52c4
	and 007h		;52c5
	jr z,radiografia_el_entorno		;52c7
	dec l			;52c9   ; un pixel menos
	jr cuadra_a_la_izquierda		;52ca
cuadra_hacia_arriba:
	ld a,h			;52cc
	and 007h		;52cd
	jr z,radiografia_el_entorno		;52cf
	dec h			;52d1   ; una fila menos
	jr cuadra_hacia_arriba		;52d2
cuadra_hacia_abajo:
	ld a,h			;52d4
	and 007h		;52d5
	jr z,radiografia_el_entorno		;52d7
	inc h			;52d9   ; una fila mas
	jr cuadra_hacia_abajo		;52da

; ----------------------------------------------------------------------
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; Lee de la pantalla los patrones de las seis casillas que rodean a la entidad y se los guarda en su bloque. Es la lectura que sustituye a un mapa de colisiones en memoria.
; ----------------------------------------------------------------------
radiografia_el_entorno:
	ld a,(ix+005h)		;52dc   ; la direccion
	push hl			;52df
	ld hl,0539eh		;52e0   ; la tabla de pasos de ocho pixeles
	call lee_puntero_de_tabla		;52e3   ; el paso de esa direccion
	pop hl			;52e6
	ld a,l			;52e7
	add a,e			;52e8   ; sumado a la posicion
	ld l,a			;52e9
	ld a,h			;52ea
	add a,d			;52eb
	ld h,a			;52ec
	ld (0e2a0h),hl		;52ed
	call celda_de_coordenadas		;52f0   ; la casilla de delante
	ld (ix+029h),l		;52f3   ; guardada
	ld (ix+02ah),h		;52f6
	call 0004ah		;52f9   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;52fc
	jr nc,guarda_el_suelo		;52fe
	ld a,084h		;5300   ; la pared, como 0x84
guarda_el_suelo:
	ld (ix+007h),a		;5302   ; lo que hay bajo los pies
	ld a,(ix+005h)		;5305
	push ix		;5308   ; otro paso mas alla
	ld ix,0e2a0h		;530a
	call anda_ocho_pixeles		;530e   ; con la posicion prestada
	pop ix		;5311
	call celda_de_coordenadas		;5313   ; su casilla
	call 0004ah		;5316   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;5319
	jr nc,guarda_lo_de_dos_mas_alla		;531b
	ld a,084h		;531d
guarda_lo_de_dos_mas_alla:
	ld (ix+027h),a		;531f   ; dos casillas por delante
	call lee_la_posicion		;5322   ; la posicion propia
	call celda_de_coordenadas		;5325   ; su casilla
	ld (ix+002h),l		;5328   ; guardada
	ld (ix+003h),h		;532b
	push hl			;532e
	ld de,00020h		;532f   ; una fila entera mas abajo
	add hl,de			;5332
	ld (ix+015h),l		;5333   ; esa casilla, guardada
	ld (ix+016h),h		;5336
	call 0004ah		;5339   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;533c
	jr nc,guarda_lo_de_abajo		;533e
	ld a,084h		;5340
guarda_lo_de_abajo:
	ld (ix+00dh),a		;5342   ; lo que hay debajo
	ld a,040h		;5345   ; 0x40 son dos filas
	call resta_a_a_hl		;5347   ; o sea una fila por encima de la propia
	ld (ix+017h),l		;534a   ; guardada
	ld (ix+018h),h		;534d
	call 0004ah		;5350   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;5353
	jr nc,guarda_lo_de_arriba		;5355
	ld a,084h		;5357
guarda_lo_de_arriba:
	ld (ix+00eh),a		;5359   ; lo que hay encima
	pop hl			;535c
	dec hl			;535d   ; la casilla de la izquierda
	ld (ix+013h),l		;535e   ; guardada
	ld (ix+014h),h		;5361
	call 0004ah		;5364   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;5367
	jr nc,guarda_lo_de_la_izquierda		;5369
	ld a,084h		;536b
guarda_lo_de_la_izquierda:
	ld (ix+00ch),a		;536d   ; lo que hay a la izquierda
	inc hl			;5370   ; dos casillas: la de la derecha
	inc hl			;5371
	ld (ix+011h),l		;5372   ; guardada
	ld (ix+012h),h		;5375
	call 0004ah		;5378   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;537b
	jr nc,guarda_lo_de_la_derecha		;537d
	ld a,084h		;537f
guarda_lo_de_la_derecha:
	ld (ix+00bh),a		;5381   ; lo que hay a la derecha
	ret			;5384

; ----------------------------------------------------------------------
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; El dibujo del protagonista: la direccion elige el grupo y el bit 3 del contador de cuadros alterna los dos pasos, o sea que anda a ocho cuadros por paso.
; ----------------------------------------------------------------------
elige_el_dibujo_del_protagonista:
	ld a,(0e135h)		;5385   ; la direccion
	add a,a			;5388   ; por cuatro: cada direccion tiene cuatro patrones
	add a,a			;5389
	ld c,a			;538a
	ld a,(0e003h)		;538b   ; el contador de cuadros
	bit 3,a		;538e   ; el bit 3 cambia cada ocho
	ld a,c			;5390
	jr z,pone_los_dos_sprites		;5391
	add a,020h		;5393   ; el segundo paso de la animacion
pone_los_dos_sprites:
	ld (0e0b2h),a		;5395   ; el patron del primer sprite
	add a,010h		;5398   ; y el segundo, dieciseis mas alla: el otro color
	ld (0e0b6h),a		;539a
	ret			;539d

; ----------------------------------------------------------------------
; DATOS direcciones_539e: las cuatro direcciones a 8 pixeles: (0,8) (0,-8)
;   (8,0) (-8,0); la cargan 0x4cc7, 0x50aa y 0x52e0
;   0x539e..0x53a6  (8 bytes)
DATA_direcciones_539e:
	defb 000h,008h	; 539e
	defb 000h,0f8h	; 53a0
	defb 008h,000h	; 53a2
	defb 0f8h,000h	; 53a4

; ======================================================================
; CODIGO 0x53a6..0x5776  (976 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; Mueve el martillo lanzado. Solo mira el decorado cuando esta cuadrado, y en cuanto se encuentra algo que no deja pasar, se acaba el vuelo.
; ----------------------------------------------------------------------
vuela_el_martillo:
	ld a,(0e153h)		;53a6   ; el estado del martillo
	bit 7,a		;53a9   ; sin el bit 7 no hay martillo volando
	ret z			;53ab
	ld ix,0e154h		;53ac   ; su posicion
	call esta_cuadrado		;53b0   ; solo se comprueba estando cuadrado
	jr nz,avanza_el_martillo		;53b3
	call lee_la_posicion		;53b5
	call celda_de_coordenadas		;53b8   ; su casilla
	call 0004ah		;53bb   ; BIOS RDVRM - Reads the content of VRAM | y lo que hay ahi
	cp 090h		;53be   ; por debajo de 0x90 se estrella
	jr nc,guarda_el_martillo		;53c0
	ld a,(0e153h)		;53c2   ; su direccion
	and 07fh		;53c5
	call anda_ocho_pixeles		;53c7   ; ocho pixeles por delante
	call celda_de_coordenadas		;53ca   ; esa casilla
	call 0004ah		;53cd   ; BIOS RDVRM - Reads the content of VRAM | y su patron
	cp 080h		;53d0
	jr nc,mira_si_puede_seguir		;53d2
	ld a,084h		;53d4
mira_si_puede_seguir:
	ld (0e156h),a		;53d6   ; lo que hay delante
	cp 090h		;53d9   ; y si no deja pasar, se acaba
	jr nc,guarda_el_martillo		;53db
avanza_el_martillo:
	ld a,(0e153h)		;53dd   ; su direccion
	and 07fh		;53e0
	ld hl,04c68h		;53e2   ; la tabla de pasos de una celda
	call suma_el_paso		;53e5   ; y avanza
coloca_el_martillo:
	ld (0e154h),hl		;53e8   ; su posicion nueva
	jp coloca_el_sprite_del_martillo		;53eb   ; y su sprite
guarda_el_martillo:
	xor a			;53ee   ; el martillo, recogido
	ld (0e153h),a		;53ef
	ld hl,000e0h		;53f2   ; y su sprite, fuera de la pantalla
	jr coloca_el_martillo		;53f5

; ----------------------------------------------------------------------
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; Prueba el choque del protagonista contra los cinco enemigos, uno por uno.
; ----------------------------------------------------------------------
mira_los_choques:
	ld a,(0e067h)		;53f7   ; el estado de la partida
	and 003h		;53fa
	ret nz			;53fc   ; acabando la zona, no hay choques
	ld ix,0e160h		;53fd   ; el primer enemigo
	call prueba_un_choque		;5401
	ld ix,0e190h		;5404   ; el segundo
	call prueba_un_choque		;5408
	ld ix,0e1c0h		;540b   ; el tercero
	call prueba_un_choque		;540f
	ld ix,0e1f0h		;5412   ; el cuarto
	call prueba_un_choque		;5416
	ld ix,0e220h		;5419   ; y el quinto

; ----------------------------------------------------------------------
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; El choque es una caja de ocho pixeles: si el protagonista y el enemigo estan a menos de ocho en las dos coordenadas, se acabo.
; ----------------------------------------------------------------------
prueba_un_choque:
	ld a,(ix+019h)		;541d   ; el enemigo esta en juego?
	and a			;5420
	ret z			;5421   ; si no, no choca
	ld a,(ix+01dh)		;5422   ; esta muerto?
	rra			;5425
	ret c			;5426   ; los muertos tampoco chocan
	ld hl,(0e130h)		;5427   ; donde esta el protagonista
	ld e,(ix+000h)		;542a   ; y donde el enemigo
	ld d,(ix+001h)		;542d
	ld c,008h		;5430   ; ocho pixeles de margen
	call estan_cerca		;5432   ; estan encima?
	ret nc			;5435   ; si no, no pasa nada
	jp marca_la_llegada		;5436   ; y si si, se acabo la vida

; ----------------------------------------------------------------------
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; La animacion del final: cada ocho cuadros gira el dibujo del protagonista, y en el primer paso se guarda una copia de los dos patrones que va a machacar.
; ----------------------------------------------------------------------
anima_el_fin_de_zona:
	ld a,(0e2ddh)		;5439   ; el contador del final
	ld c,a			;543c
	and 007h		;543d   ; uno de cada ocho
	ret nz			;543f
	ld a,c			;5440
	cp 041h		;5441   ; pasado 0x40 ya no hay animacion
	ret nc			;5443
	cp 009h		;5444   ; los ocho primeros son la preparacion
	jr nc,gira_los_dos_patrones		;5446
	ld a,015h		;5448   ; su sonido
	call suena		;544a
	xor a			;544d
	ld (0e13ah),a		;544e   ; el paso de la animacion, a cero
	ld a,074h		;5451   ; el patron del primer sprite
	ld (0e0b2h),a		;5453
	add a,004h		;5456   ; y el del segundo, cuatro mas alla
	ld (0e0b6h),a		;5458
	ld a,00eh		;545b   ; su color
	ld (0e0b3h),a		;545d
	ld hl,01ba0h		;5460   ; el patron de la memoria de video
	ld de,0e070h		;5463   ; copiado a la memoria
	ld bc,00020h		;5466   ; los 32 bytes
	push bc			;5469
	call 00059h		;546a   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,01bc0h		;546d   ; y el segundo patron
	ld de,0e31fh		;5470   ; a su copia
	pop bc			;5473
	call 00059h		;5474   ; BIOS LDIRMV - Block transfers to memory from VRAM
gira_los_dos_patrones:
	ld hl,0e080h		;5477   ; el primer dibujo
	ld (0e05ah),hl		;547a   ; apuntado como origen
	ld hl,01ba0h		;547d   ; y su sitio en la memoria de video
	call gira_un_patron		;5480
	ld hl,0e32fh		;5483   ; el segundo dibujo
	ld (0e05ah),hl		;5486
	ld hl,01bc0h		;5489   ; y su sitio

; ----------------------------------------------------------------------
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; Gira un dibujo de 16x16, que son cuatro patrones de 8x8, transponiendo cada uno y recolocandolos: el de arriba a la izquierda pasa a arriba a la derecha, y asi.
; ----------------------------------------------------------------------
gira_un_patron:
	push hl			;548c   ; el destino, guardado
	ld de,0e290h		;548d   ; donde se monta el dibujo girado
	call transpone_un_patron		;5490   ; el primer cuarto
	ld hl,(0e05ah)		;5493   ; el origen
	ld a,010h		;5496   ; 0x10 son dos patrones atras
	call resta_a_a_hl		;5498
	ld (0e05ah),hl		;549b
	call transpone_un_patron		;549e   ; el segundo cuarto
	ld hl,(0e05ah)		;54a1
	ld a,018h		;54a4   ; 0x18 hacia delante
	call suma_a_a_hl		;54a6
	ld (0e05ah),hl		;54a9
	call transpone_un_patron		;54ac   ; el tercero
	ld hl,(0e05ah)		;54af
	ld a,010h		;54b2
	call resta_a_a_hl		;54b4   ; y otros 0x10 atras
	ld (0e05ah),hl		;54b7
	call transpone_un_patron		;54ba   ; el cuarto
	ld hl,(0e05ah)		;54bd
	ld a,008h		;54c0   ; vuelve al principio
	call resta_a_a_hl		;54c2
	ex de,hl			;54c5
	ld hl,0e290h		;54c6   ; el dibujo ya girado
	ld bc,00020h		;54c9   ; 32 bytes
	push bc			;54cc
	ldir		;54cd   ; copiados a su sitio
	pop bc			;54cf
	pop hl			;54d0
	ld de,0e290h		;54d1   ; y de ahi a la memoria de video
	jp vuelca_a_vram		;54d4
transpone_un_patron:
	ld c,008h		;54d7   ; ocho filas de salida
saca_una_fila_girada:
	ld hl,(0e05ah)		;54d9   ; el patron de origen
	ld b,008h		;54dc   ; sus ocho bytes
	xor a			;54de   ; el byte que se va montando
saca_un_bit:
	rr (hl)		;54df   ; saca el bit de mas a la derecha del byte
	rla			;54e1   ; y lo mete por la derecha del que se monta
	inc hl			;54e2   ; el byte siguiente del patron
	djnz saca_un_bit		;54e3   ; los ocho: sale una columna convertida en fila
	ld (de),a			;54e5   ; la fila girada
	inc de			;54e6
	dec c			;54e7
	jr nz,saca_una_fila_girada		;54e8   ; hasta las ocho
	ret			;54ea

; ----------------------------------------------------------------------
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; Apunta un destello en la lista de cosas que hay que borrar despues, guardando su casilla y el patron que llevaba, y lo pinta.
; ----------------------------------------------------------------------
apunta_el_destello:
	push hl			;54eb
	ld hl,0e2b5h		;54ec   ; la cuenta de destellos
	inc (hl)			;54ef   ; uno mas
	ld a,(hl)			;54f0
	ld b,a			;54f1
	ld hl,0e090h		;54f2   ; la lista de patrones
	call suma_a_a_hl		;54f5
	ld (hl),c			;54f8   ; con el suyo
	pop hl			;54f9
	ex de,hl			;54fa
	ld hl,0e2dfh		;54fb   ; la lista de casillas
	ld a,b			;54fe
	add a,a			;54ff   ; dos bytes por casilla
	call suma_a_a_hl		;5500
	ld (hl),e			;5503   ; la casilla, guardada
	inc hl			;5504
	ld (hl),d			;5505
	ex de,hl			;5506
	ld a,0b6h		;5507   ; y el patron del destello
	jp 0004dh		;5509   ; BIOS WRTVRM - Writes data in VRAM | a la pantalla

; ----------------------------------------------------------------------
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; Mientras se acaba la zona el protagonista parpadea entre dos dibujos, cada dieciseis cuadros.
; ----------------------------------------------------------------------
parpadea_al_protagonista:
	ld a,(0e066h)		;550c   ; el contador del final
	and 010h		;550f   ; el bit 4 alterna
	ld a,07ch		;5511   ; un dibujo
	jr nz,pone_el_dibujo_del_final		;5513
	ld a,084h		;5515   ; y el otro
pone_el_dibujo_del_final:
	ld (0e0b2h),a		;5517   ; el primer sprite
	add a,004h		;551a   ; y el segundo, cuatro mas alla
	ld (0e0b6h),a		;551c
	ld a,00eh		;551f   ; su color
	ld (0e0b3h),a		;5521
	ret			;5524
dibuja_al_enemigo_uno:
	ld ix,0e160h		;5525   ; su bloque
	ld iy,0e0b8h		;5529   ; su hueco de sprite
	ld hl,0e05eh		;552d   ; y donde se guarda su dibujo
	jr dibuja_un_enemigo		;5530
dibuja_al_enemigo_dos:
	ld ix,0e190h		;5532   ; su bloque
	ld iy,0e0c4h		;5536   ; su hueco de sprite
	ld hl,0e060h		;553a   ; y su dibujo
	jr dibuja_un_enemigo		;553d
dibuja_al_enemigo_tres:
	ld ix,0e1c0h		;553f   ; su bloque
	ld iy,0e0d0h		;5543   ; su hueco
	ld hl,0e062h		;5547   ; y su dibujo
	jr dibuja_un_enemigo		;554a
dibuja_al_enemigo_cuatro:
	ld ix,0e1f0h		;554c   ; su bloque
	ld iy,0e0e0h		;5550   ; su hueco
	ld hl,0e064h		;5554   ; y su dibujo

; ----------------------------------------------------------------------
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; Coloca el sprite de un enemigo. Los que estan muertos siguen un guion de animacion contado en 0x1E, y los vivos van directos a su casilla.
; ----------------------------------------------------------------------
dibuja_un_enemigo:
	ld (0e2a0h),hl		;5557   ; su dibujo, guardado
	ld a,(ix+019h)		;555a   ; esta en juego?
	and a			;555d
	ret z			;555e   ; si no, no se dibuja
	ld e,(ix+01fh)		;555f   ; el cuadro en el que tiene que reaparecer
	ld d,(ix+020h)		;5562
	ld a,e			;5565
	or d			;5566
	jr z,anima_al_enemigo_muerto		;5567   ; sin cita, no espera a nada
	ld hl,(0e2b6h)		;5569   ; el reloj de la partida
	ld a,e			;556c
	cp l			;556d
	ret nz			;556e   ; si no es la hora, sigue esperando
	ld a,d			;556f
	cp h			;5570
	ret nz			;5571
	xor a			;5572   ; y al llegar, se borra la cita
	ld (ix+01fh),a		;5573
	ld (ix+020h),a		;5576
anima_al_enemigo_muerto:
	ld a,(ix+01dh)		;5579   ; esta muerto?
	and a			;557c
	ld c,a			;557d
	jr z,dibuja_al_enemigo_vivo		;557e   ; si no, se dibuja normal
	push ix		;5580
	pop hl			;5582
	ld de,0001eh		;5583   ; el contador de su animacion
	add hl,de			;5586
	inc (hl)			;5587   ; uno mas
	ld a,(hl)			;5588
	cp 001h		;5589   ; en el primer paso
	jr nz,avanza_la_animacion_de_muerte		;558b
	bit 7,c		;558d   ; el bit 7 separa los dos tipos de muerte
	jr z,esconde_al_enemigo_muerto		;558f
	ld hl,(0e2a0h)		;5591   ; el dibujo que le toca
	ld e,(hl)			;5594
	inc hl			;5595
	ld d,(hl)			;5596
	ex de,hl			;5597
	call direccion_de_patron		;5598   ; su sitio en la memoria de video
	call encoge_cuatro		;559b   ; centrado
	ld (iy+004h),l		;559e   ; y guardado
	ld (iy+005h),h		;55a1
esconde_al_enemigo_muerto:
	ld a,0e0h		;55a4   ; 0xE0 esconde el sprite
	ld (iy+000h),a		;55a6
	ret			;55a9
avanza_la_animacion_de_muerte:
	cp 010h		;55aa   ; antes de 0x10 no pasa nada
	ret c			;55ac
	jr z,revive_al_enemigo		;55ad   ; en el 0x10 vuelve a la vida
	cp 060h		;55af   ; y en el 0x60 se acaba
	ret nz			;55b1
	jp retira_al_grande		;55b2
revive_al_enemigo:
	push iy		;55b5   ; su hueco de sprite
	pop hl			;55b7
	ld e,l			;55b8
	ld d,h			;55b9
	inc de			;55ba   ; cuatro bytes mas alla, el segundo sprite
	inc de			;55bb
	inc de			;55bc
	inc de			;55bd
	jr elige_el_lado_de_entrada		;55be
dibuja_al_enemigo_vivo:
	call reparte_por_tipo_de_enemigo		;55c0   ; elige su dibujo
	push iy		;55c3   ; su hueco de sprite
	pop hl			;55c5
coloca_el_sprite_del_enemigo:
	ld a,(ix+000h)		;55c6   ; su X
	sub 004h		;55c9   ; centrada para un sprite de 16x16
	ld (hl),a			;55cb
	inc hl			;55cc
	ld a,(ix+001h)		;55cd   ; y su Y
	sub 004h		;55d0
	ld (hl),a			;55d2
	ld a,(0e003h)		;55d3   ; el contador de cuadros
	inc hl			;55d6
	bit 2,a		;55d7   ; el bit 2 alterna el color cada cuatro
	ld a,054h		;55d9   ; un color
	jr z,L_55DF		;55db
	ld a,050h		;55dd   ; y el otro
L_55DF:
	ld (hl),a			;55df
	ret			;55e0

; ----------------------------------------------------------------------
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; El enemigo grande lleva su propio reloj de 0x1200 cuadros, y al agotarlo vuelve a cero.
; ----------------------------------------------------------------------
mueve_al_enemigo_grande:
	ld ix,0e220h		;55e1   ; su bloque
	ld a,(ix+019h)		;55e5   ; esta en juego?
	and a			;55e8
	ret z			;55e9
	ld l,(ix+01fh)		;55ea   ; su reloj
	ld h,(ix+020h)		;55ed
	inc hl			;55f0   ; un cuadro mas
	ld a,l			;55f1
	and a			;55f2
	jr nz,guarda_el_reloj_del_grande		;55f3
	ld a,h			;55f5
	cp 012h		;55f6   ; a 0x1200 se acaba
	jr nz,guarda_el_reloj_del_grande		;55f8
	ld hl,00000h		;55fa   ; y vuelve a empezar
guarda_el_reloj_del_grande:
	ld (ix+01fh),l		;55fd   ; su reloj
	ld (ix+020h),h		;5600
	ld a,(0e2b5h)		;5603   ; los destellos pendientes
	inc a			;5606
	jr z,saca_al_grande		;5607   ; si no hay ninguno, otro camino
	ld a,l			;5609
	or h			;560a   ; el reloj a cero
	jr nz,mira_el_reloj_del_grande		;560b
	ld hl,0e0f0h		;560d   ; sus dos sprites
	ld de,0e0f4h		;5610
elige_el_lado_de_entrada:
	ld a,(0e131h)		;5613   ; la Y del protagonista
	ld c,a			;5616
	ld a,(0e130h)		;5617   ; y su X
	xor c			;561a   ; el bit 0 del XOR reparte los dos lados
	rra			;561b
	jp nc,entra_por_arriba		;561c
	jp entra_por_abajo		;561f   ; y entra por arriba
mira_el_reloj_del_grande:
	ld a,h			;5622   ; la parte alta de su reloj
	and a			;5623
	jr z,coloca_al_grande		;5624   ; a cero, sigue esperando
	cp 001h		;5626   ; el 0x01
	jr nz,comprueba_si_se_va		;5628
	ld a,l			;562a   ; con la baja a cero, aparece
	and a			;562b
	jp z,retira_al_grande		;562c
comprueba_si_se_va:
	ld a,h			;562f   ; la parte alta
	cp 008h		;5630   ; por debajo de 8 sigue en pantalla
	jr c,anima_al_grande		;5632
	jr nz,guarda_al_grande		;5634
	ld a,l			;5636   ; y en el 8 justo
	and a			;5637
	jr z,avisa_de_que_sale		;5638
guarda_al_grande:
	ld a,001h		;563a   ; se marca como retirado
	ld (ix+01dh),a		;563c
	ld (0e0f3h),a		;563f   ; y su dibujo
	ld a,0ffh		;5642   ; sus sprites apagados
	ld (ix+002h),a		;5644
	ld (ix+003h),a		;5647
	ld a,0e0h		;564a
	ld (ix+000h),a		;564c   ; y escondidos
	ld (0e0f0h),a		;564f
	ret			;5652
saca_al_grande:
	ld a,(ix+01dh)		;5653   ; esta retirado?
	and a			;5656
	jr nz,pone_el_reloj_del_grande		;5657
	ld a,(0e067h)		;5659   ; el estado de la partida
	and 003h		;565c
	jr nz,guarda_al_grande		;565e   ; acabando, no sale
	ld (0e01ah),a		;5660   ; se apunta que ha salido
	ld a,008h		;5663   ; y su sonido
	call suena		;5665
	jr guarda_al_grande		;5668
avisa_de_que_sale:
	ld a,(0e067h)		;566a   ; el estado de la partida
	and 003h		;566d
	jr nz,guarda_al_grande		;566f
	ld (0e01ah),a		;5671   ; se apunta
	ld a,008h		;5674   ; y suena
	call suena		;5676
pone_el_reloj_del_grande:
	ld hl,01020h		;5679   ; 0x1020 cuadros hasta la proxima
	ld (ix+020h),h		;567c   ; guardados
	ld (ix+01fh),l		;567f
	ret			;5682
anima_al_grande:
	call reparte_por_tipo_de_enemigo		;5683   ; lo mueve
	ld a,(ix+01fh)		;5686   ; su reloj
	bit 2,a		;5689   ; el bit 2 marca el ritmo
	jr z,coloca_al_grande		;568b
	ld hl,0e0f3h		;568d   ; su color
	ld a,(hl)			;5690
	dec a			;5691   ; alterna entre dos
	ld a,001h		;5692
	jr nz,L_5698		;5694
	ld a,00fh		;5696   ; el otro
L_5698:
	ld (hl),a			;5698
coloca_al_grande:
	ld hl,0e0f0h		;5699   ; su hueco de sprite
	jp coloca_el_sprite_del_enemigo		;569c

; ----------------------------------------------------------------------
; Cada tipo de enemigo elige su objetivo de otra forma. El reparto se hace gastando el numero de tipo con `dec a` sucesivos, que es mas corto que una tabla para cinco casos.
; Cada tipo de enemigo elige su objetivo de otra forma. El reparto se hace gastando el numero de tipo con `dec a` sucesivos, que es mas corto que una tabla para cinco casos.
; Cada tipo de enemigo elige su objetivo de otra forma. El reparto se hace gastando el numero de tipo con `dec a` sucesivos, que es mas corto que una tabla para cinco casos.
; Cada tipo de enemigo elige su objetivo de otra forma. El reparto se hace gastando el numero de tipo con `dec a` sucesivos, que es mas corto que una tabla para cinco casos.
; Cada tipo de enemigo elige su objetivo de otra forma. El reparto se hace gastando el numero de tipo con `dec a` sucesivos, que es mas corto que una tabla para cinco casos.
; Cada tipo de enemigo elige su objetivo de otra forma. El reparto se hace gastando el numero de tipo con `dec a` sucesivos, que es mas corto que una tabla para cinco casos.
; ----------------------------------------------------------------------
reparte_por_tipo_de_enemigo:
	ld a,(ix+019h)		;569f   ; el tipo
	dec a			;56a2   ; tipo 1: persigue cortando el paso
	jp z,persigue_cortando_el_paso		;56a3
	dec a			;56a6   ; tipo 2: imita la direccion del jugador
	jp z,imita_al_jugador		;56a7
	dec a			;56aa   ; tipo 3: va al punto espejo
	jp z,va_al_punto_espejo		;56ab
	dec a			;56ae   ; tipo 4: persigue con la otra tabla
	jp z,persigue_con_el_otro_adelanto		;56af
	jp espera_el_enemigo		;56b2   ; y tipo 5: el grande
entra_por_abajo:
	ld (ix+001h),0e4h		;56b5   ; la fila de abajo
	ld (ix+005h),001h		;56b9   ; subiendo
	ld (ix+007h),081h		;56bd   ; y lo que tiene delante
	ld (iy+001h),0e0h		;56c1   ; su sprite, fuera por arriba
	jr coloca_al_grande_al_entrar		;56c5
entra_por_arriba:
	ld (ix+001h),014h		;56c7   ; la fila de arriba
	ld (ix+005h),000h		;56cb   ; bajando
	ld (ix+007h),080h		;56cf   ; y lo que tiene delante
	ld (iy+001h),010h		;56d3   ; su sprite, en la fila 0x10
coloca_al_grande_al_entrar:
	ld (ix+000h),060h		;56d7   ; la columna del centro
	ld (iy+004h),0e0h		;56db   ; el segundo sprite, escondido
	ld (iy+000h),05ch		;56df   ; su dibujo
	ld (iy+002h),050h		;56e3   ; y su color
	ret			;56e7
retira_al_grande:
	ld a,(0e067h)		;56e8   ; el estado de la partida
	and 003h		;56eb
	jr nz,borra_el_estado_del_grande		;56ed   ; acabando, sin sonido
	ld a,(ix+019h)		;56ef   ; el tipo
	cp 005h		;56f2   ; solo el grande suena al irse
	jr nz,borra_el_estado_del_grande		;56f4
	ld a,089h		;56f6   ; su sonido
	call suena		;56f8
borra_el_estado_del_grande:
	xor a			;56fb   ; ya no esta muerto
	ld (ix+01dh),a		;56fc
	ld (ix+01eh),a		;56ff   ; ni animandose
	ret			;5702

; ----------------------------------------------------------------------
; El tipo 1 no va donde esta el jugador, sino donde VA A ESTAR: la tabla de 0x5776 le da un adelanto en la direccion que el jugador lleva pulsada, y persigue a ese punto.
; El tipo 1 no va donde esta el jugador, sino donde VA A ESTAR: la tabla de 0x5776 le da un adelanto en la direccion que el jugador lleva pulsada, y persigue a ese punto.
; El tipo 1 no va donde esta el jugador, sino donde VA A ESTAR: la tabla de 0x5776 le da un adelanto en la direccion que el jugador lleva pulsada, y persigue a ese punto.
; El tipo 1 no va donde esta el jugador, sino donde VA A ESTAR: la tabla de 0x5776 le da un adelanto en la direccion que el jugador lleva pulsada, y persigue a ese punto.
; El tipo 1 no va donde esta el jugador, sino donde VA A ESTAR: la tabla de 0x5776 le da un adelanto en la direccion que el jugador lleva pulsada, y persigue a ese punto.
; El tipo 1 no va donde esta el jugador, sino donde VA A ESTAR: la tabla de 0x5776 le da un adelanto en la direccion que el jugador lleva pulsada, y persigue a ese punto.
; ----------------------------------------------------------------------
persigue_cortando_el_paso:
	ld a,(0e135h)		;5703   ; la direccion del jugador
	ld hl,05776h		;5706   ; la tabla de adelantos
	push ix		;5709
	ld ix,0e130h		;570b   ; desde la posicion del jugador
	call suma_el_paso		;570f   ; sumado el adelanto
	pop ix		;5712
	ld (ix+01bh),l		;5714   ; y ese es el objetivo
	ld (ix+01ch),h		;5717
persigue_el_objetivo:
	ld a,(ix+026h)		;571a   ; acaba de girar?
	and a			;571d
	jr z,elige_la_direccion_hacia_el_objetivo		;571e   ; si no, elige direccion
	ld (ix+026h),000h		;5720   ; y si si, se limpia la marca
	jr L_5768		;5724

; ----------------------------------------------------------------------
; El motor de persecucion: mide cuanto le falta en cada eje, se queda con el eje donde este mas lejos y saca el sentido. Nunca devuelve la media vuelta, que es lo que evita que se queden temblando.
; El motor de persecucion: mide cuanto le falta en cada eje, se queda con el eje donde este mas lejos y saca el sentido. Nunca devuelve la media vuelta, que es lo que evita que se queden temblando.
; El motor de persecucion: mide cuanto le falta en cada eje, se queda con el eje donde este mas lejos y saca el sentido. Nunca devuelve la media vuelta, que es lo que evita que se queden temblando.
; El motor de persecucion: mide cuanto le falta en cada eje, se queda con el eje donde este mas lejos y saca el sentido. Nunca devuelve la media vuelta, que es lo que evita que se queden temblando.
; El motor de persecucion: mide cuanto le falta en cada eje, se queda con el eje donde este mas lejos y saca el sentido. Nunca devuelve la media vuelta, que es lo que evita que se queden temblando.
; El motor de persecucion: mide cuanto le falta en cada eje, se queda con el eje donde este mas lejos y saca el sentido. Nunca devuelve la media vuelta, que es lo que evita que se queden temblando.
; ----------------------------------------------------------------------
elige_la_direccion_hacia_el_objetivo:
	ld e,(ix+000h)		;5726   ; donde esta el enemigo
	ld d,(ix+001h)		;5729
	ld bc,00000h		;572c   ; B y C recogen los signos
	ld a,l			;572f   ; la distancia en X
	sub e			;5730
	jr nc,L_5734		;5731
	inc b			;5733   ; negativa: se apunta el signo
L_5734:
	neg		;5734   ; en valor absoluto
	ld e,a			;5736
	ld a,h			;5737   ; y ahora la distancia en Y
	sub d			;5738
	jr nc,compara_las_dos_distancias		;5739
	inc c			;573b   ; tambien su signo
compara_las_dos_distancias:
	neg		;573c
	ld d,a			;573e   ; la distancia en Y
	ld a,e			;573f   ; la de X
	and a			;5740
	jr z,tira_por_el_eje_vertical		;5741   ; si es cero, manda la Y
	ld e,a			;5743
	ld a,d			;5744   ; comparadas
	jr z,tira_por_el_eje_horizontal		;5745
	sub e			;5747   ; y si la X es mayor, manda la X
	jr c,tira_por_el_eje_horizontal		;5748
tira_por_el_eje_vertical:
	ld a,c			;574a   ; el signo de la Y
	ld c,000h		;574b   ; la direccion 0, arriba
	and a			;574d
	jr z,descarta_la_media_vuelta		;574e
	inc c			;5750   ; o la 1, abajo
	jr descarta_la_media_vuelta		;5751
tira_por_el_eje_horizontal:
	ld c,002h		;5753   ; la direccion 2, izquierda
	ld a,b			;5755   ; el signo de la X
	and a			;5756
	jr z,descarta_la_media_vuelta		;5757
	inc c			;5759   ; o la 3, derecha
descarta_la_media_vuelta:
	ld a,(ix+005h)		;575a   ; la direccion que lleva
	ld b,a			;575d
	xor c			;575e   ; comparada con la elegida
	cp 001h		;575f   ; si difieren solo en el bit 0, es media vuelta
	ld a,b			;5761
	jr z,guarda_la_direccion_elegida		;5762   ; y entonces se queda con la que llevaba
	ld a,c			;5764   ; si no, la nueva
guarda_la_direccion_elegida:
	ld (ix+004h),a		;5765   ; la direccion pedida
L_5768:
	ld a,(ix+019h)		;5768   ; el tipo
	cp 005h		;576b   ; el grande va por otro camino
	jp z,mueve_al_grande		;576d
mueve_y_dibuja:
	call recoloca_al_enemigo		;5770   ; lo mueve
	jp mueve_al_enemigo		;5773   ; y lo dibuja

; ----------------------------------------------------------------------
; DATOS direcciones_5776: dos tablas de cuatro pares, cargadas por 0x5706
;   (0x5776) y 0x57f0 (0x577e)
;   0x5776..0x5786  (16 bytes)
DATA_direcciones_5776:
	defb 000h,028h	; 5776
	defb 000h,0e0h	; 5778
	defb 028h,000h	; 577a
	defb 0e0h,000h	; 577c
	defb 000h,0f0h	; 577e
	defb 000h,018h	; 5780
	defb 0f0h,000h	; 5782
	defb 018h,000h	; 5784

; ======================================================================
; CODIGO 0x5786..0x5812  (140 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El tipo 2 no persigue: hace lo MISMO que el jugador, pero con el eje horizontal invertido. Si el jugador va a la izquierda, este va a la derecha.
; El tipo 2 no persigue: hace lo MISMO que el jugador, pero con el eje horizontal invertido. Si el jugador va a la izquierda, este va a la derecha.
; El tipo 2 no persigue: hace lo MISMO que el jugador, pero con el eje horizontal invertido. Si el jugador va a la izquierda, este va a la derecha.
; El tipo 2 no persigue: hace lo MISMO que el jugador, pero con el eje horizontal invertido. Si el jugador va a la izquierda, este va a la derecha.
; El tipo 2 no persigue: hace lo MISMO que el jugador, pero con el eje horizontal invertido. Si el jugador va a la izquierda, este va a la derecha.
; El tipo 2 no persigue: hace lo MISMO que el jugador, pero con el eje horizontal invertido. Si el jugador va a la izquierda, este va a la derecha.
; ----------------------------------------------------------------------
imita_al_jugador:
	ld a,(ix+026h)		;5786   ; acaba de girar?
	and a			;5789
	jr nz,limpia_y_mueve		;578a
	ld a,(0e134h)		;578c   ; la direccion del jugador
	ld c,a			;578f
	inc a			;5790   ; sin direccion, no imita nada
	jr z,guarda_la_direccion_imitada		;5791
	call esta_cuadrado		;5793   ; y solo cambia estando cuadrado
	jr nz,limpia_y_mueve		;5796
	ld a,c			;5798
	cpl			;5799   ; invierte el bit 0
	and 001h		;579a
	ld b,a			;579c
	ld a,c			;579d
	and 002h		;579e   ; conservando el bit 1: el eje no cambia
	or b			;57a0
	ld c,a			;57a1
	ld a,(ix+005h)		;57a2   ; la direccion que lleva
	xor c			;57a5
	cp 001h		;57a6   ; media vuelta, no
	jr z,limpia_y_mueve		;57a8
	ld a,c			;57aa   ; y si no, la imitada
guarda_la_direccion_imitada:
	ld (ix+004h),a		;57ab   ; la direccion pedida
limpia_y_mueve:
	ld (ix+026h),000h		;57ae   ; se limpia la marca de giro
	call recoloca_al_enemigo		;57b2   ; lo mueve
	jp mueve_al_enemigo_simple		;57b5   ; y lo dibuja

; ----------------------------------------------------------------------
; El tipo 3 se dirige al punto ESPEJO del protagonista: en vez de ir hacia el, va hacia donde estaria reflejado, lo que le hace rondar la pantalla en vez de perseguir.
; El tipo 3 se dirige al punto ESPEJO del protagonista: en vez de ir hacia el, va hacia donde estaria reflejado, lo que le hace rondar la pantalla en vez de perseguir.
; El tipo 3 se dirige al punto ESPEJO del protagonista: en vez de ir hacia el, va hacia donde estaria reflejado, lo que le hace rondar la pantalla en vez de perseguir.
; El tipo 3 se dirige al punto ESPEJO del protagonista: en vez de ir hacia el, va hacia donde estaria reflejado, lo que le hace rondar la pantalla en vez de perseguir.
; El tipo 3 se dirige al punto ESPEJO del protagonista: en vez de ir hacia el, va hacia donde estaria reflejado, lo que le hace rondar la pantalla en vez de perseguir.
; El tipo 3 se dirige al punto ESPEJO del protagonista: en vez de ir hacia el, va hacia donde estaria reflejado, lo que le hace rondar la pantalla en vez de perseguir.
; ----------------------------------------------------------------------
va_al_punto_espejo:
	ld hl,(0e130h)		;57b8   ; donde esta el protagonista
	ld a,(ix+000h)		;57bb   ; y donde el enemigo
	ld e,l			;57be
	ld d,h			;57bf
	sub l			;57c0   ; la diferencia en X
	jr z,espejo_en_x_igual		;57c1   ; si coinciden, el objetivo es esa misma
	jr nc,L_57C8		;57c3
	add a,l			;57c5   ; reflejada por un lado
	jr guarda_el_espejo_en_x		;57c6
L_57C8:
	ld l,a			;57c8   ; o por el otro
	ld a,e			;57c9
	sub l			;57ca
guarda_el_espejo_en_x:
	ld (ix+01bh),a		;57cb   ; la X del objetivo
	jr refleja_la_y		;57ce
espejo_en_x_igual:
	ld a,l			;57d0
	ld (ix+01bh),a		;57d1   ; la misma X
refleja_la_y:
	ld a,(ix+001h)		;57d4   ; la Y del enemigo
	sub h			;57d7   ; menos la del protagonista
	jr z,espejo_en_y_igual		;57d8
	jr nc,L_57DF		;57da
	add a,h			;57dc   ; reflejada por un lado
	jr guarda_el_espejo_en_y		;57dd
L_57DF:
	ld h,a			;57df   ; o por el otro
	ld a,d			;57e0
	sub h			;57e1
guarda_el_espejo_en_y:
	ld (ix+01ch),a		;57e2   ; la Y del objetivo
	jr L_57EB		;57e5
espejo_en_y_igual:
	ld a,h			;57e7
	ld (ix+01ch),a		;57e8   ; la misma Y
L_57EB:
	jr L_5804		;57eb

; ----------------------------------------------------------------------
; El tipo 4 es como el 1 pero con la otra tabla de adelanto, la de 0x577e: corta el paso mas cerca.
; El tipo 4 es como el 1 pero con la otra tabla de adelanto, la de 0x577e: corta el paso mas cerca.
; El tipo 4 es como el 1 pero con la otra tabla de adelanto, la de 0x577e: corta el paso mas cerca.
; El tipo 4 es como el 1 pero con la otra tabla de adelanto, la de 0x577e: corta el paso mas cerca.
; El tipo 4 es como el 1 pero con la otra tabla de adelanto, la de 0x577e: corta el paso mas cerca.
; El tipo 4 es como el 1 pero con la otra tabla de adelanto, la de 0x577e: corta el paso mas cerca.
; ----------------------------------------------------------------------
persigue_con_el_otro_adelanto:
	ld a,(0e135h)		;57ed   ; la direccion del jugador
	ld hl,0577eh		;57f0   ; la otra tabla de adelantos
	push ix		;57f3
	ld ix,0e130h		;57f5
	call suma_el_paso		;57f9   ; sumado a la posicion del jugador
	pop ix		;57fc
	ld (ix+01bh),l		;57fe   ; y ese es su objetivo
	ld (ix+01ch),h		;5801
L_5804:
	jp persigue_el_objetivo		;5804
espera_el_enemigo:
	ld a,(ix+02fh)		;5807   ; la cuenta de espera
	and a			;580a
	jr z,$+15		;580b   ; a cero, sigue como siempre
	dec a			;580d   ; y si no, un cuadro menos y a esperar
	ld (ix+02fh),a		;580e
	ret			;5811

; ----------------------------------------------------------------------
; DATOS tabla_5812: cuatro pares; la carga 0x5842
;   0x5812..0x581a  (8 bytes)
DATA_tabla_5812:
	defb 000h,0ffh	; 5812
	defb 0bfh,000h	; 5814
	defb 000h,000h	; 5816
	defb 0bfh,0ffh	; 5818

; ======================================================================
; CODIGO 0x581a..0x5adc  (706 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; El grande alterna dos comportamientos con la bandera de 0xE2D8: o recorre un camino fijo sacado de la tabla de 0x5812, o se va derecho al primer objeto que quede en la lista.
; El grande alterna dos comportamientos con la bandera de 0xE2D8: o recorre un camino fijo sacado de la tabla de 0x5812, o se va derecho al primer objeto que quede en la lista.
; El grande alterna dos comportamientos con la bandera de 0xE2D8: o recorre un camino fijo sacado de la tabla de 0x5812, o se va derecho al primer objeto que quede en la lista.
; El grande alterna dos comportamientos con la bandera de 0xE2D8: o recorre un camino fijo sacado de la tabla de 0x5812, o se va derecho al primer objeto que quede en la lista.
; El grande alterna dos comportamientos con la bandera de 0xE2D8: o recorre un camino fijo sacado de la tabla de 0x5812, o se va derecho al primer objeto que quede en la lista.
; ----------------------------------------------------------------------
elige_el_objetivo_del_grande:
	ld hl,(0e2d9h)		;581a   ; su reloj
	inc hl			;581d   ; un cuadro mas
	ld (0e2d9h),hl		;581e
	ld a,(0e2d8h)		;5821   ; la bandera de que camino sigue
	rra			;5824   ; el bit 0 elige
	jr nc,mira_si_cambia_de_camino		;5825
	bit 7,l		;5827   ; el bit 7 del reloj corta el camino fijo
	jr z,sigue_el_camino_fijo		;5829
	xor a			;582b   ; se cambia de comportamiento
	ld (0e2d8h),a		;582c
	ld hl,00000h		;582f   ; y el reloj vuelve a cero
	ld (0e2d9h),hl		;5832
	jr guarda_el_objetivo_del_grande		;5835
sigue_el_camino_fijo:
	ld a,l			;5837   ; la parte baja del reloj
	and 0f0h		;5838   ; su medio byte alto
	srl a		;583a   ; cuatro desplazamientos: uno de dieciseis
	srl a		;583c
	srl a		;583e
	srl a		;5840
	ld hl,05812h		;5842   ; la tabla del camino
	call lee_puntero_de_tabla		;5845   ; el punto que toca
	ex de,hl			;5848   ; y ese es el objetivo
	jr guarda_el_objetivo_del_grande		;5849
mira_si_cambia_de_camino:
	bit 0,h		;584b   ; el bit 0 de la parte alta
	jr z,va_a_por_el_primer_objeto		;584d
	ld a,001h		;584f   ; se pasa al camino fijo
	ld (0e2d8h),a		;5851
	ld hl,00000h		;5854   ; con el reloj a cero
	ld (0e2d9h),hl		;5857
va_a_por_el_primer_objeto:
	ld hl,(0e2dfh)		;585a   ; la casilla del primer objeto de la lista
	call direccion_de_patron		;585d   ; convertida a coordenadas
guarda_el_objetivo_del_grande:
	ld (ix+01bh),l		;5860   ; el objetivo, en su bloque
	ld (ix+01ch),h		;5863
	jr $-98		;5866   ; y a perseguirlo
mueve_al_grande:
	jp mueve_y_dibuja		;5868   ; el mismo movimiento que los demas

; ----------------------------------------------------------------------
; El grande borra el objeto sobre el que esta: lo busca en la lista, devuelve a la pantalla lo que habia debajo y lo saca de las dos listas. El jugador pierde ese objeto para siempre.
; El grande borra el objeto sobre el que esta: lo busca en la lista, devuelve a la pantalla lo que habia debajo y lo saca de las dos listas. El jugador pierde ese objeto para siempre.
; El grande borra el objeto sobre el que esta: lo busca en la lista, devuelve a la pantalla lo que habia debajo y lo saca de las dos listas. El jugador pierde ese objeto para siempre.
; El grande borra el objeto sobre el que esta: lo busca en la lista, devuelve a la pantalla lo que habia debajo y lo saca de las dos listas. El jugador pierde ese objeto para siempre.
; El grande borra el objeto sobre el que esta: lo busca en la lista, devuelve a la pantalla lo que habia debajo y lo saca de las dos listas. El jugador pierde ese objeto para siempre.
; ----------------------------------------------------------------------
se_come_un_objeto:
	ld a,(ix+005h)		;586b   ; su direccion
	and a			;586e
	ld c,000h		;586f   ; convertida a numero de 0 a 3
	jr z,busca_el_objeto_de_debajo		;5871
	inc c			;5873
	dec a			;5874
	jr z,busca_el_objeto_de_debajo		;5875
	inc c			;5877
	dec a			;5878
	jr z,busca_el_objeto_de_debajo		;5879
	inc c			;587b
busca_el_objeto_de_debajo:
	ld a,c			;587c   ; la direccion
	ld hl,0e231h		;587d   ; su tabla de pasos
	call lee_puntero_de_tabla		;5880   ; el paso que toca
	ex de,hl			;5883
	ld de,0e2dfh		;5884   ; la lista de casillas
	ld bc,04001h		;5887   ; hasta 0x40 entradas, empezando en 1
	call compara_una_posicion		;588a   ; busca la casilla en la lista
	and a			;588d
	ret z			;588e   ; si no esta, no hay nada que comer
	dec a			;588f   ; el numero que ocupa
	ld (0e2a0h),a		;5890
	push hl			;5893
	ld hl,0e090h		;5894   ; la lista de lo que habia debajo
	call suma_a_a_hl		;5897
	ld a,(hl)			;589a   ; ese patron
	pop hl			;589b
	call 0004dh		;589c   ; BIOS WRTVRM - Writes data in VRAM | devuelto a la pantalla
	ld a,(0e2a0h)		;589f   ; el objeto comido
	ld hl,0e2dfh		;58a2
	call borra_la_posicion		;58a5   ; borrado de la lista
	ld a,(0e067h)		;58a8   ; el estado de la partida
	and 003h		;58ab
	jr nz,aprieta_las_listas		;58ad   ; acabando, sin sonido
	ld a,081h		;58af   ; y su sonido
	call suena		;58b1
aprieta_las_listas:
	ld hl,0e2b5h		;58b4   ; la cuenta de objetos
	dec (hl)			;58b7   ; uno menos
	ld (ix+02fh),010h		;58b8   ; y el grande espera dieciseis cuadros
	ld a,(0e2d8h)		;58bc   ; la bandera de camino
	rra			;58bf
	jr c,saca_el_objeto_comido		;58c0
	ld hl,00000h		;58c2   ; con el reloj a cero
	ld (0e2d9h),hl		;58c5
saca_el_objeto_comido:
	ld hl,0e2dfh		;58c8   ; la lista de casillas
	ld de,0e090h		;58cb   ; la de patrones
	ld b,020h		;58ce   ; y sus 32 huecos
	jp saca_de_la_lista		;58d0

; ----------------------------------------------------------------------
; Un paso de enemigo: si tiene suelo debajo anda, y si no, mira que hay en la casilla para decidir. El grande tiene permiso para pisar las casillas de meta.
; Un paso de enemigo: si tiene suelo debajo anda, y si no, mira que hay en la casilla para decidir. El grande tiene permiso para pisar las casillas de meta.
; Un paso de enemigo: si tiene suelo debajo anda, y si no, mira que hay en la casilla para decidir. El grande tiene permiso para pisar las casillas de meta.
; Un paso de enemigo: si tiene suelo debajo anda, y si no, mira que hay en la casilla para decidir. El grande tiene permiso para pisar las casillas de meta.
; Un paso de enemigo: si tiene suelo debajo anda, y si no, mira que hay en la casilla para decidir. El grande tiene permiso para pisar las casillas de meta.
; ----------------------------------------------------------------------
mueve_al_enemigo:
	call esta_en_el_suelo		;58d3   ; hay suelo?
	jr nc,mira_la_casilla_del_enemigo		;58d6   ; si no, hay que mirar la casilla
	ld a,(ix+019h)		;58d8   ; el tipo
	cp 005h		;58db
	jr z,anda_el_enemigo		;58dd
anda_el_enemigo:
	ld a,(ix+005h)		;58df   ; su direccion
	jp anda_una_celda		;58e2   ; y un paso
mira_la_casilla_del_enemigo:
	ld c,a			;58e5   ; el patron de la casilla
	ld a,(ix+019h)		;58e6   ; el tipo
	cp 005h		;58e9   ; el grande va aparte
	jr nz,los_demas_no_pisan_la_meta		;58eb
	ld a,c			;58ed
	cp 0b6h		;58ee   ; el 0xB6 es un objeto
	jr nz,el_grande_pisa_la_meta		;58f0
	jp se_come_un_objeto		;58f2   ; y se lo come
el_grande_pisa_la_meta:
	cp 0b4h		;58f5   ; las casillas de meta
	jr z,anda_el_enemigo		;58f7
	cp 0b5h		;58f9   ; la otra
	jr z,anda_el_enemigo		;58fb   ; el grande pasa por ellas
	jr recupera_el_objetivo		;58fd
los_demas_no_pisan_la_meta:
	ld a,c			;58ff   ; el patron
	cp 0b4h		;5900   ; las casillas de meta
	jp z,marca_al_enemigo_muerto		;5902
	cp 0b5h		;5905   ; la otra
	jp z,marca_al_enemigo_muerto		;5907   ; a los demas les da la vuelta
recupera_el_objetivo:
	ld l,(ix+01bh)		;590a   ; el objetivo guardado
	ld h,(ix+01ch)		;590d

; ----------------------------------------------------------------------
; Cuando no puede seguir recto, mira las casillas de alrededor y cuenta por cuantos lados puede salir, para decidir si gira o se da la vuelta.
; Cuando no puede seguir recto, mira las casillas de alrededor y cuenta por cuantos lados puede salir, para decidir si gira o se da la vuelta.
; Cuando no puede seguir recto, mira las casillas de alrededor y cuenta por cuantos lados puede salir, para decidir si gira o se da la vuelta.
; Cuando no puede seguir recto, mira las casillas de alrededor y cuenta por cuantos lados puede salir, para decidir si gira o se da la vuelta.
; Cuando no puede seguir recto, mira las casillas de alrededor y cuenta por cuantos lados puede salir, para decidir si gira o se da la vuelta.
; ----------------------------------------------------------------------
busca_por_donde_rodear:
	ld bc,00000h		;5910   ; B y C cuentan las salidas
	ld e,(ix+000h)		;5913   ; donde esta
	ld d,(ix+001h)		;5916
	ld a,(ix+005h)		;5919   ; su direccion
	and a			;591c
	jr z,sale_por_abajo		;591d   ; la 0
	cp 001h		;591f   ; la 1
	jr z,sale_por_arriba		;5921
	cp 002h		;5923   ; la 2
	jr z,rodea_desde_la_derecha		;5925
	cp 003h		;5927   ; la 3
	jr z,rodea_desde_la_izquierda		;5929
	ld a,(ix+009h)		;592b   ; y si no, la que diga el decorado
	ld (ix+004h),a		;592e
mueve_y_marca_el_giro:
	call recoloca_al_enemigo		;5931   ; lo mueve
	ld (ix+026h),001h		;5934   ; y se marca que ha girado este cuadro
	ret			;5938
sale_por_abajo:
	ld d,001h		;5939   ; la direccion contraria
	jr cuenta_las_salidas_verticales		;593b
sale_por_arriba:
	ld d,000h		;593d   ; la contraria
cuenta_las_salidas_verticales:
	ld a,(ix+00dh)		;593f   ; lo que hay debajo
	cp 090h		;5942   ; con 0x90 o mas se puede pasar
	jr nc,L_5948		;5944
	inc b			;5946   ; una salida mas
	inc c			;5947
L_5948:
	ld a,(ix+00eh)		;5948   ; y lo que hay encima
	cp 090h		;594b
	jr nc,elige_salida_vertical		;594d
	inc c			;594f   ; otra salida
elige_salida_vertical:
	ld a,c			;5950   ; cuantas salidas hay
	and a			;5951   ; ninguna: media vuelta
	jr nz,hay_dos_salidas_verticales		;5952
	ld (ix+004h),d		;5954   ; la direccion contraria
	jr mueve_y_marca_el_giro		;5957
hay_dos_salidas_verticales:
	cp 002h		;5959   ; dos salidas: hay que elegir
	jr z,elige_la_vertical_mas_cerca		;595b
	ld a,b			;595d   ; la de arriba estaba libre?
	and a			;595e
	ld a,003h		;595f   ; abajo
	jr z,sale_por_la_unica_vertical		;5961
	dec a			;5963   ; o arriba
sale_por_la_unica_vertical:
	ld (ix+004h),a		;5964   ; la direccion elegida
	jr mueve_y_marca_el_giro		;5967
elige_la_vertical_mas_cerca:
	ld a,l			;5969   ; la distancia al objetivo en X
	sub e			;596a
	jr nc,sale_a_la_izquierda		;596b   ; si el objetivo esta a la derecha
	ld (ix+004h),003h		;596d   ; se va a la derecha
	jr mueve_y_marca_el_giro		;5971
sale_a_la_izquierda:
	ld (ix+004h),002h		;5973   ; y si no, a la izquierda
	jr mueve_y_marca_el_giro		;5977
rodea_desde_la_derecha:
	ld e,003h		;5979   ; la contraria es la 3
	jr cuenta_las_salidas_horizontales		;597b
rodea_desde_la_izquierda:
	ld e,002h		;597d   ; la contraria es la 2
cuenta_las_salidas_horizontales:
	ld a,(ix+00bh)		;597f   ; lo que hay a la derecha
	cp 090h		;5982   ; con 0x90 o mas se pasa
	jr nc,L_5988		;5984
	inc b			;5986   ; una salida
	inc c			;5987
L_5988:
	ld a,(ix+00ch)		;5988   ; y lo que hay a la izquierda
	cp 090h		;598b
	jr nc,elige_salida_horizontal		;598d
	inc c			;598f   ; otra
elige_salida_horizontal:
	ld a,c			;5990   ; cuantas hay
	and a			;5991   ; ninguna: media vuelta
	jr nz,hay_dos_salidas_horizontales		;5992
	ld (ix+004h),e		;5994   ; la contraria
	jr mueve_y_marca_el_giro		;5997
hay_dos_salidas_horizontales:
	cp 002h		;5999   ; dos: hay que elegir
	jr z,elige_la_horizontal_mas_cerca		;599b
	ld a,b			;599d   ; la de la derecha estaba libre?
	and a			;599e
	ld a,001h		;599f   ; una
	jr z,sale_por_la_unica_horizontal		;59a1
	dec a			;59a3   ; o la otra
sale_por_la_unica_horizontal:
	ld (ix+004h),a		;59a4   ; la direccion elegida
	jr mueve_y_marca_el_giro		;59a7
elige_la_horizontal_mas_cerca:
	ld a,h			;59a9   ; la distancia al objetivo en Y
	sub d			;59aa
	jr nc,sale_hacia_arriba		;59ab
	ld (ix+004h),001h		;59ad   ; si esta mas abajo, abajo
	jp mueve_y_marca_el_giro		;59b1
sale_hacia_arriba:
	ld (ix+004h),000h		;59b4   ; y si no, arriba
	jp mueve_y_marca_el_giro		;59b8
marca_al_enemigo_muerto:
	ld (ix+01dh),001h		;59bb   ; el enemigo pasa a muerto
	ret			;59bf
mueve_al_enemigo_simple:
	call esta_en_el_suelo		;59c0   ; hay suelo?
	jr nc,mira_la_meta		;59c3
	ld a,(ix+005h)		;59c5   ; su direccion
	jp anda_una_celda		;59c8   ; y un paso
mira_la_meta:
	cp 0b4h		;59cb   ; las casillas de meta
	jr z,marca_al_enemigo_muerto		;59cd
	cp 0b5h		;59cf   ; la otra
	jr z,marca_al_enemigo_muerto		;59d1
	ld hl,(0e130h)		;59d3   ; y si no, rodea hacia el protagonista
	jp busca_por_donde_rodear		;59d6

; ----------------------------------------------------------------------
; Recoloca al enemigo tras el paso: elige su dibujo, deja que gire si esta dentro del area util y vuelve a leer el decorado de alrededor.
; Recoloca al enemigo tras el paso: elige su dibujo, deja que gire si esta dentro del area util y vuelve a leer el decorado de alrededor.
; Recoloca al enemigo tras el paso: elige su dibujo, deja que gire si esta dentro del area util y vuelve a leer el decorado de alrededor.
; Recoloca al enemigo tras el paso: elige su dibujo, deja que gire si esta dentro del area util y vuelve a leer el decorado de alrededor.
; ----------------------------------------------------------------------
recoloca_al_enemigo:
	call elige_el_dibujo		;59d9   ; su dibujo
	ld a,(ix+001h)		;59dc   ; su altura
	cp 020h		;59df   ; fuera del area util no gira
	jr c,cuadra_y_lee		;59e1
	cp 0d9h		;59e3
	jr nc,cuadra_y_lee		;59e5
	call decide_el_giro_del_enemigo		;59e7   ; dentro, se le deja girar
cuadra_y_lee:
	call recoloca_si_hace_falta		;59ea   ; se cuadra a la casilla
	jp lee_el_decorado_alrededor		;59ed   ; y vuelve a leer el decorado

; ----------------------------------------------------------------------
; El empujon: si el protagonista esta cuadrado y tiene un bloque delante, mira si hay hueco al otro lado -y que no haya nadie- y lo desplaza una casilla.
; El empujon: si el protagonista esta cuadrado y tiene un bloque delante, mira si hay hueco al otro lado -y que no haya nadie- y lo desplaza una casilla.
; El empujon: si el protagonista esta cuadrado y tiene un bloque delante, mira si hay hueco al otro lado -y que no haya nadie- y lo desplaza una casilla.
; El empujon: si el protagonista esta cuadrado y tiene un bloque delante, mira si hay hueco al otro lado -y que no haya nadie- y lo desplaza una casilla.
; ----------------------------------------------------------------------
empuja_el_bloque:
	call apunta_donde_estan_los_enemigos		;59f0   ; prepara el empujon
	ld ix,0e130h		;59f3   ; el bloque del protagonista
	call esta_cuadrado		;59f7   ; solo estando cuadrado
	ret nz			;59fa
	ld a,(ix+004h)		;59fb   ; la direccion pedida
	ld c,a			;59fe
	inc a			;59ff   ; sin direccion, no empuja
	ret z			;5a00
	ld a,(ix+006h)		;5a01   ; lo que tiene delante
	cp 0b6h		;5a04   ; el 0xB6 es el bloque
	ret nz			;5a06   ; cualquier otra cosa, no se empuja
	ld a,c			;5a07
	ld hl,0e141h		;5a08   ; la tabla de pasos
	call lee_puntero_de_tabla		;5a0b
	ex de,hl			;5a0e
	ld de,0e2dfh		;5a0f   ; la lista de bloques
	ld bc,04001h		;5a12   ; hasta 0x40, empezando en 1
	call compara_una_posicion		;5a15   ; busca el bloque en la lista
	and a			;5a18
	ret z			;5a19   ; si no esta, no es de los que se mueven
	dec a			;5a1a   ; su numero
	ld (0e2a4h),hl		;5a1b   ; y su casilla, guardada
	ld (0e2a1h),a		;5a1e
	ld hl,05adch		;5a21   ; la tabla del empujon
	ld a,(ix+004h)		;5a24
	call lee_puntero_de_tabla		;5a27   ; el desplazamiento que le toca
	ld hl,(0e2a4h)		;5a2a
	add hl,de			;5a2d   ; sumado a la casilla del bloque
	ld (0e2a2h),hl		;5a2e   ; ahi iria a parar
	call 0004ah		;5a31   ; BIOS RDVRM - Reads the content of VRAM
	cp 090h		;5a34   ; con 0x90 o mas hay sitio
	ret nc			;5a36   ; y si no, no se puede empujar
mira_que_no_haya_nadie:
	ld hl,(0e2a4h)		;5a37   ; la casilla de destino
	ld ix,0e05eh		;5a3a   ; los cuatro enemigos
	ld b,004h		;5a3e   ; cuatro
comprueba_un_enemigo:
	ld e,(ix+000h)		;5a40   ; donde esta
	inc ix		;5a43
	ld d,(ix+000h)		;5a45   ; los dos bytes de su casilla
	inc ix		;5a48
	call son_la_misma_casilla		;5a4a   ; esta ahi?
	ret z			;5a4d   ; si esta, no se empuja
	djnz comprueba_un_enemigo		;5a4e   ; los cuatro
comprueba_el_marcador:
	ld hl,(0e2a2h)		;5a50   ; la casilla de destino
	ld de,03964h		;5a53   ; la zona del marcador
	ld b,003h		;5a56   ; tres celdas
comprueba_una_celda_del_marcador:
	call son_la_misma_casilla		;5a58   ; cae ahi?
	ret z			;5a5b   ; si cae, no se empuja
	ld a,020h		;5a5c   ; una fila mas abajo
	call suma_a_a_de		;5a5e
	djnz comprueba_una_celda_del_marcador		;5a61   ; las tres
	ld de,0397bh		;5a63   ; y la otra zona del marcador
	ld b,003h		;5a66   ; otras tres
comprueba_el_otro_marcador:
	call son_la_misma_casilla		;5a68   ; cae ahi?
	ret z			;5a6b   ; si cae, no se empuja
	ld a,020h		;5a6c   ; una fila mas abajo
	call suma_a_a_de		;5a6e
	djnz comprueba_el_otro_marcador		;5a71   ; las tres
	call direccion_de_patron		;5a73   ; la casilla, a coordenadas
	ld ix,0e160h		;5a76   ; los enemigos
	ld b,006h		;5a7a   ; seis
mira_que_no_pise_a_nadie:
	ld e,(ix+000h)		;5a7c   ; donde esta el enemigo
	ld d,(ix+001h)		;5a7f
	ld c,008h		;5a82   ; ocho pixeles de margen
	call estan_cerca		;5a84   ; esta encima del destino?
	ret c			;5a87   ; si lo esta, el bloque no se mueve
	ld de,00030h		;5a88   ; el bloque siguiente
	add ix,de		;5a8b
	djnz mira_que_no_pise_a_nadie		;5a8d   ; los seis
	ld ix,0e130h		;5a8f   ; el protagonista
	ld hl,0e090h		;5a93   ; lo que habia debajo del bloque
	ld a,(0e2a1h)		;5a96
	call suma_a_a_hl		;5a99   ; el que toca
	ld a,(hl)			;5a9c
	ld hl,(0e2a4h)		;5a9d
	call 0004dh		;5aa0   ; BIOS WRTVRM - Writes data in VRAM
	ld a,003h		;5aa3   ; el sonido del empujon
	call suena		;5aa5
	ld hl,(0e2a2h)		;5aa8   ; la casilla de destino
	push hl			;5aab
	call 0004ah		;5aac   ; BIOS RDVRM - Reads the content of VRAM
	ld c,a			;5aaf
	ld a,(0e2a1h)		;5ab0   ; el numero del bloque
	ld b,a			;5ab3
	ld hl,0e090h		;5ab4   ; la lista de lo que hay debajo
	call suma_a_a_hl		;5ab7
	ld (hl),c			;5aba   ; el patron nuevo
	ld hl,0e2dfh		;5abb   ; la lista de casillas
	ld a,b			;5abe
	add a,a			;5abf   ; dos bytes por entrada
	call suma_a_a_hl		;5ac0
	pop de			;5ac3
	ld (hl),e			;5ac4   ; y la casilla nueva
	inc hl			;5ac5
	ld (hl),d			;5ac6
	ex de,hl			;5ac7
	ld a,0b6h		;5ac8   ; el patron del bloque
	call 0004dh		;5aca   ; BIOS WRTVRM - Writes data in VRAM
	call elige_el_dibujo		;5acd   ; el dibujo del protagonista
	call decide_el_giro		;5ad0   ; su giro
	jp recoloca_si_hace_falta		;5ad3   ; y se recoloca

; ----------------------------------------------------------------------
; Compara dos casillas, byte a byte. Devuelve Z cuando coinciden.
; Compara dos casillas, byte a byte. Devuelve Z cuando coinciden.
; Compara dos casillas, byte a byte. Devuelve Z cuando coinciden.
; ----------------------------------------------------------------------
son_la_misma_casilla:
	ld a,e			;5ad6   ; el byte bajo
	cp l			;5ad7
	ret nz			;5ad8   ; si no coincide, no son la misma
	ld a,d			;5ad9   ; y el alto
	cp h			;5ada
	ret			;5adb

; ----------------------------------------------------------------------
; DATOS tabla_5adc: cuatro pares; la carga 0x5a21
;   0x5adc..0x5ae4  (8 bytes)
DATA_tabla_5adc:
	defb 001h,000h	; 5adc
	defb 0ffh,0ffh	; 5ade
	defb 020h,000h	; 5ae0
	defb 0e0h,0ffh	; 5ae2

; ======================================================================
; CODIGO 0x5ae4..0x5c76  (402 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Antes de empujar hay que saber por donde andan: apunta la casilla de cada enemigo, o 0xFFFF si esta escondido.
; Antes de empujar hay que saber por donde andan: apunta la casilla de cada enemigo, o 0xFFFF si esta escondido.
; Antes de empujar hay que saber por donde andan: apunta la casilla de cada enemigo, o 0xFFFF si esta escondido.
; ----------------------------------------------------------------------
apunta_donde_estan_los_enemigos:
	ld de,0e05eh		;5ae4   ; donde se apuntan
	ld hl,(0e160h)		;5ae7   ; el primer enemigo
	call apunta_un_enemigo		;5aea
	ld hl,(0e190h)		;5aed   ; el segundo
	call apunta_un_enemigo		;5af0
	ld hl,(0e1c0h)		;5af3   ; el tercero
	call apunta_un_enemigo		;5af6
	ld hl,(0e1f0h)		;5af9   ; y el cuarto
apunta_un_enemigo:
	ld a,l			;5afc   ; su coordenada
	cp 0e0h		;5afd   ; 0xE0 es el valor de escondido
	jr nz,marca_enemigo_ausente		;5aff
	inc de			;5b01   ; y entonces se salta su hueco
	inc de			;5b02
	ret			;5b03
marca_enemigo_ausente:
	ld a,0ffh		;5b04   ; 0xFFFF: no esta en ninguna casilla
	ld (de),a			;5b06   ; los dos bytes
	inc de			;5b07
	ld (de),a			;5b08
	inc de			;5b09
	ret			;5b0a

; ----------------------------------------------------------------------
; A partir de la zona 10, si el jugador se esta quieto demasiado tiempo, el juego le mete prisa: a los 64 cuadros sin mover el mando, arranca el derrumbe.
; A partir de la zona 10, si el jugador se esta quieto demasiado tiempo, el juego le mete prisa: a los 64 cuadros sin mover el mando, arranca el derrumbe.
; A partir de la zona 10, si el jugador se esta quieto demasiado tiempo, el juego le mete prisa: a los 64 cuadros sin mover el mando, arranca el derrumbe.
; ----------------------------------------------------------------------
cuenta_para_el_derrumbe:
	ld a,(0e053h)		;5b0b   ; la zona
	sub 00ah		;5b0e   ; antes de la 10 no pasa nada
	ret c			;5b10
	ld a,(0e134h)		;5b11   ; la direccion pulsada
	inc a			;5b14
	ret z			;5b15   ; si se esta moviendo, no cuenta
	ld hl,0e346h		;5b16   ; el contador de quietud
	inc (hl)			;5b19   ; uno mas
	ld a,(hl)			;5b1a
	sub 040h		;5b1b   ; a los 64
	ret nz			;5b1d
	inc a			;5b1e
	ld (0e340h),a		;5b1f   ; se enciende el derrumbe
	ret			;5b22
busca_por_donde_derrumbar:
	ld hl,0e360h		;5b23   ; la lista de casillas del derrumbe
	ld (0e2a0h),hl		;5b26
	ld a,(0e130h)		;5b29   ; la columna del protagonista
	ld l,a			;5b2c
	ld h,000h		;5b2d
	call celda_de_coordenadas		;5b2f   ; su casilla
	ld (0e342h),hl		;5b32   ; guardada
	ld de,0e348h		;5b35   ; donde se apuntan las casillas
	ld bc,02001h		;5b38   ; hasta 0x20
mira_la_casilla_del_derrumbe:
	ld (0e2a2h),hl		;5b3b   ; la casilla
	call 0004ah		;5b3e   ; BIOS RDVRM - Reads the content of VRAM
	cp 090h		;5b41   ; los tres patrones por los que se puede derrumbar
	jr z,sigue_buscando		;5b43
	cp 093h		;5b45   ; el segundo
	jr z,sigue_buscando		;5b47
	cp 094h		;5b49   ; y el tercero
	jr z,sigue_buscando		;5b4b
	cp 095h		;5b4d
	jr z,sigue_buscando		;5b4f
	cp 096h		;5b51
	jr z,sigue_buscando		;5b53
	cp 098h		;5b55
	jr nz,mira_donde_cae_el_derrumbe		;5b57
sigue_buscando:
	ld ix,(0e2a0h)		;5b59   ; la siguiente casilla
	ld hl,(0e2a2h)		;5b5d   ; la casilla encontrada
	ld (ix+000h),l		;5b60   ; apuntada en la lista
	ld (ix+001h),h		;5b63
	push ix		;5b66
	pop hl			;5b68
	inc hl			;5b69   ; dos bytes por entrada
	inc hl			;5b6a
	ld (0e2a0h),hl		;5b6b   ; y ese es el hueco siguiente
	ld (de),a			;5b6e
	inc de			;5b6f

; ----------------------------------------------------------------------
; Recorre la columna del protagonista buscando por donde se abre el derrumbe, y luego usa su fila para sacar de la tabla de 0xE348 la casilla que le toca.
; Recorre la columna del protagonista buscando por donde se abre el derrumbe, y luego usa su fila para sacar de la tabla de 0xE348 la casilla que le toca.
; ----------------------------------------------------------------------
mira_donde_cae_el_derrumbe:
	ld hl,(0e342h)		;5b70   ; la casilla de partida
	ld a,c			;5b73
	call suma_a_a_hl		;5b74   ; avanzada la cuenta
	inc c			;5b77   ; la casilla siguiente
	djnz mira_la_casilla_del_derrumbe		;5b78   ; hasta agotar la columna
	ld a,(0e131h)		;5b7a   ; la fila del protagonista
	and 0f0h		;5b7d   ; su medio byte alto
	rlca			;5b7f   ; cuatro vueltas: la fila en celdas
	rlca			;5b80
	rlca			;5b81
	rlca			;5b82
	dec a			;5b83   ; dos menos: la fila del derrumbe
	dec a			;5b84
	ld c,a			;5b85
	ld hl,0e348h		;5b86   ; la tabla de casillas
	call suma_a_a_hl		;5b89   ; indexada por la fila
	ld a,(hl)			;5b8c   ; y la casilla que toca
	and a			;5b8d
	jr z,L_5BE3		;5b8e
	ld b,a			;5b90
	ld hl,0e360h		;5b91
	ld a,c			;5b94
	call lee_puntero_de_tabla		;5b95
	ex de,hl			;5b98
	call direccion_de_patron		;5b99
	ld (0e344h),hl		;5b9c
	ex de,hl			;5b9f
	ld hl,0e340h		;5ba0
	ld a,b			;5ba3
	cp 090h		;5ba4
	jr z,L_5BC3		;5ba6
	cp 093h		;5ba8
	jr z,L_5BC3		;5baa
	cp 094h		;5bac
	jr z,pasa_al_derrumbe_siguiente		;5bae
	cp 095h		;5bb0
	jr z,pasa_al_derrumbe_siguiente		;5bb2
	cp 096h		;5bb4
	jr z,L_5BC3		;5bb6
	cp 098h		;5bb8
pasa_al_derrumbe_siguiente:
	ex de,hl			;5bba   ; el siguiente
	ld a,h			;5bbb
	sub 005h		;5bbc
	ld h,a			;5bbe
	ld a,064h		;5bbf
	jr derrumba_una_casilla		;5bc1
L_5BC3:
	set 7,(hl)		;5bc3
	ex de,hl			;5bc5
	inc h			;5bc6
	ld a,068h		;5bc7
derrumba_una_casilla:
	ld (0e0eah),a		;5bc9   ; la casilla que se derrumba
	ld a,l			;5bcc   ; la columna
	sub 004h		;5bcd   ; cuatro pixeles a la izquierda
	ld l,a			;5bcf
	ld (0e0e8h),hl		;5bd0   ; la posicion del derrumbe
	ld hl,0e340h		;5bd3   ; su estado
	ld a,(hl)			;5bd6
	and 080h		;5bd7   ; se conserva el bit 7, que dice de que lado viene
	add a,002h		;5bd9   ; y se pone en el estado 2
	ld (hl),a			;5bdb
	ld hl,00000h		;5bdc   ; con el paso de la animacion a cero
	ld (0e347h),hl		;5bdf
	ret			;5be2
L_5BE3:
	xor a			;5be3
	ld hl,0e340h		;5be4
	ld b,030h		;5be7
L_5BE9:
	ld (hl),a			;5be9
	inc hl			;5bea
	djnz L_5BE9		;5beb
	ret			;5bed
anima_el_derrumbe:
	ld hl,0e347h		;5bee   ; el paso de la animacion
	inc (hl)			;5bf1   ; un paso mas
	ld a,(hl)			;5bf2
	cp 0a0h		;5bf3   ; en el 0xA0 pasa una cosa
	jr z,L_5C08		;5bf5
	cp 0b0h		;5bf7   ; en el 0xB0 otra
	jr z,L_5C41		;5bf9
	cp 0e0h		;5bfb   ; y en el 0xE0 se acaba
	ret nz			;5bfd
	ld a,0e0h		;5bfe   ; los dos sprites del derrumbe
	ld (0e0e8h),a		;5c00   ; escondidos
	ld (0e0ech),a		;5c03
	jr L_5BE3		;5c06
L_5C08:
	ld a,(0e067h)		;5c08
	and 003h		;5c0b
	jr nz,arranca_el_derrumbe		;5c0d
	ld a,002h		;5c0f
	call suena		;5c11

; ----------------------------------------------------------------------
; Enciende el derrumbe y coloca sus dos sprites, eligiendo el dibujo y el desplazamiento segun de que lado viene.
; Enciende el derrumbe y coloca sus dos sprites, eligiendo el dibujo y el desplazamiento segun de que lado viene.
; ----------------------------------------------------------------------
arranca_el_derrumbe:
	ld hl,0e0eeh		;5c14   ; el hueco de sprite del derrumbe
	ld a,(0e340h)		;5c17   ; el estado
	rla			;5c1a   ; el bit 7 dice de que lado viene
	ld a,006h		;5c1b   ; el estado 6: cayendo
	ld (0e340h),a		;5c1d
	jr c,avanza_el_derrumbe		;5c20   ; por un lado o por el otro
	ld (hl),06ch		;5c22   ; su dibujo
	ld hl,(0e0e8h)		;5c24   ; la posicion de partida
	ld a,l			;5c27
	sub 004h		;5c28   ; cuatro pixeles a la izquierda
	ld l,a			;5c2a
	ld a,h			;5c2b
	add a,009h		;5c2c   ; y nueve mas abajo
	jr L_5C3C		;5c2e
avanza_el_derrumbe:
	ld (hl),070h		;5c30   ; la casilla siguiente
	ld hl,(0e0e8h)		;5c32
	ld a,l			;5c35
	sub 004h		;5c36
	ld l,a			;5c38
	ld a,h			;5c39
	sub 00fh		;5c3a
L_5C3C:
	ld h,a			;5c3c
	ld (0e0ech),hl		;5c3d
	ret			;5c40
L_5C41:
	ld a,0e0h		;5c41
	ld (0e0ech),a		;5c43
	ld a,002h		;5c46
	ld (0e340h),a		;5c48
	ret			;5c4b

; ----------------------------------------------------------------------
; Comprueba si el derrumbe alcanza al protagonista: se le suma un margen de tres y cuatro pixeles a la posicion del derrumbe y se mide la distancia.
; Comprueba si el derrumbe alcanza al protagonista: se le suma un margen de tres y cuatro pixeles a la posicion del derrumbe y se mide la distancia.
; ----------------------------------------------------------------------
mira_si_le_pilla_el_derrumbe:
	ld a,(0e340h)		;5c4c   ; el estado del derrumbe
	and 004h		;5c4f   ; el bit 2 dice si esta cayendo
	ret z			;5c51   ; si no cae, no pilla a nadie
	ld hl,(0e130h)		;5c52   ; donde esta el protagonista
	ld de,(0e0ech)		;5c55   ; y donde el derrumbe
	ld a,e			;5c59
	add a,003h		;5c5a   ; tres pixeles de margen en X
	ld e,a			;5c5c
	ld a,d			;5c5d
	add a,004h		;5c5e   ; y cuatro en Y
	ld d,a			;5c60
	ld a,l			;5c61   ; la distancia
	sub e			;5c62
	jr nc,termina_el_derrumbe		;5c63
	neg		;5c65   ; en valor absoluto
termina_el_derrumbe:
	cp 006h		;5c67   ; se apaga el derrumbe
	ret nc			;5c69
	ld a,h			;5c6a
	sub d			;5c6b
	jr nc,L_5C70		;5c6c
	neg		;5c6e
L_5C70:
	cp 008h		;5c70
	ret nc			;5c72
	jp marca_la_llegada		;5c73

; ----------------------------------------------------------------------
; DATOS guion_marcador: "HI" y "ZONE" del marcador, en cinco destinos; 0x5c93
;   es una entrada alternativa al mismo guion, la de "BONUS"
;   0x5c76..0x5c9c  (38 bytes)
DATA_guion_marcador:
	defb 00dh,038h,028h,029h,020h,0feh,037h,038h,03ah,02fh,02eh,025h,020h,0feh,017h,038h	; 5c76  .8() .78:/.% ..8
	defb 032h,025h,033h,034h,020h,0feh,002h,038h,039h,02fh,035h,020h,0feh,022h,038h,022h	; 5c86  2%34 ..89/5 ."8"
	defb 02fh,02eh,035h,033h,020h,0ffh	; 5c96

; ----------------------------------------------------------------------
; DATOS guion_5c9c: cinco patrones sueltos en 0x3822
;   0x5c9c..0x5ca4  (8 bytes)
DATA_guion_5c9c:
	defb 022h,038h,088h,089h,08ah,08bh,08ch,0ffh	; 5c9c  "8......

; ----------------------------------------------------------------------
; DATOS guion_presentacion: "PUSH SPACE KEY" y el resto de la pantalla de
;   titulo, diez destinos
;   0x5ca4..0x5cfc  (88 bytes)
DATA_guion_presentacion:
	defb 08ah,039h,030h,035h,033h,028h,000h,033h,030h,021h,023h,025h,000h,02bh,025h,039h	; 5ca4  .9053(.30!#%.+%9
	defb 0feh,00bh,039h,01ah,02bh,02fh,02eh,021h,02dh,029h,000h,011h,019h,018h,015h,0feh	; 5cb4  ..9.+/.!-)......
	defb 0f7h,039h,09fh,09eh,0b9h,0feh,016h,03ah,09fh,09fh,09eh,0b9h,0b9h,0feh,037h,03ah	; 5cc4  .9.....:......7:
	defb 0bch,0bbh,0bdh,0feh,058h,03ah,0bah,0feh,078h,03ah,0bah,0feh,098h,03ah,0bah,0feh	; 5cd4  ....X:..x:...:..
	defb 0b3h,03ah,079h,078h,078h,078h,078h,07fh,078h,078h,07ah,0feh,0d3h,03ah,07bh,07dh	; 5ce4  .:yxxxx.xxz..:{}
	defb 07eh,07dh,07eh,07dh,07eh,07dh,07ch,0ffh	; 5cf4  ~}~}~}|.

; ----------------------------------------------------------------------
; DATOS guion_game_over: "GAME OVER" en un solo destino; lo carga 0x4271
;   0x5cfc..0x5d09  (13 bytes)
DATA_guion_game_over:
	defb 06bh,039h,027h,021h,02dh,025h,000h,000h,02fh,036h,025h,032h,0ffh	; 5cfc  k9'!-%../6%2.

; ----------------------------------------------------------------------
; DATOS guion_zone: "ZONE", el rotulo que se repinta al cambiar de zona
;   0x5d09..0x5d10  (7 bytes)
DATA_guion_zone:
	defb 02dh,039h,03ah,02fh,02eh,025h,0ffh	; 5d09

; ----------------------------------------------------------------------
; DATOS guion_bonus_stage: "BONUS STAGE", el rotulo de una zona de cada cinco;
;   lo carga 0x4476
;   0x5d10..0x5d1e  (14 bytes)
DATA_guion_bonus_stage:
	defb 02bh,039h,022h,02fh,02eh,035h,033h,000h,033h,034h,021h,027h,025h,0ffh	; 5d10  +9"/.53.34!'%.

; ----------------------------------------------------------------------
; DATOS grafico_5d1e: 86 bytes descomprimidos y otros 8 en 0x396c; lo carga
;   0x413d
;   0x5d1e..0x5d2f  (17 bytes)
DATA_grafico_5d1e:
	defb 04ah,039h,00ch,05ah,080h,06ch,039h,088h,033h,02fh,026h,034h,037h,021h,032h,025h	; 5d1e  J9.Z.l9.3/&47!2%
	defb 000h	; 5d2e

; ----------------------------------------------------------------------
; DATOS guion_konami_pts: "KONAMI 5730 PTS", el aviso de la puntuacion de la
;   casa; lo carga 0x4928
;   0x5d2f..0x5d42  (19 bytes)
DATA_guion_konami_pts:
	defb 088h,039h,02bh,02fh,02eh,021h,02dh,029h,000h,000h,015h,017h,013h,010h,000h,030h	; 5d2f  .9+/.!-).......0
	defb 034h,033h,0ffh	; 5d3f

; ----------------------------------------------------------------------
; DATOS guion_perfect_bonus: "PERFECT BONUS", dos destinos
;   0x5d42..0x5d68  (38 bytes)
DATA_guion_perfect_bonus:
	defb 068h,039h,084h,084h,030h,025h,032h,026h,025h,023h,034h,000h,022h,02fh,02eh,035h	; 5d42  h9..0%2&%#4."/.5
	defb 033h,084h,0feh,0a8h,039h,084h,084h,084h,084h,011h,010h,010h,010h,010h,000h,030h	; 5d52  3...9..........0
	defb 034h,033h,084h,084h,084h,0ffh	; 5d62

; ----------------------------------------------------------------------
; DATOS guion_pause: "PAUSE"; lo cargan 0x40f5 y 0x4117, que son las dos ramas
;   del mismo estado
;   0x5d68..0x5d70  (8 bytes)
DATA_guion_pause:
	defb 02fh,038h,030h,021h,035h,033h,025h,0ffh	; 5d68  /80!53%.

; ----------------------------------------------------------------------
; DATOS guion_no_big_razzon: "NO BIG RAZZON", el aviso de que falta el enemigo
;   grande; lo carga 0x41db
;   0x5d70..0x5d82  (18 bytes)
DATA_guion_no_big_razzon:
	defb 009h,03ah,02eh,02fh,000h,022h,029h,027h,000h,032h,021h,03ah,03ah,02fh,02eh,000h	; 5d70  .:./.")'.2!::/..
	defb 03bh,0ffh	; 5d80

; ----------------------------------------------------------------------
; DATOS guion_de_la_demostracion: 54 bytes comprimidos que dan 77 pulsaciones;
;   0x437d lo descomprime a 0xE342 y L_468F lo reproduce
;   0x5d82..0x5db8  (54 bytes)
DATA_guion_de_la_demostracion:
	defb 006h,002h,007h,008h,088h,002h,004h,004h,002h,008h,002h,002h,008h,004h,002h,087h	; 5d82  ................
	defb 004h,018h,004h,002h,004h,004h,018h,003h,004h,002h,001h,081h,004h,004h,001h,002h	; 5d92  ................
	defb 008h,081h,001h,00ah,008h,002h,001h,002h,008h,083h,002h,008h,008h,005h,001h,003h	; 5da2  ................
	defb 004h,006h,008h,081h,0ffh,000h	; 5db2

; ======================================================================
; CODIGO 0x5db8..0x5e0e  (86 bytes)
; ======================================================================


L_5DB8:
	ld hl,00000h		;5db8
	call L_5DD5		;5dbb
	ld hl,00800h		;5dbe
	call L_5DD5		;5dc1
	ld hl,01000h		;5dc4
	call L_5DD5		;5dc7
	ld a,060h		;5dca
	ld hl,01080h		;5dcc
	ld bc,00180h		;5dcf
	jp 00056h		;5dd2   ; BIOS FILVRM - Fills VRAM with value

; ----------------------------------------------------------------------
; Carga un tercio de la pantalla: pone en blanco el color del patron 0, rellena 600 bytes de color con 0xF0 -tinta 15 sobre fondo transparente- y descomprime encima los tres bloques de patrones y colores. Se llama tres veces, una por tercio.
; ----------------------------------------------------------------------
L_5DD5:
	push hl			;5dd5   ; la base del tercio, guardada
	xor a			;5dd6
	ld bc,00008h		;5dd7   ; ocho bytes: el color del patron 0
	call 00056h		;5dda   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;5ddd
	push hl			;5dde
	ld de,00080h		;5ddf   ; 0x80 son dieciseis patrones
	add hl,de			;5de2
	ld bc,00258h		;5de3   ; 600 bytes de color
	ld a,0f0h		;5de6   ; tinta 15 sobre fondo transparente
	call 00056h		;5de8   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;5deb
	push hl			;5dec
	ld de,003c0h		;5ded   ; 0x3C0 son los patrones 0x78 en adelante
	add hl,de			;5df0
	ld de,0753dh		;5df1
	call descomprime_a_vram		;5df4
	pop hl			;5df7
	ld de,02000h		;5df8
	add hl,de			;5dfb
	push hl			;5dfc
	ld de,05e0eh		;5dfd
	call descomprime_a_vram		;5e00
	pop hl			;5e03
	ld de,003c0h		;5e04
	add hl,de			;5e07
	ld de,0722bh		;5e08
	jp descomprime_a_vram		;5e0b

; ----------------------------------------------------------------------
; DATOS grafico_5e0e: 426 comprimidos -> 728 en la VRAM; lo carga 0x5dfd
;   0x5e0e..0x5fb8  (426 bytes)
DATA_grafico_5e0e:
	defb 040h,000h,040h,000h,083h,000h,01ch,022h,003h,063h,085h,022h,01ch,000h,018h,038h	; 5e0e  @.@....".c."...8
	defb 004h,018h,0aeh,07eh,000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h	; 5e1e  ...~.>c..<p..>c.
	defb 00eh,003h,063h,03eh,000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh	; 5e2e  ..c>...6ff....`~
	defb 063h,003h,063h,03eh,000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h	; 5e3e  c.c>.>c`~cc>..c.
	defb 00ch,003h,018h,098h,000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h	; 5e4e  .....>cc>cc>.>cc
	defb 03fh,003h,063h,03eh,03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,02ch,000h,081h,07eh	; 5e5e  ?.c><B....B<,..~
	defb 004h,000h,092h,01ch,036h,063h,063h,07fh,063h,063h,000h,07eh,063h,063h,07eh,063h	; 5e6e  ....6cc.cc.~cc~c
	defb 063h,07eh,000h,03eh,063h,003h,060h,082h,063h,03eh,009h,000h,08ch,07fh,060h,060h	; 5e7e  c~.>c.`.c>....``
	defb 07eh,060h,060h,07fh,000h,07fh,060h,060h,07eh,003h,060h,089h,000h,03eh,063h,060h	; 5e8e  ~``...``~.`..>c`
	defb 067h,063h,063h,03fh,000h,003h,063h,081h,07fh,003h,063h,082h,000h,03ch,005h,018h	; 5e9e  gcc?..c...c..<..
	defb 081h,03ch,009h,000h,087h,063h,066h,06ch,078h,07ch,06eh,067h,009h,000h,091h,063h	; 5eae  .<...cflx|ng...c
	defb 077h,07fh,07fh,06bh,063h,063h,000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh	; 5ebe  w..kcc.cs{.ogc.>
	defb 005h,063h,083h,03eh,000h,07eh,003h,063h,083h,07eh,060h,060h,009h,000h,091h,07eh	; 5ece  .c.>.~.c.~``...~
	defb 063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h,03eh,000h,07eh	; 5ede  ccb|fc.>c`>.c>.~
	defb 006h,018h,081h,000h,006h,063h,082h,03eh,000h,004h,063h,08bh,036h,01ch,008h,000h	; 5eee  .....c.>..c.6...
	defb 063h,063h,06bh,06bh,07fh,077h,022h,009h,000h,002h,066h,082h,07eh,03ch,003h,018h	; 5efe  cckk.w"...f.~<..
	defb 089h,000h,07fh,007h,00eh,01ch,038h,070h,07fh,018h,003h,03ch,084h,018h,000h,018h	; 5f0e  ......8p...<....
	defb 018h,020h,000h,00fh,000h,001h,001h,006h,000h,082h,0ffh,0feh,008h,00fh,084h,0c3h	; 5f1e  . ..............
	defb 0c7h,0cfh,0dfh,003h,0ffh,089h,0feh,0fch,0f8h,0f0h,0e0h,0c0h,080h,007h,007h,005h	; 5f2e  ................
	defb 000h,083h,003h,0cfh,0dfh,005h,000h,083h,0e1h,0f9h,07dh,005h,000h,083h,0efh,0ffh	; 5f3e  ..........}.....
	defb 0f7h,005h,000h,083h,007h,08fh,09eh,005h,000h,083h,0f0h,0f8h,078h,005h,000h,083h	; 5f4e  ............x...
	defb 0f7h,0ffh,0fbh,005h,000h,08bh,08fh,0dfh,0f7h,00ch,01eh,01eh,00ch,000h,01eh,09eh	; 5f5e  ................
	defb 09eh,008h,00fh,090h,0ffh,0ffh,0dfh,0cfh,0c7h,0c3h,0c1h,0c0h,007h,087h,0c7h,0efh	; 5f6e  ................
	defb 0ffh,0ffh,0ffh,0fch,004h,0deh,084h,09eh,09fh,00fh,003h,005h,03dh,083h,07dh,0f9h	; 5f7e  ............=.}.
	defb 0e1h,008h,0e3h,090h,0dch,0c0h,0c7h,0deh,0dch,0deh,0cfh,0c3h,03ch,07ch,0fch,03ch	; 5f8e  ............<|.<
	defb 03ch,07ch,0fch,0deh,008h,0f1h,008h,0e3h,008h,0deh,088h,038h,044h,0bah,0aah,0b2h	; 5f9e  <|.........8D...
	defb 0aah,044h,038h,003h,000h,001h,0ffh,004h,000h,000h	; 5fae  .D8.......

; ======================================================================
; CODIGO 0x5fb8..0x5fe4  (44 bytes)
; ======================================================================


L_5FB8:
	ld hl,0e0b0h		;5fb8
	push hl			;5fbb
	ld b,080h		;5fbc
borra_dos_sprites:
	ld (hl),000h		;5fbe   ; los dos huecos de sprite
	inc hl			;5fc0
	djnz borra_dos_sprites		;5fc1
	pop hl			;5fc3
	push hl			;5fc4
	ld b,020h		;5fc5
recorre_los_sprites:
	ld (hl),0e0h		;5fc7   ; tres bytes por vuelta
	inc hl			;5fc9
	inc hl			;5fca
	inc hl			;5fcb
	inc hl			;5fcc
	djnz recorre_los_sprites		;5fcd
	pop de			;5fcf
	ld hl,05fe4h		;5fd0
	ld bc,00048h		;5fd3
	ldir		;5fd6
L_5FD8:
	ld bc,00080h		;5fd8
L_5FDB:
	ld hl,03b00h		;5fdb
	ld de,0e0b0h		;5fde
	jp vuelca_a_vram		;5fe1

; ----------------------------------------------------------------------
; DATOS bloque_copiado_5fe4: 72 bytes copiados tal cual por el `ld hl,05fe4h /
;   ld bc,00048h / ldir` de 0x5fd0; el 0x48 del propio codigo dice el tamano
;   0x5fe4..0x602c  (72 bytes)
DATA_bloque_copiado_5fe4:
	defb 014h,074h,000h,006h,014h,074h,010h,00fh,0e0h,0e0h,050h,00eh,0e0h,000h,058h,00fh	; 5fe4  .t...t....P...X.
	defb 0e0h,000h,000h,00fh,0e0h,010h,050h,009h,0e0h,000h,058h,00fh,0e0h,000h,000h,000h	; 5ff4  ......P...X.....
	defb 0e0h,0e0h,050h,00ah,0e0h,000h,058h,00fh,0e0h,000h,05ch,007h,0e0h,000h,000h,000h	; 6004  ..P...X...\.....
	defb 0e0h,010h,050h,007h,0e0h,000h,058h,00fh,0e0h,000h,000h,001h,0e0h,000h,000h,009h	; 6014  ..P...X.........
	defb 0e0h,000h,050h,001h,0e0h,000h,058h,00fh	; 6024  ..P...X.

; ======================================================================
; CODIGO 0x602c..0x6035  (9 bytes)
; ======================================================================


L_602C:
	ld de,07683h		;602c
	ld hl,01800h		;602f
	jp descomprime_a_vram		;6032

; ----------------------------------------------------------------------
; DATOS tabla_de_zonas: 50 punteros, uno por zona, indexada por (0xE053); los
;   multiplos de 5 menos uno van todos a 0x6490
;   0x6035..0x6099  (100 bytes)
DATA_tabla_de_zonas:
	defw 060abh,060c5h,060dbh,060edh,06490h,06104h,06117h,0612ah	; 6035
	defw 06139h,06490h,06150h,06162h,06173h,06188h,06490h,0619ah	; 6045
	defw 061a7h,061bch,061cdh,06490h,061e8h,0624ah,06225h,06207h	; 6055
	defw 06490h,06262h,06281h,062a5h,062beh,06490h,062dch,062f3h	; 6065
	defw 0630bh,06322h,06490h,06330h,06345h,06362h,0637bh,06490h	; 6075
	defw 0639ah,063b7h,063d2h,063efh,06490h,0640dh,06471h,06449h	; 6085
	defw 06430h,06490h	; 6095

; ----------------------------------------------------------------------
; DATOS tabla_6099: cinco bytes (01 04 03 02 05); los carga 0x4b27 en DE
;   0x6099..0x609e  (5 bytes)
DATA_tabla_6099:
	defb 001h,004h,003h,002h,005h	; 6099

; ----------------------------------------------------------------------
; DATOS zonas_con_razzon: 13 zonas en orden creciente; el bucle de 0x41d5 las
;   recorre pidiendo catorce y la de mas cae ya fuera
;   0x609e..0x60ab  (13 bytes)
DATA_zonas_con_razzon:
	defb 005h,006h,007h,00ah,00bh,00ch,010h,011h,012h,01fh,023h,025h,02bh	; 609e  ..........#%+

; ----------------------------------------------------------------------
; DATOS datos_de_zona: los bloques que apunta tabla_de_zonas, uno por zona, de
;   longitud variable y separados por 0xFF; el de la zona de bonus (0x6490) lo
;   comparten las diez
;   0x60ab..0x64b5  (1034 bytes)
DATA_datos_de_zona:
	defb 008h,0a7h,011h,075h,005h,0dbh,005h,075h,011h,0ffh,000h,000h,002h,00ah,0feh,029h	; 60ab  ...u...u.......)
	defb 011h,037h,001h,01eh,003h,01dh,003h,01eh,001h,0ffh,006h,0feh,007h,015h,058h,01dh	; 60bb  .7............X.
	defb 099h,086h,0ffh,054h,039h,000h,000h,002h,006h,0c4h,08ch,0a0h,037h,084h,005h,0ffh	; 60cb  ...T9.......7...
	defb 007h,0aah,050h,01dh,099h,080h,07bh,009h,0ffh,000h,000h,003h,002h,0feh,05bh,0feh	; 60db  ..P...{.......[.
	defb 038h,0ffh,009h,0c5h,052h,011h,067h,021h,067h,011h,052h,035h,0ffh,02fh,039h,030h	; 60eb  8...R.g!g.R5./90
	defb 03ah,004h,004h,0feh,069h,011h,04fh,011h,0ffh,007h,097h,013h,08ch,018h,0bbh,030h	; 60fb  :...i.O........0
	defb 06ch,0ffh,000h,000h,005h,004h,0feh,033h,059h,00bh,07ch,0ffh,007h,0a5h,015h,0d5h	; 610b  l......3Y.|.....
	defb 07ah,071h,00bh,029h,0ffh,073h,03ah,006h,03ah,005h,002h,0feh,035h,074h,0ffh,007h	; 611b  zq.).s:.:...5t..
	defb 0afh,0a1h,01fh,081h,060h,035h,015h,0ffh,0cfh,03ah,0a7h,039h,005h,000h,006h,0a5h	; 612b  ....`5...:.9....
	defb 015h,097h,07ch,0b8h,034h,0ffh,0e8h,038h,057h,03ah,004h,008h,0f3h,01fh,001h,021h	; 613b  ..|.4..8W:.....!
	defb 020h,097h,021h,021h,0ffh,008h,0aah,04ah,072h,06bh,055h,02fh,053h,00ch,0ffh,000h	; 614b   .!!...JrkU/S...
	defb 000h,005h,002h,0feh,092h,07fh,0ffh,009h,0a8h,032h,04fh,086h,008h,039h,055h,043h	; 615b  .........2O..9UC
	defb 02dh,0ffh,047h,03ah,033h,039h,005h,000h,007h,0c5h,012h,041h,034h,09ch,065h,02bh	; 616b  -.G:39.....A4.e+
	defb 0ffh,047h,03ah,000h,000h,005h,003h,0feh,035h,07dh,0feh,021h,0ffh,00ah,0a8h,012h	; 617b  .G:.....5}.!....
	defb 0b2h,007h,05dh,0aah,00bh,005h,00bh,01ah,0ffh,087h,039h,098h,039h,004h,000h,007h	; 618b  ..].......9.9...
	defb 0a5h,053h,09eh,013h,0beh,009h,008h,0ffh,000h,000h,004h,000h,009h,0a5h,00bh,078h	; 619b  .S.............x
	defb 010h,070h,010h,072h,00ch,05bh,0ffh,000h,000h,005h,004h,0feh,06eh,008h,058h,008h	; 61ab  .p.r.[......n.X.
	defb 0ffh,009h,085h,015h,0efh,007h,006h,074h,00bh,032h,011h,0ffh,0e8h,039h,0f7h,039h	; 61bb  .......t.2...9.9
	defb 005h,000h,008h,0a6h,006h,007h,006h,0feh,096h,005h,054h,013h,0ffh,000h,000h,005h	; 61cb  ..........T.....
	defb 00ah,0feh,02dh,009h,052h,013h,00dh,013h,04bh,007h,009h,007h,0ffh,00ah,0feh,007h	; 61db  ..-.R...K.......
	defb 015h,014h,003h,0a3h,03ah,003h,01eh,078h,011h,0ffh,000h,000h,004h,00ch,0feh,04fh	; 61eb  ....:..x.......O
	defb 002h,003h,01ch,002h,001h,05dh,001h,002h,01ch,003h,002h,0ffh,00ah,08ah,00bh,012h	; 61fb  .....]..........
	defb 011h,0b5h,005h,0feh,036h,013h,014h,005h,0ffh,000h,000h,004h,00ch,0ebh,009h,07bh	; 620b  ....6..........{
	defb 001h,020h,01eh,01dh,004h,001h,004h,0b4h,00fh,0ffh,00ah,0c5h,015h,034h,003h,07ch	; 621b  . ...........4.|
	defb 005h,036h,00fh,08fh,013h,0ffh,000h,000h,003h,014h,087h,011h,08eh,013h,00dh,013h	; 622b  .6..............
	defb 00eh,011h,00fh,011h,012h,00bh,052h,011h,00fh,011h,015h,005h,01ch,003h,0ffh,00ah	; 623b  ......R.........
	defb 0a6h,004h,04ah,05bh,037h,013h,0d2h,01ah,015h,01ah,0ffh,089h,039h,0f4h,039h,004h	; 624b  ..J[7.......9.9.
	defb 005h,0d3h,07ah,008h,0d5h,028h,0ffh,008h,0a7h,011h,075h,005h,0dbh,005h,075h,011h	; 625b  ..z..(....u...u.
	defb 0ffh,000h,000h,004h,010h,0cch,007h,014h,011h,038h,03fh,01dh,005h,01dh,005h,01dh	; 626b  .........8?.....
	defb 03fh,038h,011h,014h,007h,0ffh,00ah,0bah,04bh,02eh,006h,056h,01bh,07ch,014h,06bh	; 627b  ?8......K..V.|.k
	defb 00dh,0ffh,000h,000h,004h,013h,06bh,009h,05ch,004h,003h,004h,070h,005h,004h,097h	; 628b  ......k.\...p...
	defb 005h,004h,070h,003h,004h,005h,004h,05ch,004h,0ffh,007h,0aah,050h,01dh,099h,080h	; 629b  ..p....\....P...
	defb 07ah,00ah,0ffh,000h,000h,004h,00ah,0feh,02eh,02dh,011h,001h,009h,015h,008h,037h	; 62ab  z........-.....7
	defb 02ch,07bh,0ffh,00ah,0c5h,015h,0b3h,002h,002h,01dh,002h,002h,0b3h,015h,0ffh,02fh	; 62bb  ,{............./
	defb 039h,030h,03ah,004h,00ah,0feh,06fh,002h,002h,01bh,007h,019h,007h,01bh,002h,002h	; 62cb  90:...o.........
	defb 0ffh,007h,09ah,010h,07fh,00dh,0d3h,070h,02ch,0ffh,000h,000h,004h,009h,0d1h,056h	; 62db  .......p,......V
	defb 00ah,059h,007h,004h,003h,079h,060h,0ffh,009h,0a5h,015h,0d5h,025h,055h,003h,06eh	; 62eb  .Y...y`.....%U.n
	defb 00bh,029h,0ffh,073h,03ah,0d0h,039h,005h,006h,068h,08bh,0b4h,012h,032h,0edh,0ffh	; 62fb  .).s:.9..h...2..
	defb 007h,0afh,0a1h,01fh,081h,060h,035h,015h,0ffh,0cfh,03ah,0a7h,039h,004h,007h,0cfh	; 630b  .....`5...:.9...
	defb 061h,05fh,081h,060h,014h,017h,0ffh,006h,0a5h,015h,097h,07bh,0b9h,034h,0ffh,0e8h	; 631b  a_.`.......{.4..
	defb 038h,057h,03ah,004h,000h,008h,0aah,04ah,072h,06bh,055h,02fh,053h,00ch,0ffh,000h	; 632b  8W:....JrkU/S...
	defb 000h,005h,005h,0feh,02bh,064h,002h,083h,03ch,0ffh,00ah,085h,023h,032h,04fh,086h	; 633b  ....+d..<...#2O.
	defb 008h,039h,055h,043h,02dh,0ffh,047h,03ah,033h,039h,004h,00ah,077h,078h,09bh,004h	; 634b  .9UC-.G:39..wx..
	defb 003h,004h,075h,004h,003h,004h,0ffh,009h,0c5h,012h,041h,034h,066h,036h,065h,02bh	; 635b  ..u.......A4f6e+
	defb 00dh,0ffh,047h,03ah,000h,000h,005h,006h,064h,02fh,0a0h,065h,018h,0feh,021h,0ffh	; 636b  ..G:....d/.e..!.
	defb 009h,0bah,02bh,061h,040h,006h,020h,0ceh,00bh,02ah,0ffh,098h,039h,0d1h,03ah,004h	; 637b  ..+a@. ..*..9.:.
	defb 00ch,0feh,049h,004h,01dh,001h,001h,01dh,004h,01dh,001h,001h,01dh,004h,0ffh,009h	; 638b  ..I.............
	defb 0a5h,053h,09eh,013h,07ch,015h,074h,003h,001h,0ffh,08fh,039h,0b0h,039h,004h,009h	; 639b  .S..|.t....9.9..
	defb 0feh,0feh,077h,017h,009h,018h,009h,016h,002h,006h,002h,0ffh,009h,0a5h,00bh,068h	; 63ab  ..w............h
	defb 010h,080h,010h,050h,02eh,05bh,0ffh,000h,000h,004h,00ah,0feh,00dh,00ah,016h,00ah	; 63bb  ...P.[..........
	defb 0dbh,038h,001h,008h,02ah,00ch,0ffh,00ah,0c7h,011h,038h,025h,054h,007h,07ah,00bh	; 63cb  .8..*.....8%T.z.
	defb 032h,011h,0ffh,0e8h,039h,0f7h,039h,004h,00ah,089h,001h,001h,009h,001h,001h,098h	; 63db  2...9.9.........
	defb 003h,039h,00bh,0ffh,00ah,0a6h,013h,054h,005h,05eh,05fh,07eh,005h,054h,013h,0ffh	; 63eb  .9.....T.^_~.T..
	defb 000h,000h,005h,00dh,069h,001h,00bh,001h,0b6h,007h,0d7h,003h,003h,003h,002h,076h	; 63fb  ....i..........v
	defb 009h,0ffh,00ah,0feh,007h,029h,002h,002h,038h,002h,008h,0bbh,078h,011h,0ffh,000h	; 640b  .....)..8...x...
	defb 000h,004h,010h,0feh,04ch,002h,002h,002h,002h,002h,03dh,01ch,001h,003h,001h,01eh	; 641b  ....L.....=.....
	defb 002h,01bh,001h,004h,0ffh,00ah,075h,015h,01dh,011h,032h,00bh,059h,001h,001h,001h	; 642b  ......u...2.Y...
	defb 0ffh,000h,000h,004h,008h,0ebh,009h,09bh,001h,01eh,003h,01ah,009h,0ffh,00ah,0feh	; 643b  ................
	defb 00ah,006h,003h,006h,076h,005h,036h,00fh,08fh,013h,0ffh,000h,000h,004h,016h,0e9h	; 644b  ....v.6.........
	defb 00dh,030h,013h,00eh,011h,00fh,003h,00bh,003h,053h,009h,033h,011h,00fh,011h,015h	; 645b  .0.......S.3....
	defb 005h,01ch,003h,03eh,001h,0ffh,00ah,0a6h,004h,04ah,05bh,037h,013h,0d2h,01ah,015h	; 646b  ...>.....J[7....
	defb 01ah,0ffh,089h,039h,0f4h,039h,004h,00ch,0c8h,00bh,01dh,039h,024h,008h,063h,035h	; 647b  ...9.9.....9$.c5
	defb 03dh,00dh,00dh,00eh,0ffh,00ah,0a8h,012h,02bh,009h,0feh,01dh,008h,016h,02fh,022h	; 648b  =.......+...../"
	defb 036h,0ffh,000h,000h,000h,000h,003h,0bah,097h,07ch,0ffh,0e8h,038h,057h,03ah,004h	; 649b  6........|..8W:.
	defb 008h,0f3h,01fh,001h,021h,020h,097h,021h,021h,0ffh	; 64ab  ....! .!!.

; ======================================================================
; CODIGO 0x64b5..0x6522  (109 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; Pinta la zona entera desde el mapa ya descomprimido en 0xE0B0. Cada byte del mapa es un metatile, un cuadro de 2x2 celdas cuyos cuatro indices estan en la tabla de 0x6ef3.
; ----------------------------------------------------------------------
pinta_el_mapa_de_la_zona:
	xor a			;64b5   ; la cuenta de filas a cero
	ld (0e2a1h),a		;64b6
	ld hl,03864h		;64b9   ; la esquina del area de juego: 0x3800 + 0x64, o sea fila 3, columna 4
	ld (0e2a2h),hl		;64bc   ; el puntero que avanza celda a celda
	ld (0e2a4h),hl		;64bf   ; y el que guarda el principio de la fila
	ld de,0e0b0h		;64c2   ; el mapa descomprimido
	ld (0e2a6h),de		;64c5   ; el puntero que recorre sus 120 bytes
empieza_fila_de_metatiles:
	xor a			;64c9   ; doce metatiles por fila, y la cuenta empieza a cero
	ld (0e2a0h),a		;64ca
pinta_un_metatile:
	ld de,(0e2a6h)		;64cd   ; el byte del mapa
	ld a,(de)			;64d1   ; que es el numero de metatile
	ld l,a			;64d2
	ld h,000h		;64d3
	inc de			;64d5   ; y el mapa avanza
	ld (0e2a6h),de		;64d6
	add hl,hl			;64da   ; por cuatro: cada metatile son cuatro celdas
	add hl,hl			;64db
	ex de,hl			;64dc
	ld hl,06ef3h		;64dd   ; la tabla de metatiles
	add hl,de			;64e0   ; DE apunta ya a los cuatro indices
	ex de,hl			;64e1
	ld hl,(0e2a2h)		;64e2   ; la celda de arriba a la izquierda
	ld bc,00002h		;64e5   ; las dos celdas de arriba
	call vuelca_a_vram		;64e8
	ld hl,(0e2a2h)		;64eb   ; otra vez la esquina del metatile
	ld a,020h		;64ee   ; una fila entera de la tabla de nombres: 32 celdas
	call suma_a_a_hl		;64f0
	ld bc,00002h		;64f3   ; y las dos celdas de abajo
	call vuelca_a_vram		;64f6
	ld hl,(0e2a2h)		;64f9   ; el metatile de al lado
	inc hl			;64fc
	inc hl			;64fd
	ld (0e2a2h),hl		;64fe   ; dos celdas mas a la derecha
	ld hl,0e2a0h		;6501   ; la cuenta de metatiles de esta fila
	inc (hl)			;6504
	ld a,(hl)			;6505
	cp 00ch		;6506   ; doce por fila
	jr nz,pinta_un_metatile		;6508   ; si no ha llegado, otro metatile
	ld hl,(0e2a4h)		;650a   ; el principio de la fila
	ld a,040h		;650d   ; 0x40 son dos filas de celdas: lo que ocupa un metatile de alto
	call suma_a_a_hl		;650f
	ld (0e2a2h),hl		;6512   ; y ese es el arranque de la fila siguiente
	ld (0e2a4h),hl		;6515
	ld hl,0e2a1h		;6518   ; la cuenta de filas
	inc (hl)			;651b
	ld a,(hl)			;651c
	cp 00ah		;651d   ; diez filas
	jr nz,empieza_fila_de_metatiles		;651f   ; si faltan, otra fila
	ret			;6521   ; doce por diez: los 120 bytes del mapa

; ----------------------------------------------------------------------
; DATOS tabla_de_mapas: 25 punteros a los mapas de zona, indexada por (0xE053)
;   modulo 25
;   0x6522..0x6554  (50 bytes)
DATA_tabla_de_mapas:
	defw 06554h,065ceh,06648h,066bdh,06e87h,06737h,067aah,06888h	; 6522
	defw 06823h,06e87h,068f7h,0696ah,06a56h,069e4h,06e87h,06ad0h	; 6532
	defw 06b4ah,06bc4h,06c3bh,06e87h,06ca1h,06e0dh,06d95h,06d1bh	; 6542
	defw 06e87h	; 6552

; ----------------------------------------------------------------------
; DATOS mapas_de_zona: los 25 mapas comprimidos con el RLE de L_454F,
;   contiguos; cada uno da 120 bytes
;   0x6554..0x6ef3  (2463 bytes)
DATA_mapas_de_zona:
	defb 0b2h,067h,02eh,029h,08eh,067h,029h,066h,06ah,042h,066h,075h,06ah,081h,032h,027h	; 6554  .g.).g)fjBfuj.2'
	defb 00ch,081h,034h,035h,07ch,00ch,070h,030h,07ch,08bh,039h,007h,021h,081h,034h,035h	; 6564  ..45|.p0|.9.!.45
	defb 07ch,09fh,026h,03ah,089h,052h,02dh,02eh,02eh,091h,034h,035h,092h,075h,075h,093h	; 6574  |.&:.R-...45.uu.
	defb 052h,052h,073h,003h,02fh,082h,027h,070h,003h,078h,084h,072h,052h,052h,074h,003h	; 6584  RRs./.'p.x.rRRt.
	defb 075h,082h,06ah,067h,003h,02eh,0b2h,040h,052h,052h,02ch,078h,078h,030h,07ch,081h	; 6594  u.jg...@RR,xx0|.
	defb 032h,02fh,02fh,04fh,052h,08ch,087h,007h,023h,035h,07ch,081h,034h,024h,026h,03bh	; 65a4  2//OR...#5|.4$&;
	defb 038h,035h,092h,06ah,00ch,035h,07ch,081h,034h,00ch,067h,091h,034h,070h,078h,060h	; 65b4  85.j.5|.4.g.4px`
	defb 08dh,070h,060h,06dh,027h,041h,06dh,02fh,027h,000h,0f8h,066h,06ah,02dh,029h,074h	; 65c4  .p`m'Am/'..fj-)t
	defb 093h,067h,040h,066h,06ah,02dh,029h,070h,060h,073h,027h,02ch,072h,04eh,02bh,070h	; 65d4  .g@fj-)p`s',rN+p
	defb 060h,073h,027h,03bh,038h,011h,087h,011h,010h,08ch,010h,03bh,038h,011h,087h,06dh	; 65e4  `s';8......;8..m
	defb 04dh,02ch,060h,073h,02bh,04ch,072h,06dh,04dh,02ch,060h,08ch,087h,011h,038h,011h	; 65f4  M,`s+LrmM,`...8.
	defb 010h,03bh,010h,08ch,087h,011h,038h,08bh,089h,01eh,039h,01eh,01dh,08bh,01dh,03ah	; 6604  .;....8...9....:
	defb 089h,01eh,089h,067h,029h,074h,06bh,02dh,040h,066h,093h,096h,029h,074h,06ah,08bh	; 6614  ...g)tk-@f..)tj.
	defb 039h,01eh,089h,01eh,01dh,03ah,01dh,08bh,039h,01eh,089h,066h,06ah,02dh,029h,074h	; 6624  9....:..9..fj-)t
	defb 093h,067h,040h,066h,06ah,02dh,029h,070h,060h,073h,027h,02ch,072h,06dh,02bh,070h	; 6634  .g@fj-)p`s',rm+p
	defb 060h,073h,027h,000h,081h,067h,005h,02eh,082h,0ach,074h,003h,075h,083h,06ah,081h	; 6644  `s'..g....t.u.j.
	defb 032h,003h,02fh,0aeh,07ah,034h,009h,079h,078h,030h,07ch,081h,034h,007h,00eh,026h	; 6654  2./.z4.yx0|.4..&
	defb 081h,034h,00ch,03bh,010h,035h,07ch,081h,033h,040h,0a4h,02dh,091h,034h,00ch,06dh	; 6664  .4.;.5|.3@.-.4.m
	defb 02bh,04ch,060h,06dh,0aeh,02bh,0a6h,073h,02fh,027h,08dh,08ch,010h,03bh,087h,08ch	; 6674  +L`m.+.s/'...;..
	defb 087h,037h,004h,00eh,09fh,026h,035h,000h,081h,07ch,035h,07ch,0adh,02eh,02eh,029h	; 6684  .7...&5..|5|...)
	defb 02dh,040h,035h,000h,081h,07ch,035h,07ch,01eh,00ah,00ah,039h,01eh,01dh,03ah,01dh	; 6694  -@5..|5|...9..:.
	defb 081h,07ch,035h,092h,003h,075h,088h,06ah,074h,075h,076h,02eh,091h,07ch,070h,004h	; 66a4  .|5..u.jtuv..|p.
	defb 078h,082h,060h,02ch,004h,078h,081h,060h,000h,0f8h,067h,02eh,040h,05dh,066h,075h	; 66b4  x.`,.x.`..g.@]fu
	defb 075h,06ah,0a2h,074h,075h,06ah,081h,032h,02bh,05ch,070h,078h,078h,060h,0a1h,02ch	; 66c4  uj.tuj.2+\pxx`.,
	defb 030h,07ch,08bh,039h,011h,010h,043h,045h,043h,045h,011h,010h,03ah,089h,053h,055h	; 66d4  0|.9..CECE..:.SU
	defb 01eh,01dh,044h,046h,044h,046h,01eh,01dh,056h,054h,066h,06ah,043h,045h,067h,02eh	; 66e4  ..DFDF..VTfjCEg.
	defb 02eh,029h,043h,045h,067h,029h,070h,060h,044h,046h,06dh,02fh,02fh,027h,044h,046h	; 66f4  .)CEg)p`DFm//'DF
	defb 06dh,027h,057h,058h,011h,010h,043h,045h,043h,045h,011h,010h,059h,05ah,08ch,087h	; 6704  m'WX..CECE..YZ..
	defb 01eh,01dh,044h,046h,044h,046h,01eh,01dh,03bh,038h,035h,092h,093h,05bh,066h,075h	; 6714  ..DFDF..;85..[fu
	defb 075h,06ah,0a0h,02dh,091h,034h,070h,078h,072h,05eh,070h,078h,078h,060h,05fh,073h	; 6724  uj.-.4pxr^pxx`_s
	defb 02fh,027h,000h,081h,067h,005h,02eh,082h,097h,02dh,003h,02eh,083h,029h,081h,032h	; 6734  /'..g....-...).2
	defb 004h,02fh,082h,062h,014h,003h,025h,084h,034h,081h,034h,024h,003h,00eh,0b9h,085h	; 6744  ./.b..%.4.4$....
	defb 01eh,00ah,0b6h,025h,034h,081h,034h,00ch,066h,075h,075h,06ah,074h,06ah,014h,025h	; 6754  ...%4.4.fuujtj.%
	defb 034h,06dh,027h,041h,070h,078h,078h,060h,073h,095h,073h,02fh,027h,08ch,020h,010h	; 6764  4m'Apxx`s.s/'. .
	defb 03bh,020h,020h,038h,011h,038h,00fh,08ch,087h,035h,025h,000h,06dh,02fh,02fh,027h	; 6774  ;  8.8...5%.m//'
	defb 073h,027h,00ch,035h,07ch,035h,025h,018h,003h,020h,087h,038h,007h,00eh,021h,035h	; 6784  s'.5|5%.. .8..!5
	defb 07ch,035h,005h,025h,087h,034h,074h,075h,075h,031h,07ch,070h,005h,078h,082h,063h	; 6794  |5.%.4tuu1|p.x.c
	defb 02ch,003h,078h,081h,060h,000h,084h,066h,075h,093h,051h,003h,075h,0e8h,06ah,074h	; 67a4  ,.x.`..fu.Q.u.jt
	defb 075h,075h,06ah,035h,003h,04fh,082h,00bh,00ah,01bh,07ch,02ch,030h,025h,07ch,070h	; 67b4  uuj5.O....|,0%|p
	defb 04fh,0aah,0b9h,089h,08eh,0bah,089h,00fh,070h,030h,07ch,052h,03bh,0b9h,089h,02dh	; 67c4  O.......p0|R;..-
	defb 09ch,050h,097h,09fh,023h,070h,060h,052h,08bh,089h,02dh,002h,000h,035h,092h,06ah	; 67d4  .P..#p`R..-..5.j
	defb 09fh,026h,05ch,052h,066h,06ah,01eh,0b6h,000h,035h,00bh,08ah,074h,093h,05bh,052h	; 67e4  .&\Rfj...5..t.[R
	defb 035h,092h,06ah,01eh,0b7h,03ah,08ah,0a9h,0b8h,04fh,0abh,059h,070h,030h,092h,06ah	; 67f4  5.j..:...O.Yp0.j
	defb 00dh,050h,029h,009h,04fh,0aah,087h,03bh,010h,035h,025h,092h,075h,031h,034h,00ch	; 6804  .P).O..;.5%.u14.
	defb 03bh,017h,07ch,06dh,02bh,02ah,004h,02fh,085h,027h,08dh,098h,078h,060h,000h,083h	; 6814  ;.|m+*./.'..x`..
	defb 066h,075h,06ah,006h,052h,086h,067h,02eh,029h,035h,07bh,060h,006h,052h,08fh,06dh	; 6824  fuj.R.g.)5{`.R.m
	defb 07ah,034h,070h,060h,052h,052h,0a3h,0a8h,0a8h,0a4h,052h,052h,06dh,027h,003h,052h	; 6834  z4p`RR....RRm'.R
	defb 086h,0a3h,0a5h,011h,010h,0a6h,0a4h,006h,052h,086h,0a7h,011h,09bh,018h,010h,0a7h	; 6844  ........R.......
	defb 006h,052h,086h,0a7h,01eh,0b6h,019h,01dh,0a7h,006h,052h,086h,0a6h,0a4h,01eh,01dh	; 6854  .R........R.....
	defb 0a3h,0a5h,003h,052h,08fh,067h,029h,052h,052h,0a6h,0a8h,0a8h,0a5h,052h,052h,066h	; 6864  ...R.g)RR....RRf
	defb 06ah,081h,033h,029h,006h,052h,086h,066h,031h,07ch,06dh,02fh,027h,006h,052h,083h	; 6874  j.3).R.f1|m/'.R.
	defb 070h,078h,060h,000h,081h,067h,00ah,02eh,085h,029h,081h,032h,02fh,079h,004h,078h	; 6884  px`..g...).2/y.x
	defb 0dbh,04bh,02fh,07ah,034h,081h,034h,00fh,03bh,004h,00eh,00eh,09dh,038h,00fh,081h	; 6894  .K/z4.4.;....8..
	defb 034h,08bh,039h,00ch,081h,07fh,074h,093h,081h,034h,00ch,08bh,039h,043h,045h,00ch	; 68a4  4.9...t..4..9CE.
	defb 081h,034h,02ch,072h,081h,034h,00ch,043h,045h,044h,046h,00ch,081h,034h,011h,010h	; 68b4  .4,r.4.CEDF..4..
	defb 081h,034h,00ch,044h,046h,03bh,038h,00ch,081h,034h,073h,02bh,081h,034h,00ch,03bh	; 68c4  .4.DF;8..4s+.4.;
	defb 038h,081h,034h,00ch,08bh,039h,007h,026h,08bh,039h,00ch,081h,034h,081h,034h,008h	; 68d4  8.4..9.&.9..4.4.
	defb 075h,077h,02eh,02eh,075h,077h,09ch,081h,034h,06dh,027h,073h,006h,02fh,083h,02bh	; 68e4  uw..uw..4m's./.+
	defb 06dh,027h,000h,081h,066h,004h,075h,082h,06ah,02dh,004h,02eh,088h,029h,035h,003h	; 68f4  m'..f.u.j-...)5.
	defb 079h,078h,030h,07ch,014h,004h,025h,0cfh,034h,035h,000h,086h,026h,03ah,089h,009h	; 6904  yx0|..%.45..&:..
	defb 079h,078h,078h,001h,039h,035h,000h,068h,075h,076h,029h,00ch,03bh,020h,038h,074h	; 6914  yxx.95.huv).; 8t
	defb 06bh,070h,072h,082h,07bh,078h,061h,08dh,081h,032h,027h,014h,07ch,03bh,004h,005h	; 6924  kpr.{xa..2'.|;..
	defb 089h,011h,038h,00fh,081h,034h,011h,09bh,07ch,081h,07ch,02dh,02eh,002h,034h,08dh	; 6934  ..8..4..|.|-..4.
	defb 06dh,027h,009h,02fh,062h,081h,07dh,073h,02fh,02fh,027h,007h,00eh,00eh,021h,08ch	; 6944  m'./b.}s//'...!.
	defb 087h,081h,006h,020h,010h,08ch,03fh,004h,075h,087h,031h,07ch,06dh,02fh,02fh,02bh	; 6954  ... ..?.u.1|m//+
	defb 070h,006h,078h,081h,060h,000h,0f8h,066h,075h,075h,06ch,074h,075h,075h,06ch,074h	; 6964  p.x.`..fuultuult
	defb 075h,075h,06ah,035h,07bh,078h,063h,02ch,078h,078h,060h,02ch,078h,030h,07ch,071h	; 6974  uuj5{xc,xx`,x0|q
	defb 062h,024h,00eh,00eh,036h,007h,00eh,00eh,023h,071h,062h,08ch,087h,00dh,066h,075h	; 6984  b$..6...#qb...fu
	defb 077h,075h,075h,06ah,00dh,08ch,087h,035h,07ch,08eh,084h,07bh,078h,078h,030h,07ch	; 6994  wuuj...5|..{xx0|
	defb 08eh,084h,07ch,070h,064h,00ch,02ah,062h,011h,010h,070h,060h,00ch,070h,064h,08ch	; 69a4  ..|pd.*b..p`.pd.
	defb 087h,00dh,08ch,088h,073h,02bh,08ch,087h,00dh,08ch,087h,035h,080h,042h,03ah,09eh	; 69b4  ....s+.....5.B:.
	defb 00eh,00eh,005h,089h,042h,035h,07ch,035h,07ch,008h,076h,02eh,06ah,067h,02eh,02eh	; 69c4  ....B5|5|.v.jg..
	defb 09ch,035h,07ch,070h,060h,02ch,078h,078h,060h,098h,078h,078h,072h,070h,060h,000h	; 69d4  .5|p`,xx`.xxrp`.
	defb 09bh,067h,02eh,02eh,040h,067h,02eh,02eh,029h,02dh,02eh,02eh,029h,081h,032h,02fh	; 69e4  .g..@g..)-..).2/
	defb 02bh,06dh,02fh,02fh,027h,073h,02fh,07ah,034h,081h,034h,0a3h,006h,0a8h,087h,0a4h	; 69f4  +m//'s/z4.4.....
	defb 081h,034h,081h,034h,0a7h,0a3h,004h,0a8h,0a0h,0a4h,0a7h,081h,034h,081h,034h,0a7h	; 6a04  .4.4........4.4.
	defb 0a7h,011h,020h,020h,010h,0a7h,0a7h,081h,034h,081h,034h,0a7h,0a7h,01eh,00ah,00ah	; 6a14  ..  ....4.4.....
	defb 01dh,0a7h,0a7h,081h,034h,081h,034h,0a7h,0a6h,004h,0a8h,087h,0a5h,0a7h,081h,034h	; 6a24  ....4.4........4
	defb 081h,034h,0a6h,006h,0a8h,09bh,0a5h,081h,034h,081h,033h,02eh,040h,067h,02eh,02eh	; 6a34  .4......4.3.@g..
	defb 029h,02dh,02eh,091h,034h,06dh,02fh,02fh,02bh,06dh,02fh,02fh,027h,073h,02fh,02fh	; 6a44  )-..4m//+m//'s//
	defb 027h,000h,0f8h,066h,06ah,00fh,066h,06ah,02dh,02eh,029h,01fh,037h,00eh,036h,035h	; 6a54  '..fj.fj-.).7.65
	defb 07dh,041h,035h,07dh,073h,07ah,033h,029h,074h,075h,06ah,03ah,039h,00fh,035h,006h	; 6a64  }A5}sz3)tuj:9.5.
	defb 010h,06dh,02fh,027h,012h,00ah,089h,067h,029h,00ch,03ah,00ah,01dh,03bh,038h,007h	; 6a74  .m/'...g).:..;8.
	defb 021h,067h,029h,081h,034h,008h,076h,02eh,040h,083h,07eh,02dh,040h,083h,034h,081h	; 6a84  !g).4.v.@.~-@.4.
	defb 034h,009h,079h,078h,072h,082h,07dh,073h,02bh,081h,034h,06dh,027h,00ch,03bh,020h	; 6a94  4.yxr.}s+.4m'.; 
	defb 010h,03ah,089h,007h,023h,06dh,027h,08ch,087h,08dh,082h,00bh,01dh,066h,075h,06ah	; 6aa4  .:..#m'......fuj
	defb 022h,020h,038h,035h,07ch,00fh,035h,07fh,074h,031h,07bh,060h,073h,02fh,027h,070h	; 6ab4  " 85|.5.t1{`s/'p
	defb 060h,00dh,070h,063h,02ch,078h,060h,01fh,086h,00eh,085h,000h,0f8h,067h,029h,052h	; 6ac4  `.pc,x`......g)R
	defb 052h,066h,06ah,066h,06ah,052h,052h,067h,029h,06dh,048h,029h,052h,070h,090h,08fh	; 6ad4  RfjfjRRg)mH)Rp..
	defb 060h,052h,067h,047h,027h,067h,047h,048h,029h,052h,070h,060h,052h,067h,047h,048h	; 6ae4  `RgG'gGH)Rp`RgGH
	defb 029h,06dh,027h,06dh,048h,029h,052h,052h,067h,047h,027h,06dh,027h,068h,06ah,067h	; 6af4  )m'mH)RRgG'm'hjg
	defb 047h,048h,029h,067h,047h,048h,029h,066h,06ah,070h,060h,06dh,048h,047h,027h,06dh	; 6b04  GH)gGH)fjp`mHG'm
	defb 048h,047h,027h,070h,060h,067h,029h,067h,047h,027h,052h,052h,06dh,048h,029h,067h	; 6b14  HG'p`g)gG'RRmH)g
	defb 029h,06dh,048h,047h,027h,052h,066h,06ah,052h,06dh,048h,047h,027h,067h,047h,027h	; 6b24  )mHG'RfjRmHG'gG'
	defb 052h,066h,08fh,090h,06ah,052h,06dh,048h,029h,06dh,027h,052h,052h,070h,060h,070h	; 6b34  Rf..jRmH)m'RRp`p
	defb 060h,052h,052h,06dh,027h,000h,0f8h,066h,075h,075h,093h,067h,02eh,02eh,040h,067h	; 6b44  `RRm'..fuu.g..@g
	defb 02eh,02eh,029h,035h,025h,025h,000h,099h,078h,078h,072h,082h,025h,025h,034h,035h	; 6b54  ..)5%%..xxr.%%45
	defb 025h,07bh,072h,05eh,066h,093h,05bh,070h,078h,0bbh,034h,035h,025h,092h,093h,05bh	; 6b64  %{r^f.[px.45%..[
	defb 070h,072h,05eh,066h,077h,002h,034h,035h,025h,025h,000h,051h,075h,075h,093h,035h	; 6b74  pr^fw.45%%.Quu.5
	defb 025h,025h,034h,070h,078h,078h,072h,06dh,02fh,079h,072h,02ah,02fh,02fh,027h,03bh	; 6b84  %%4pxxrm/yr*//';
	defb 004h,00eh,023h,08ch,0b5h,086h,023h,08ch,004h,09dh,087h,081h,07ch,045h,00ch,035h	; 6b94  ..#...#.....|E.5
	defb 07ch,045h,00ch,035h,07ch,0bah,089h,081h,07fh,0a9h,09ch,035h,092h,077h,09ch,035h	; 6ba4  |E.5|......5.w.5
	defb 092h,076h,097h,06dh,027h,073h,02bh,02ah,02fh,02fh,02bh,070h,078h,078h,060h,000h	; 6bb4  .v.m's+*//+pxx`.
	defb 083h,067h,02eh,029h,006h,05ah,0efh,067h,02eh,029h,06dh,07ah,033h,029h,007h,0bdh	; 6bc4  .g.).Z.g.)mz3)..
	defb 0bch,026h,067h,091h,032h,027h,059h,06dh,07ah,033h,029h,01eh,01dh,067h,091h,032h	; 6bd4  .&g.2'Ymz3)..g.2
	defb 027h,058h,03bh,010h,06dh,07ah,033h,029h,067h,091h,032h,027h,011h,087h,08bh,0bfh	; 6be4  'X;.mz3)g.2'....
	defb 023h,06dh,07ah,033h,091h,032h,027h,024h,0beh,089h,067h,029h,09fh,023h,06dh,07ah	; 6bf4  #mz3.2'$..g).#mz
	defb 032h,027h,024h,0b0h,067h,029h,081h,033h,029h,09fh,023h,081h,034h,024h,0b0h,067h	; 6c04  2'$.g).3).#.4$.g
	defb 091h,034h,06dh,07ah,033h,029h,00ch,081h,034h,00ch,067h,091h,032h,027h,0a7h,06dh	; 6c14  .4mz3)..4.g.2'.m
	defb 07ah,034h,00ch,081h,034h,00ch,081h,032h,027h,0a7h,0a6h,0a8h,06dh,027h,08dh,098h	; 6c24  z4..4..2'...m'..
	defb 027h,041h,06dh,027h,0a8h,0a5h,000h,0a6h,0a2h,042h,067h,097h,08eh,066h,06ah,08eh	; 6c34  'Am'.....Bg..fj.
	defb 066h,06ah,08eh,05dh,0a1h,08dh,081h,07dh,041h,035h,07dh,041h,035h,07dh,041h,05ch	; 6c44  fj.]...}A5}A5}A\
	defb 0a0h,007h,005h,039h,007h,005h,09eh,026h,03ah,09eh,026h,05ch,0a0h,02dh,008h,02eh	; 6c54  ...9...&:.&\.-..
	defb 084h,040h,05dh,05fh,073h,008h,02fh,084h,02bh,05ch,0a0h,02dh,008h,02eh,084h,040h	; 6c64  .@]_s./.+\.-...@
	defb 05dh,05fh,073h,008h,02fh,0a6h,02bh,05ch,0a0h,007h,09dh,087h,01fh,03bh,038h,01fh	; 6c74  ]_s./.+\.....;8.
	defb 03bh,004h,026h,05ch,0a0h,08eh,035h,07ch,02dh,091h,033h,040h,035h,07ch,08eh,05dh	; 6c84  ;.&\..5|-.3@5|.]
	defb 05fh,041h,070h,060h,073h,02fh,02fh,02bh,070h,060h,041h,05ch,000h,0f8h,066h,075h	; 6c94  _Ap`s//+p`A\..fu
	defb 075h,06ah,067h,029h,067h,029h,066h,075h,075h,06ah,070h,078h,078h,064h,081h,034h	; 6ca4  ujg)g)fuujpxxd.4
	defb 081h,034h,070h,078h,078h,064h,08ch,087h,011h,087h,081h,033h,091h,034h,08ch,010h	; 6cb4  .4pxxd.....3.4..
	defb 08ch,087h,070h,060h,02ch,060h,06dh,02fh,02fh,027h,070h,04fh,070h,060h,0a1h,011h	; 6cc4  ..p`,`m//'pOp`..
	defb 038h,011h,038h,066h,06ah,03bh,010h,03bh,010h,05bh,0a1h,01eh,039h,01eh,039h,070h	; 6cd4  8.8fj;.;.[..9.9p
	defb 060h,08bh,01dh,08bh,01dh,05bh,066h,093h,066h,06ah,067h,02eh,02eh,029h,066h,06ch	; 6ce4  `....[f.fjg..)fl
	defb 074h,06ah,070h,072h,070h,060h,081h,032h,07ah,034h,070h,061h,02ch,060h,067h,02eh	; 6cf4  tjprp`.2z4pa,`g.
	defb 02eh,029h,081h,034h,081h,034h,067h,02eh,02eh,029h,06dh,02fh,02fh,027h,06dh,027h	; 6d04  .).4.4g..)m//'m'
	defb 06dh,027h,06dh,02fh,02fh,027h,000h,0f8h,067h,040h,084h,07ch,01fh,067h,06ah,01fh	; 6d14  m'm//'..g@.|.gj.
	defb 081h,07fh,074h,06ah,08bh,01dh,035h,07ch,08eh,083h,080h,042h,081h,034h,01eh,089h	; 6d24  ..tj..5|...B.4..
	defb 066h,093h,081h,07ch,08dh,098h,095h,041h,081h,07ch,02dh,029h,070h,072h,082h,07ch	; 6d34  f..|...A.|-)pr.|
	defb 024h,00eh,00eh,023h,081h,07dh,073h,027h,052h,052h,081h,07ch,00ch,052h,052h,00ch	; 6d44  $..#.}s'RR.|.RR.
	defb 081h,07ch,052h,052h,057h,057h,081h,07ch,00ch,052h,052h,00ch,081h,07ch,05ah,05ah	; 6d54  .|RRWW.|.RR..|ZZ
	defb 037h,026h,081h,07ch,09fh,036h,037h,0b0h,081h,07ch,007h,036h,067h,040h,06eh,08ah	; 6d64  7&.|.67..|.6g@n.
	defb 074h,077h,076h,040h,06eh,08ah,074h,06ah,081h,000h,050h,029h,02ch,030h,032h,02bh	; 6d74  twv@n.tj..P),02+
	defb 066h,0c0h,014h,07ch,06dh,02bh,035h,034h,00fh,070h,027h,00fh,035h,034h,02ch,060h	; 6d84  f..|m+54.p'.54,`
	defb 000h,0edh,067h,097h,08eh,067h,097h,02dh,040h,067h,029h,08eh,067h,029h,081h,07dh	; 6d94  ..g..g.-@g).g).}
	defb 041h,06dh,095h,073h,02bh,06dh,027h,08dh,082h,034h,08bh,09eh,085h,0b2h,0bch,00eh	; 6da4  Am.s+m'..4......
	defb 00eh,0bdh,0b5h,086h,005h,039h,052h,052h,08eh,09ah,072h,028h,069h,073h,094h,042h	; 6db4  .....9RR..r(is.B
	defb 052h,052h,065h,06fh,00dh,08ch,004h,005h,09eh,09dh,038h,00dh,065h,06fh,08bh,08ah	; 6dc4  RReo......8.eo..
	defb 042h,070h,060h,054h,053h,06dh,027h,08eh,06eh,089h,068h,06bh,00dh,037h,00eh,0bdh	; 6dd4  Bp`TSm'.n.hk.7..
	defb 0bch,00eh,036h,00dh,096h,029h,081h,07ch,065h,040h,052h,01eh,01dh,052h,074h,06fh	; 6de4  ..6..).|e@R..Rto
	defb 081h,034h,081h,092h,031h,01ch,076h,029h,066h,077h,002h,033h,091h,034h,06dh,004h	; 6df4  .4..1.v)fw.3.4m.
	defb 02fh,082h,027h,02ah,004h,02fh,081h,027h,000h,0f8h,067h,029h,02dh,02eh,029h,02dh	; 6e04  /.'*./.'..g)-.)-
	defb 093h,066h,075h,093h,066h,06ah,081h,034h,02ch,078h,063h,01eh,01dh,02ah,02fh,02bh	; 6e14  .fu.fj.4,xc..*/+
	defb 035h,07ch,08bh,09eh,036h,0b2h,038h,02dh,093h,08ch,0b5h,037h,005h,089h,067h,02eh	; 6e24  5|..6.8-...7..g.
	defb 040h,09ah,063h,049h,04ah,02ah,094h,074h,075h,06ah,081h,07bh,072h,08ch,010h,070h	; 6e34  @.cIJ*.tuj.{r..p
	defb 027h,011h,038h,073h,07ah,07ch,099h,060h,00fh,03ah,01dh,08ch,038h,01eh,039h,00fh	; 6e44  '.8sz|.`.:..8.9.
	defb 06dh,062h,086h,00eh,0b0h,096h,040h,03ah,039h,074h,06bh,09fh,00eh,085h,067h,097h	; 6e54  mb....@:9tk...g.
	defb 08eh,09ah,072h,028h,069h,073h,094h,042h,068h,06ah,081h,07ch,022h,020h,038h,0b4h	; 6e64  ..r(is.Bhj.|" 8.
	defb 0b3h,03bh,020h,0b1h,081h,07ch,06dh,095h,073h,02fh,027h,02ch,072h,098h,078h,072h	; 6e74  .; ..|m.s/',r.xr
	defb 098h,060h,000h,0aeh,066h,069h,057h,066h,06ch,074h,075h,093h,068h,075h,075h,06ah	; 6e84  .`..fiWfltu.huuj
	defb 035h,013h,015h,016h,034h,009h,0aeh,01ah,081h,025h,025h,07ch,035h,07ch,00dh,081h	; 6e94  5...4....%%|5|..
	defb 034h,008h,076h,09ch,081h,07bh,078h,060h,070h,060h,054h,09ah,061h,02ch,078h,072h	; 6ea4  4.v..{x`p`T.a,xr
	defb 098h,060h,00eh,052h,005h,057h,0b7h,03ch,057h,058h,03dh,057h,057h,058h,037h,09dh	; 6eb4  .`.R.W.<WX=WWX7.
	defb 004h,036h,00fh,05bh,08ch,087h,0a1h,011h,020h,087h,056h,084h,07fh,03eh,00ch,05bh	; 6ec4  .6.[.... .V..>.[
	defb 035h,07ch,0a1h,014h,025h,07ch,066h,031h,033h,029h,008h,093h,081h,092h,06ah,009h	; 6ed4  5|..%|f13)....j.
	defb 07ah,07ch,070h,078h,078h,061h,02ch,072h,098h,078h,060h,08dh,098h,060h,000h	; 6ee4  z|pxxa,r.x`..`.

; ----------------------------------------------------------------------
; DATOS metatiles: 193 cuadros de 2x2 celdas, de cuatro bytes cada uno; los
;   indexa 0x64dd
;   0x6ef3..0x71f7  (772 bytes)
DATA_metatiles:
	defb 09dh,098h,097h,098h	; 6ef3
	defb 09ch,09dh,093h,092h	; 6ef7
	defb 096h,09dh,09ah,097h	; 6efb
	defb 097h,09bh,09dh,098h	; 6eff
	defb 091h,091h,09bh,092h	; 6f03
	defb 091h,09ah,092h,092h	; 6f07
	defb 099h,091h,09dh,097h	; 6f0b
	defb 090h,091h,093h,092h	; 6f0f
	defb 096h,098h,096h,099h	; 6f13
	defb 096h,09bh,096h,098h	; 6f17
	defb 09dh,097h,092h,092h	; 6f1b
	defb 097h,09dh,09bh,092h	; 6f1f
	defb 096h,098h,096h,098h	; 6f23
	defb 096h,098h,093h,095h	; 6f27
	defb 091h,091h,092h,092h	; 6f2b
	defb 090h,094h,096h,098h	; 6f2f
	defb 091h,094h,097h,098h	; 6f33
	defb 090h,091h,096h,097h	; 6f37
	defb 096h,09dh,096h,09bh	; 6f3b
	defb 099h,091h,09bh,092h	; 6f3f
	defb 096h,09dh,096h,097h	; 6f43
	defb 091h,091h,09ch,09bh	; 6f47
	defb 091h,09ah,092h,09ch	; 6f4b
	defb 091h,09ah,09dh,097h	; 6f4f
	defb 09dh,099h,097h,09dh	; 6f53
	defb 097h,09dh,09dh,09bh	; 6f57
	defb 09ch,098h,096h,098h	; 6f5b
	defb 09dh,097h,092h,09ch	; 6f5f
	defb 09dh,098h,097h,099h	; 6f63
	defb 097h,098h,092h,095h	; 6f67
	defb 096h,09dh,093h,092h	; 6f6b
	defb 090h,094h,093h,095h	; 6f6f
	defb 091h,091h,09dh,097h	; 6f73
	defb 09ah,098h,092h,095h	; 6f77
	defb 096h,099h,096h,097h	; 6f7b
	defb 091h,094h,09ch,098h	; 6f7f
	defb 090h,091h,096h,09bh	; 6f83
	defb 097h,09dh,09dh,097h	; 6f87
	defb 091h,094h,092h,095h	; 6f8b
	defb 095h,083h,080h,083h	; 6f8f
	defb 082h,081h,081h,090h	; 6f93
	defb 081h,081h,094h,083h	; 6f97
	defb 083h,093h,083h,080h	; 6f9b
	defb 092h,095h,080h,080h	; 6f9f
	defb 093h,092h,081h,081h	; 6fa3
	defb 081h,081h,090h,091h	; 6fa7
	defb 081h,081h,091h,091h	; 6fab
	defb 092h,092h,080h,080h	; 6faf
	defb 092h,09ch,081h,096h	; 6fb3
	defb 083h,096h,091h,09ah	; 6fb7
	defb 09bh,092h,098h,080h	; 6fbb
	defb 098h,083h,099h,091h	; 6fbf
	defb 098h,083h,098h,083h	; 6fc3
	defb 083h,096h,083h,096h	; 6fc7
	defb 094h,083h,095h,083h	; 6fcb
	defb 083h,090h,083h,093h	; 6fcf
	defb 094h,083h,098h,083h	; 6fd3
	defb 098h,083h,095h,083h	; 6fd7
	defb 083h,096h,083h,093h	; 6fdb
	defb 082h,090h,082h,096h	; 6fdf
	defb 084h,084h,082h,084h	; 6fe3
	defb 084h,084h,084h,080h	; 6fe7
	defb 080h,083h,084h,083h	; 6feb
	defb 094h,080h,099h,091h	; 6fef
	defb 081h,081h,091h,094h	; 6ff3
	defb 093h,095h,080h,080h	; 6ff7
	defb 080h,080h,090h,094h	; 6ffb
	defb 082h,081h,082h,082h	; 6fff
	defb 082h,080h,080h,080h	; 7003
	defb 081h,081h,081h,083h	; 7007
	defb 083h,083h,080h,083h	; 700b
	defb 081h,093h,094h,080h	; 700f
	defb 095h,083h,082h,090h	; 7013
	defb 093h,09ch,081h,096h	; 7017
	defb 09bh,095h,098h,080h	; 701b
	defb 092h,092h,081h,080h	; 701f
	defb 083h,093h,082h,081h	; 7023
	defb 095h,083h,080h,082h	; 7027
	defb 082h,093h,081h,080h	; 702b
	defb 092h,095h,082h,081h	; 702f
	defb 083h,081h,083h,090h	; 7033
	defb 082h,080h,082h,090h	; 7037
	defb 084h,084h,084h,084h	; 703b
	defb 080h,080h,084h,084h	; 703f
	defb 081h,081h,084h,084h	; 7043
	defb 080h,083h,084h,084h	; 7047
	defb 083h,081h,084h,084h	; 704b
	defb 084h,084h,080h,080h	; 704f
	defb 084h,084h,080h,082h	; 7053
	defb 084h,084h,082h,081h	; 7057
	defb 084h,084h,081h,081h	; 705b
	defb 082h,084h,082h,084h	; 705f
	defb 083h,084h,083h,084h	; 7063
	defb 081h,084h,083h,084h	; 7067
	defb 082h,084h,081h,084h	; 706b
	defb 084h,082h,084h,080h	; 706f
	defb 095h,082h,081h,081h	; 7073
	defb 095h,083h,081h,081h	; 7077
	defb 095h,082h,080h,082h	; 707b
	defb 095h,083h,081h,083h	; 707f
	defb 095h,082h,081h,082h	; 7083
	defb 084h,084h,084h,090h	; 7087
	defb 080h,080h,083h,090h	; 708b
	defb 082h,081h,082h,090h	; 708f
	defb 080h,080h,082h,090h	; 7093
	defb 080h,082h,094h,080h	; 7097
	defb 080h,082h,094h,082h	; 709b
	defb 080h,083h,094h,082h	; 709f
	defb 080h,080h,094h,083h	; 70a3
	defb 082h,093h,080h,080h	; 70a7
	defb 081h,096h,083h,093h	; 70ab
	defb 084h,084h,094h,084h	; 70af
	defb 083h,093h,083h,081h	; 70b3
	defb 083h,093h,080h,080h	; 70b7
	defb 092h,095h,081h,081h	; 70bb
	defb 093h,092h,080h,080h	; 70bf
	defb 080h,080h,090h,091h	; 70c3
	defb 080h,080h,091h,091h	; 70c7
	defb 083h,081h,091h,091h	; 70cb
	defb 080h,083h,091h,091h	; 70cf
	defb 092h,092h,081h,081h	; 70d3
	defb 092h,092h,082h,081h	; 70d7
	defb 092h,09ch,082h,096h	; 70db
	defb 09bh,092h,098h,082h	; 70df
	defb 098h,082h,098h,082h	; 70e3
	defb 098h,082h,098h,080h	; 70e7
	defb 098h,083h,098h,082h	; 70eb
	defb 098h,080h,098h,083h	; 70ef
	defb 098h,080h,098h,082h	; 70f3
	defb 082h,096h,082h,096h	; 70f7
	defb 082h,096h,081h,096h	; 70fb
	defb 081h,096h,082h,096h	; 70ff
	defb 081h,096h,083h,096h	; 7103
	defb 094h,082h,095h,082h	; 7107
	defb 082h,090h,082h,093h	; 710b
	defb 094h,082h,098h,082h	; 710f
	defb 094h,082h,098h,080h	; 7113
	defb 098h,082h,095h,082h	; 7117
	defb 098h,080h,095h,083h	; 711b
	defb 082h,096h,082h,093h	; 711f
	defb 083h,090h,083h,096h	; 7123
	defb 093h,095h,081h,081h	; 7127
	defb 081h,081h,090h,094h	; 712b
	defb 083h,093h,094h,082h	; 712f
	defb 095h,080h,081h,090h	; 7133
	defb 081h,096h,091h,09ah	; 7137
	defb 098h,080h,099h,091h	; 713b
	defb 080h,080h,091h,094h	; 713f
	defb 095h,080h,080h,083h	; 7143
	defb 095h,082h,080h,080h	; 7147
	defb 083h,081h,082h,090h	; 714b
	defb 081h,081h,094h,082h	; 714f
	defb 082h,093h,081h,081h	; 7153
	defb 082h,093h,082h,081h	; 7157
	defb 081h,093h,083h,081h	; 715b
	defb 09ah,09dh,09dh,097h	; 715f
	defb 096h,098h,09ah,098h	; 7163
	defb 091h,091h,092h,09ch	; 7167
	defb 099h,091h,092h,092h	; 716b
	defb 096h,099h,093h,092h	; 716f
	defb 084h,082h,084h,082h	; 7173
	defb 084h,083h,084h,083h	; 7177
	defb 084h,080h,084h,083h	; 717b
	defb 082h,081h,082h,080h	; 717f
	defb 081h,081h,082h,083h	; 7183
	defb 081h,083h,080h,083h	; 7187
	defb 082h,083h,080h,080h	; 718b
	defb 082h,083h,082h,083h	; 718f
	defb 081h,081h,080h,080h	; 7193
	defb 080h,083h,090h,091h	; 7197
	defb 082h,090h,081h,096h	; 719b
	defb 082h,084h,081h,082h	; 719f
	defb 081h,080h,094h,083h	; 71a3
	defb 083h,081h,090h,091h	; 71a7
	defb 092h,092h,080h,082h	; 71ab
	defb 082h,081h,080h,080h	; 71af
	defb 09ah,098h,092h,095h	; 71b3
	defb 09ah,098h,097h,098h	; 71b7
	defb 090h,091h,093h,09ch	; 71bb
	defb 099h,094h,09dh,098h	; 71bf
	defb 090h,09ah,096h,097h	; 71c3
	defb 091h,094h,09bh,095h	; 71c7
	defb 097h,097h,09ch,097h	; 71cb
	defb 097h,098h,09ch,098h	; 71cf
	defb 096h,09bh,09ah,098h	; 71d3
	defb 091h,09ah,09bh,092h	; 71d7
	defb 081h,096h,083h,093h	; 71db
	defb 09ch,09dh,096h,097h	; 71df
	defb 091h,091h,09dh,09bh	; 71e3
	defb 091h,091h,09ch,09dh	; 71e7
	defb 09ah,097h,092h,092h	; 71eb
	defb 097h,099h,092h,092h	; 71ef
	defb 080h,083h,094h,083h	; 71f3

; ----------------------------------------------------------------------
; DATOS guion_71f7: guion del rotulador L_457F en diez destinos; lo carga
;   0x4a1d
;   0x71f7..0x722b  (52 bytes)
DATA_guion_71f7:
	defb 043h,038h,0a4h,0feh,05ch,038h,0a0h,0feh,0e3h,03ah,0a6h,0feh,0fch,03ah,0a7h,0feh	; 71f7  C8..\8...:...:..
	defb 07bh,039h,08dh,0a8h,0abh,0feh,09bh,039h,08eh,0a9h,0ach,0feh,0bbh,039h,08fh,0aah	; 7207  {9.....9.....9..
	defb 0adh,0feh,062h,039h,0b1h,0aeh,085h,0feh,082h,039h,0b2h,0afh,086h,0feh,0a2h,039h	; 7217  ..b9.....9.....9
	defb 0b3h,0b0h,087h,0ffh	; 7227

; ----------------------------------------------------------------------
; DATOS grafico_722b: 786 comprimidos -> 1056 en la VRAM; lo carga 0x5e08
;   0x722b..0x753d  (786 bytes)
DATA_grafico_722b:
	defb 002h,000h,086h,020h,09bh,048h,096h,0f8h,020h,003h,000h,085h,005h,00ah,005h,00fh	; 722b  ... .H.. .......
	defb 03fh,003h,000h,088h,0a0h,050h,0a0h,0f0h,0fch,0c0h,080h,0c6h,003h,0ffh,085h,08fh	; 723b  ?....P..........
	defb 000h,003h,001h,063h,003h,0ffh,092h,0f1h,000h,0cch,033h,070h,0f8h,0fdh,0ffh,08fh	; 724b  ...c......3p....
	defb 000h,0cch,033h,08ch,044h,01dh,089h,08fh,000h,004h,03ch,087h,06ch,02eh,026h,000h	; 725b  ..3.D.....<.l.&.
	defb 000h,080h,002h,003h,000h,085h,040h,000h,000h,001h,040h,003h,000h,084h,002h,000h	; 726b  ......@...@.....
	defb 000h,044h,004h,000h,084h,008h,000h,000h,008h,004h,000h,082h,040h,002h,008h,000h	; 727b  .D..........@...
	defb 083h,0feh,0ffh,007h,012h,003h,08dh,007h,0ffh,0feh,000h,07eh,063h,063h,07eh,063h	; 728b  ...........~cc~c
	defb 063h,07eh,000h,03eh,005h,063h,08ah,03eh,000h,063h,073h,07bh,07fh,06fh,067h,063h	; 729b  c~.>.c.>.cs{.ogc
	defb 000h,006h,063h,08ch,03eh,000h,03eh,063h,060h,03eh,003h,063h,03eh,07fh,0ffh,0e0h	; 72ab  ..c.>.>c`>.c>...
	defb 012h,0c0h,085h,0e0h,0ffh,07fh,0ffh,0ffh,006h,0c0h,010h,0ffh,006h,0c0h,004h,0ffh	; 72bb  ................
	defb 00ch,003h,002h,0ffh,008h,0c0h,088h,083h,0feh,0a2h,09ah,092h,0bah,0ebh,0a9h,00eh	; 72cb  ................
	defb 0fch,002h,0ffh,006h,03fh,004h,0ffh,006h,0fch,002h,0ffh,006h,03fh,098h,0ebh,0beh	; 72db  ....?.......?...
	defb 0a2h,09ah,090h,0bah,0ebh,089h,0c3h,0e7h,066h,081h,042h,099h,03ch,081h,037h,01fh	; 72eb  ........f.B.<.7.
	defb 07fh,041h,09fh,00dh,0f1h,00fh,005h,0ffh,00bh,0c0h,015h,0ffh,00eh,0fch,005h,0ffh	; 72fb  .A..............
	defb 003h,03fh,005h,0ffh,018h,03fh,004h,0ffh,010h,0fch,004h,0ffh,018h,0fch,004h,0ffh	; 730b  .?...?..........
	defb 010h,03fh,004h,0ffh,0b0h,028h,054h,0cbh,092h,049h,04ch,0aah,044h,028h,054h,0cbh	; 731b  .?...(T..IL.D(T.
	defb 082h,051h,0b3h,0aah,044h,038h,07eh,0ffh,0dbh,0c7h,0e7h,0dbh,07eh,0f7h,0ffh,0ebh	; 732b  .Q..D8~.....~...
	defb 07eh,0ffh,07eh,07eh,0e7h,0efh,0ffh,0b7h,07eh,046h,0c3h,07eh,0e7h,0ech,0f8h,0feh	; 733b  ~.~~....~F.~....
	defb 082h,0f9h,0b0h,08fh,0f0h,008h,03ch,084h,098h,088h,088h,0cch,004h,0c3h,084h,003h	; 734b  ......<.........
	defb 007h,007h,006h,004h,001h,084h,0c0h,0e0h,0e0h,060h,004h,080h,094h,000h,0e0h,018h	; 735b  .........`......
	defb 006h,001h,03fh,0cfh,0f3h,0ffh,01fh,0e7h,0f9h,0feh,07fh,09fh,0e7h,000h,000h,007h	; 736b  ..?.............
	defb 00fh,003h,01fh,081h,03fh,003h,000h,09ah,081h,0c1h,043h,043h,0a3h,000h,000h,0f0h	; 737b  ....?.....CC....
	defb 0f8h,0e8h,0f5h,0f5h,0f7h,000h,00fh,03fh,07fh,0ffh,0f8h,0f3h,0e7h,000h,0e0h,0f8h	; 738b  .......?........
	defb 0fch,0feh,003h,0ffh,002h,000h,093h,07fh,0ffh,0ffh,07fh,078h,0bbh,000h,000h,0e0h	; 739b  ...........x....
	defb 0f9h,0ffh,0ffh,07bh,0fdh,000h,000h,0c0h,0f1h,0fbh,003h,0ebh,002h,000h,004h,0ffh	; 73ab  ...{............
	defb 0a7h,0e1h,0efh,000h,000h,0e0h,0f0h,0f8h,0ech,0f4h,0f4h,000h,01fh,03fh,03fh,07fh	; 73bb  .............??.
	defb 07fh,0ffh,0fbh,000h,000h,0c0h,061h,023h,0b3h,093h,0d3h,000h,000h,0e0h,0f0h,0d8h	; 73cb  ......a#........
	defb 0ech,0f6h,0fbh,000h,000h,038h,07ch,0feh,003h,0fbh,0a2h,000h,00fh,03fh,07fh,0ffh	; 73db  .....8|......?..
	defb 0ffh,0fch,0f1h,000h,0e0h,0fch,0feh,0fbh,0fdh,07dh,03bh,000h,000h,07fh,0ffh,07fh	; 73eb  .........};.....
	defb 07fh,070h,077h,000h,000h,0fdh,0f7h,0fbh,0f3h,007h,0fdh,000h,000h,004h,0ffh,08ah	; 73fb  .pw.............
	defb 0e1h,0efh,000h,000h,0e0h,0f0h,0f8h,0ech,0f4h,0f4h,006h,03fh,002h,07fh,002h,0a7h	; 740b  ...........?....
	defb 002h,0dfh,002h,0efh,002h,0ffh,004h,0fbh,087h,0b9h,0bdh,07dh,07dh,0cch,0d8h,0d0h	; 741b  ...........}}...
	defb 003h,0f0h,084h,0f8h,0fch,03fh,01fh,003h,00fh,002h,01fh,081h,03fh,003h,0bah,004h	; 742b  .....?......?...
	defb 0bfh,089h,078h,03dh,03dh,07dh,0fdh,0f9h,0f3h,0e7h,00fh,008h,0ebh,082h,0e8h,0e9h	; 743b  ..x==}..........
	defb 005h,0ffh,08dh,0efh,0f4h,0f5h,0f5h,0e5h,08dh,0bbh,0dbh,0efh,0fbh,0f3h,0f7h,0f7h	; 744b  ................
	defb 004h,0ffh,08ah,0dbh,0cbh,0ebh,0efh,0e7h,0f7h,0f3h,0fbh,0fdh,0feh,005h,0ffh,081h	; 745b  ................
	defb 0f7h,008h,0fbh,08bh,0e7h,0ech,0d8h,0d1h,0d3h,0f3h,0f3h,0fah,0c6h,07ch,002h,004h	; 746b  .............|..
	defb 0fdh,083h,03dh,074h,0ffh,003h,07fh,085h,070h,077h,074h,003h,0ebh,003h,0f7h,085h	; 747b  ..=t....pwt.....
	defb 00fh,0fbh,003h,0e8h,0e9h,005h,0ffh,081h,0efh,003h,0f4h,085h,0e4h,08ch,0b8h,0d8h	; 748b  ................
	defb 0ech,003h,07dh,0b5h,079h,05ah,042h,03ch,000h,0feh,0feh,0fdh,0fdh,0bbh,046h,03ch	; 749b  ..}.yZB<......F<
	defb 000h,0fch,0feh,0beh,0aeh,02ch,031h,01fh,000h,0ffh,0ffh,0bfh,09fh,0c3h,078h,00fh	; 74ab  .....,1.......x.
	defb 000h,0ffh,0feh,0feh,0f8h,0e3h,00eh,0f8h,000h,07bh,07ah,0fah,0bah,092h,0c6h,07ch	; 74bb  .........{z....|
	defb 000h,0fbh,003h,003h,002h,003h,001h,000h,000h,003h,0ebh,08dh,0cah,01bh,0f1h,000h	; 74cb  ................
	defb 000h,0ebh,0ebh,0e9h,0c9h,019h,0f0h,000h,000h,003h,0f7h,08dh,067h,08fh,0f9h,000h	; 74db  ............g...
	defb 000h,0e0h,0cfh,0d9h,090h,030h,0e0h,000h,000h,003h,0fbh,08dh,0f3h,0e7h,07ch,000h	; 74eb  .....0........|.
	defb 000h,0f7h,0f5h,0f5h,064h,08ch,0f8h,000h,000h,003h,0fbh,08dh,0b2h,0c6h,07ch,000h	; 74fb  ....d.........|.
	defb 000h,0ffh,07fh,07fh,09fh,0e7h,038h,00fh,000h,003h,0fdh,085h,0f9h,0e2h,00eh,0f8h	; 750b  ......8.........
	defb 000h,003h,07fh,095h,03fh,0c0h,07fh,000h,000h,0f9h,0fdh,0fdh,0fbh,004h,0ffh,000h	; 751b  ....?...........
	defb 000h,0ebh,0ebh,0e9h,0c9h,019h,0f0h,000h,000h,003h,0f4h,085h,064h,08ch,0f8h,000h	; 752b  ............d...
	defb 000h,000h	; 753b

; ----------------------------------------------------------------------
; DATOS grafico_753d: 326 comprimidos -> 1056 en la VRAM; lo carga 0x5df1
;   0x753d..0x7683  (326 bytes)
DATA_grafico_753d:
	defb 002h,000h,086h,090h,092h,092h,09ch,03ch,03ch,003h,000h,082h,090h,020h,003h,0c0h	; 753d  .......<<.... ..
	defb 003h,000h,082h,090h,020h,003h,0c0h,082h,042h,04ch,004h,0bch,002h,0b4h,082h,042h	; 754d  .... ...BL.....B
	defb 04ch,004h,0bch,002h,0b4h,082h,0c2h,0c3h,004h,0b3h,002h,0b4h,088h,0c2h,0c3h,0c3h	; 755d  L...............
	defb 0c2h,0b3h,0b3h,0b4h,0b4h,004h,096h,004h,092h,028h,054h,081h,074h,016h,075h,081h	; 756d  .........(T.t.u.
	defb 074h,028h,060h,081h,074h,016h,075h,08fh,074h,070h,070h,071h,07fh,07fh,07ah,07bh	; 757d  t(`.t.u.tppq..z{
	defb 07bh,070h,070h,010h,0f0h,0f0h,0a0h,004h,0b0h,08ch,0e0h,030h,0c0h,010h,070h,070h	; 758d  {pp........0..pp
	defb 07bh,07bh,07eh,073h,07ch,071h,004h,070h,084h,071h,07fh,07fh,07ah,004h,07bh,084h	; 759d  {{~s|q.p.q..z.{.
	defb 07eh,073h,07ch,071h,00ah,07bh,088h,0bch,02bh,0c2h,0c2h,012h,021h,0c1h,01ch,00ah	; 75ad  ~s|q.{..+...!...
	defb 0b7h,08ch,0b1h,0bfh,0bfh,0bah,0b0h,0b0h,0b7h,0b7h,0b1h,0bfh,0bfh,0bah,004h,0b0h	; 75bd  ................
	defb 098h,0beh,0b3h,0bch,0b1h,0b7h,0b7h,0b0h,0b0h,0beh,0b3h,0bch,0b1h,0b7h,0b7h,031h	; 75cd  ...............1
	defb 0c1h,01ch,03ch,012h,031h,0c3h,01ch,030h,0c0h,004h,03ch,085h,06ch,036h,020h,0c0h	; 75dd  ..<.1..0..<.l6 .
	defb 0c0h,005h,0c3h,081h,0f0h,004h,0b0h,081h,01bh,00ah,07bh,002h,050h,081h,0f0h,004h	; 75ed  ..........{.P...
	defb 0b0h,082h,010h,0f0h,004h,0b0h,084h,010h,050h,050h,0f0h,004h,0b0h,081h,0b1h,00ch	; 75fd  ........PP......
	defb 0b7h,081h,0beh,004h,0b0h,084h,010h,0b7h,0b7h,0beh,004h,0b0h,087h,010h,0b7h,0b7h	; 760d  ................
	defb 0b5h,0b5h,015h,015h,00ch,055h,002h,0f5h,002h,0b5h,002h,0b7h,004h,0bbh,002h,01bh	; 761d  .....U..........
	defb 00ch,05bh,002h,0fbh,004h,0bbh,002h,0b7h,002h,0b5h,002h,015h,00ch,055h,002h,0f5h	; 762d  .[...........U..
	defb 002h,0b5h,002h,0b7h,004h,0bbh,002h,01bh,00ch,05bh,002h,0fbh,004h,0bbh,002h,014h	; 763d  .........[......
	defb 085h,019h,01ah,019h,0f8h,016h,003h,014h,086h,01fh,017h,01ch,023h,013h,014h,004h	; 764d  ............#...
	defb 084h,081h,068h,003h,064h,010h,0f1h,083h,020h,0c0h,0c0h,005h,0c3h,008h,096h,004h	; 765d  ..h.d... .......
	defb 06bh,004h,069h,010h,0b0h,005h,054h,006h,057h,081h,05fh,004h,07fh,07fh,0f0h,07fh	; 766d  k.i...T.W._.....
	defb 0f0h,07fh,0f0h,063h,0f0h,000h	; 767d

; ----------------------------------------------------------------------
; DATOS grafico_7683: 807 comprimidos -> 1120 en la VRAM; lo carga 0x602c con
;   HL=0x1800, la tabla de nombres
;   0x7683..0x79aa  (807 bytes)
DATA_grafico_7683:
	defb 008h,000h,084h,020h,038h,01ch,00fh,00ch,000h,084h,004h,07ch,038h,030h,00ch,000h	; 7683  ... 8......|80..
	defb 084h,020h,03eh,01ch,00ch,00ch,000h,084h,004h,01ch,038h,0f0h,00eh,000h,083h,006h	; 7693  . >.......8.....
	defb 00fh,003h,00dh,000h,083h,070h,0f0h,0c0h,00dh,000h,083h,006h,00fh,003h,00dh,000h	; 76a3  .....p..........
	defb 083h,030h,0f0h,0c0h,005h,000h,089h,00eh,01fh,01fh,00dh,007h,00dh,00eh,007h,003h	; 76b3  .0..............
	defb 007h,000h,08ah,070h,0f8h,0f8h,0b0h,0e0h,0b0h,070h,080h,0c0h,0c0h,006h,000h,08ah	; 76c3  ...p.....p......
	defb 00eh,01fh,01fh,00dh,007h,00dh,00eh,001h,003h,003h,006h,000h,089h,070h,0f8h,0f8h	; 76d3  .............p..
	defb 0b0h,0e0h,0b0h,070h,0e0h,0c0h,007h,000h,081h,00eh,003h,01fh,086h,00dh,00fh,01dh	; 76e3  ...p............
	defb 01eh,019h,010h,006h,000h,081h,070h,003h,0f8h,085h,0b0h,0f0h,0b8h,078h,080h,007h	; 76f3  ......p......x..
	defb 000h,081h,00eh,003h,01fh,002h,00fh,002h,01fh,082h,019h,010h,006h,000h,081h,070h	; 7703  ...............p
	defb 003h,0f8h,085h,0f0h,0f8h,0f8h,0f0h,0c0h,00dh,000h,084h,020h,030h,013h,007h,00ch	; 7713  ........... 0...
	defb 000h,084h,004h,07ch,0f8h,0f0h,00ch,000h,084h,020h,03eh,01fh,00fh,00ch,000h,084h	; 7723  ...|..... >.....
	defb 004h,00ch,0c8h,0e0h,00eh,000h,083h,00eh,00fh,003h,00dh,000h,083h,060h,0f0h,0c0h	; 7733  .............`..
	defb 00dh,000h,083h,00ch,00fh,003h,00dh,000h,083h,060h,0f0h,0c0h,005h,000h,08ah,00eh	; 7743  .........`......
	defb 01fh,01fh,00dh,007h,00dh,00eh,00fh,00ch,018h,006h,000h,088h,070h,0f8h,0f8h,0b0h	; 7753  ............p...
	defb 0e0h,0b0h,070h,080h,008h,000h,088h,00eh,01fh,01fh,00dh,007h,00dh,00eh,001h,008h	; 7763  ..p.............
	defb 000h,08ah,070h,0f8h,0f8h,0b0h,0e0h,0b0h,070h,0f0h,030h,018h,006h,000h,089h,00ch	; 7773  ..p.....p.0.....
	defb 01eh,01fh,01fh,00dh,00fh,01dh,01eh,001h,007h,000h,08ah,030h,078h,0f8h,0f8h,0b0h	; 7783  ...........0x...
	defb 0f0h,0b8h,078h,098h,008h,006h,000h,089h,00ch,01eh,01fh,01fh,00fh,01fh,01fh,00fh	; 7793  ..x.............
	defb 003h,007h,000h,08ah,030h,078h,0f8h,0f8h,0f0h,0f0h,0f8h,0f8h,098h,008h,009h,000h	; 77a3  ....0x..........
	defb 086h,001h,004h,014h,014h,004h,001h,008h,000h,083h,020h,010h,010h,004h,088h,002h	; 77b3  .......... .....
	defb 010h,081h,020h,006h,000h,083h,004h,008h,008h,004h,011h,002h,008h,081h,004h,008h	; 77c3  .. .............
	defb 000h,086h,080h,020h,028h,028h,020h,080h,008h,000h,08ah,001h,000h,003h,000h,004h	; 77d3  ... (( .........
	defb 003h,000h,010h,00ch,003h,006h,000h,08ah,080h,000h,0c0h,000h,020h,0c0h,000h,008h	; 77e3  ............ ...
	defb 030h,0c0h,006h,000h,08ah,003h,00ch,010h,000h,003h,004h,000h,003h,000h,001h,006h	; 77f3  0...............
	defb 000h,08ah,0c0h,030h,008h,000h,0c0h,020h,000h,0c0h,000h,080h,005h,000h,08ah,00eh	; 7803  ...0... ........
	defb 01fh,013h,019h,02fh,03ch,007h,00eh,01dh,019h,006h,000h,08ah,070h,0f8h,0c8h,098h	; 7813  .../<.......p...
	defb 0f0h,038h,0ech,0e0h,0c0h,0f0h,006h,000h,08ah,00eh,01fh,013h,019h,00fh,01ch,037h	; 7823  .8.............7
	defb 007h,003h,00fh,006h,000h,08ah,070h,0f8h,0c8h,098h,0f4h,03ch,0e0h,070h,0b8h,098h	; 7833  ......p....<.p..
	defb 00ah,000h,081h,019h,003h,00ah,081h,009h,00bh,000h,081h,010h,003h,0a8h,081h,010h	; 7843  ................
	defb 009h,000h,088h,003h,004h,009h,00ah,002h,004h,002h,001h,008h,000h,088h,0c0h,020h	; 7853  ............... 
	defb 090h,050h,050h,090h,020h,0c0h,008h,000h,088h,003h,004h,009h,00ah,00ah,009h,004h	; 7863  .PP. ...........
	defb 003h,008h,000h,088h,080h,040h,020h,040h,050h,090h,020h,0c0h,005h,000h,08bh,0f8h	; 7873  .....@ @P. .....
	defb 01eh,0fbh,099h,03fh,00eh,007h,0c3h,0e7h,07fh,03fh,007h,000h,088h,040h,0c0h,000h	; 7883  ...?.....?...@..
	defb 040h,0c0h,000h,080h,080h,006h,000h,08bh,007h,01eh,0b7h,0e6h,03fh,09ch,0f8h,030h	; 7893  @...........?..0
	defb 079h,07fh,03fh,005h,000h,084h,0c0h,000h,0c0h,040h,003h,000h,002h,0c0h,081h,080h	; 78a3  y.?......@......
	defb 009h,000h,088h,003h,02dh,017h,07fh,0ffh,033h,009h,003h,004h,000h,08ch,039h,0cch	; 78b3  ....-...3.....9.
	defb 036h,07fh,0fdh,0ffh,0feh,0dfh,0ffh,07ah,0a8h,050h,004h,000h,08ch,09ch,033h,06ch	; 78c3  6......z.P....3l
	defb 0feh,0bfh,0ffh,07fh,0fbh,0ffh,07eh,015h,00ah,008h,000h,088h,0c0h,0b4h,0e8h,0feh	; 78d3  ......~.........
	defb 0ffh,0cch,090h,0c0h,005h,000h,08dh,006h,03ch,077h,061h,021h,002h,01ch,01ch,0c8h	; 78e3  ........<wa!....
	defb 064h,001h,01dh,01eh,003h,000h,0adh,060h,03ch,0beh,086h,084h,040h,038h,030h,010h	; 78f3  d......`<...@80.
	defb 02eh,0d6h,000h,070h,0f0h,060h,03ch,078h,043h,008h,018h,016h,014h,003h,060h,030h	; 7903  ...p.`<xC.....`0
	defb 018h,00eh,002h,000h,00ch,000h,03ch,01eh,0c2h,040h,018h,068h,028h,0c0h,000h,00ch	; 7913  ......<..@.h(...
	defb 010h,020h,060h,080h,003h,000h,0ffh,006h,03ch,070h,0e1h,061h,001h,01ch,018h,085h	; 7923  . `.....<p.a....
	defb 0d2h,078h,01ch,087h,031h,0feh,000h,060h,03ch,00eh,087h,086h,080h,038h,018h,0a1h	; 7933  .x..1..`<....8..
	defb 04bh,01eh,038h,0e1h,08ch,07fh,07ch,0f8h,0c3h,08fh,018h,016h,014h,0c3h,0e0h,078h	; 7943  K.8...|........x
	defb 02ch,007h,023h,078h,0ceh,000h,03eh,01fh,0c3h,0f1h,018h,068h,028h,0c3h,007h,01eh	; 7953  ,.#x..>....h(...
	defb 034h,0e0h,0c4h,01eh,073h,000h,000h,006h,03ch,070h,0e1h,061h,002h,01ch,018h,0c7h	; 7963  4...s...<p.a....
	defb 0e8h,06ch,01fh,087h,031h,0feh,000h,060h,03ch,00eh,087h,086h,040h,038h,018h,0e3h	; 7973  .l..1..`<...@8..
	defb 017h,036h,0e8h,0e1h,08ch,07fh,07ch,0f8h,0c3h,08fh,018h,016h,014h,003h,060h,038h	; 7983  .6....|.......`8
	defb 007h,003h,000h,078h,0ceh,000h,03eh,01fh,0c3h,0f1h,018h,068h,028h,0c0h,006h,01ch	; 7993  ...x..>....h(...
	defb 0e0h,0c0h,000h,01eh,073h,000h,000h	; 79a3

; ----------------------------------------------------------------------
; DATOS grafico_79aa: 298 comprimidos -> 448 en la VRAM
;   0x79aa..0x7ad4  (298 bytes)
DATA_grafico_79aa:
	defb 085h,003h,00fh,01fh,03fh,03fh,006h,07fh,002h,03fh,089h,01fh,00fh,00fh,0e0h,0f8h	; 79aa  ....??...?......
	defb 0fch,0fch,0feh,0feh,004h,0ffh,08ch,0f1h,0eeh,0dfh,0bfh,0bch,0fch,003h,00fh,03fh	; 79ba  ...............?
	defb 03fh,07fh,07fh,004h,0ffh,08bh,0c7h,0bbh,07dh,0fdh,0cfh,0cfh,080h,0e0h,0f0h,0f8h	; 79ca  ?.......}.......
	defb 0f8h,004h,0fch,002h,0f8h,002h,0f0h,08eh,0e0h,0c0h,0c0h,007h,00fh,03fh,07fh,0ffh	; 79da  .............?..
	defb 0ffh,0f7h,0e7h,007h,00fh,003h,005h,000h,00bh,0ffh,005h,000h,00bh,0ffh,005h,000h	; 79ea  ................
	defb 081h,0d8h,003h,0fch,083h,0f8h,0f0h,0e0h,003h,0f0h,081h,0c0h,009h,000h,087h,0f8h	; 79fa  ................
	defb 0f0h,0fch,07fh,03fh,01fh,00fh,00ch,000h,005h,0ffh,00bh,000h,005h,0ffh,007h,000h	; 7a0a  ...?............
	defb 089h,004h,00eh,01fh,03fh,0feh,0feh,0fch,0f0h,0c0h,004h,000h,0c0h,03ch,07eh,07eh	; 7a1a  ....?........<~~
	defb 07fh,07fh,03dh,0ddh,0ffh,0ffh,078h,030h,038h,03fh,07fh,0fbh,0fch,03ch,07eh,07fh	; 7a2a  ..=...x08?...<~.
	defb 0ffh,0ffh,0beh,0bch,0fch,0ffh,03fh,01eh,01ch,0fch,0feh,0dfh,03fh,03ch,07eh,07eh	; 7a3a  ......?.....?<~~
	defb 07fh,07fh,03dh,01dh,0dfh,0ffh,0fbh,07dh,01eh,01fh,007h,003h,001h,03ch,07eh,07eh	; 7a4a  ..=....}.....<~~
	defb 0feh,0feh,0bch,0b8h,0fbh,0ffh,0dfh,0beh,078h,0f8h,0e0h,0c0h,080h,00ah,000h,002h	; 7a5a  ........x.......
	defb 07fh,083h,03fh,01fh,007h,00bh,000h,003h,0feh,082h,0fch,0f8h,00ch,000h,082h,033h	; 7a6a  ..?............3
	defb 00ch,00eh,000h,082h,036h,0cch,003h,000h,0a0h,03ch,07eh,07eh,07fh,07fh,03dh,01dh	; 7a7a  ....6....<~~..=.
	defb 01fh,03fh,0ffh,0f8h,07fh,01fh,07fh,0fbh,0fch,03ch,07eh,07fh,0ffh,0ffh,0beh,0bch	; 7a8a  .?.......<~.....
	defb 0fch,0fch,0feh,01fh,0ffh,0fch,0feh,0dfh,03fh,00bh,000h,082h,00ch,033h,00eh,000h	; 7a9a  ........?....3..
	defb 082h,0cch,036h,003h,000h,081h,067h,003h,0ffh,087h,07fh,03fh,00fh,00fh,007h,00fh	; 7aaa  ..6...g....?....
	defb 003h,005h,000h,00bh,0ffh,005h,000h,00bh,0ffh,005h,000h,08bh,0c0h,0e0h,0f8h,0fch	; 7aba  ................
	defb 0feh,0feh,0eeh,0e0h,0f0h,0f0h,0c0h,005h,000h,000h	; 7aca  ..........

; ======================================================================
; CODIGO 0x7ad4..0x7c9d  (457 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Pide un efecto de sonido. Guarda TODOS los registros -incluidos IX e IY- porque la llaman desde cualquier sitio del juego, y corta las interrupciones para que el manejador no le pise el PSG a medias.
; Pide un efecto de sonido. Guarda TODOS los registros -incluidos IX e IY- porque la llaman desde cualquier sitio del juego, y corta las interrupciones para que el manejador no le pise el PSG a medias.
; Pide un efecto de sonido. Guarda TODOS los registros -incluidos IX e IY- porque la llaman desde cualquier sitio del juego, y corta las interrupciones para que el manejador no le pise el PSG a medias.
; ----------------------------------------------------------------------
suena:
	di			;7ad4   ; el manejador tambien toca el PSG
	push hl			;7ad5
	push de			;7ad6
	push bc			;7ad7
	push af			;7ad8
	push ix		;7ad9
	push iy		;7adb
	call elige_el_canal_del_efecto		;7add   ; el trabajo de verdad
	pop iy		;7ae0
	pop ix		;7ae2
	pop af			;7ae4
	pop bc			;7ae5
	pop de			;7ae6
	pop hl			;7ae7
	ei			;7ae8   ; y se devuelven las interrupciones
	ret			;7ae9

; ----------------------------------------------------------------------
; Reparte el efecto entre los dos juegos de canales segun su numero: los de menos de 10 van a un sitio, los de 10 y 11 a otro y el resto a un tercero.
; Reparte el efecto entre los dos juegos de canales segun su numero: los de menos de 10 van a un sitio, los de 10 y 11 a otro y el resto a un tercero.
; Reparte el efecto entre los dos juegos de canales segun su numero: los de menos de 10 van a un sitio, los de 10 y 11 a otro y el resto a un tercero.
; ----------------------------------------------------------------------
elige_el_canal_del_efecto:
	ld c,a			;7aea   ; el numero de efecto
	ld b,002h		;7aeb   ; dos canales por efecto
	ld hl,0e01ah		;7aed   ; el bloque de canales
	and 03fh		;7af0   ; los seis bits del numero
	cp 00ah		;7af2   ; por debajo de 10
	jr c,efecto_de_prioridad_baja		;7af4
	cp 00ch		;7af6   ; el 10 y el 11
	jr c,compara_la_prioridad		;7af8
	inc b			;7afa   ; y de 12 en adelante, tres canales
	jr compara_la_prioridad		;7afb
efecto_de_prioridad_baja:
	dec b			;7afd   ; un canal menos
	cp 008h		;7afe   ; los de menos de 8
	jr nc,compara_la_prioridad		;7b00
	ld hl,0e036h		;7b02   ; van a su propio bloque

; ----------------------------------------------------------------------
; La regla de prioridad: si lo que esta sonando tiene un numero MAYOR o igual, el efecto nuevo no entra. Asi los avisos importantes no se pierden.
; La regla de prioridad: si lo que esta sonando tiene un numero MAYOR o igual, el efecto nuevo no entra. Asi los avisos importantes no se pierden.
; La regla de prioridad: si lo que esta sonando tiene un numero MAYOR o igual, el efecto nuevo no entra. Asi los avisos importantes no se pierden.
; ----------------------------------------------------------------------
compara_la_prioridad:
	ld a,(hl)			;7b05   ; lo que esta sonando
	and 03fh		;7b06   ; sus seis bits
	ld e,a			;7b08
	ld a,c			;7b09   ; el efecto que se pide
	and 03fh		;7b0a
	cp e			;7b0c   ; si el que suena es mayor, no entra
	ret c			;7b0d
	ret z			;7b0e   ; ni si son iguales
	add a,a			;7b0f   ; por dos: la tabla lleva punteros
	ld de,07ca7h		;7b10   ; la tabla de guiones de sonido
	call suma_a_a_de		;7b13   ; el que toca
	dec hl			;7b16   ; y atras, al principio del canal
	dec hl			;7b17
monta_un_canal:
	push hl			;7b18
	pop ix		;7b19   ; el canal, en IX
	ld (hl),001h		;7b1b   ; se enciende
	inc hl			;7b1d
	ld (hl),001h		;7b1e   ; y se marca como nuevo
	inc hl			;7b20
	ld (hl),c			;7b21   ; el numero de efecto, que es su prioridad
	inc hl			;7b22
	ld (ix+009h),000h		;7b23   ; el paso del guion, a cero
	ld a,(de)			;7b27   ; el puntero al guion
	ld (hl),a			;7b28
	inc hl			;7b29
	inc de			;7b2a
	ld a,(de)			;7b2b   ; sus dos bytes
	ld (hl),a			;7b2c
	ld a,00ah		;7b2d   ; 0x0A es lo que ocupa un canal
	add a,l			;7b2f
	ld l,a			;7b30
	inc de			;7b31   ; el guion del canal siguiente
	djnz monta_un_canal		;7b32   ; los dos canales
	ret			;7b34

; ----------------------------------------------------------------------
; Da un paso del guion del canal: si ha llegado al final de la frase, la cierra; si no, coge la nota y su duracion.
; Da un paso del guion del canal: si ha llegado al final de la frase, la cierra; si no, coge la nota y su duracion.
; Da un paso del guion del canal: si ha llegado al final de la frase, la cierra; si no, coge la nota y su duracion.
; ----------------------------------------------------------------------
avanza_el_guion:
	inc hl			;7b35
	ld a,(ix+009h)		;7b36   ; el paso actual
	inc a			;7b39   ; uno mas
	cp (hl)			;7b3a   ; comparado con el largo de la frase
	jr z,cierra_la_frase		;7b3b   ; si coincide, se acaba
	jp m,coge_la_nota		;7b3d   ; y si se ha pasado, se queda donde estaba
	dec a			;7b40
coge_la_nota:
	ld (ix+009h),a		;7b41   ; el paso nuevo
	inc hl			;7b44
	ld a,(hl)			;7b45   ; la nota
	ld (ix+003h),a		;7b46
	inc hl			;7b49   ; y su duracion
	ld a,(hl)			;7b4a   ; guardadas
	ld (ix+004h),a		;7b4b
	jr cuenta_el_paso		;7b4e
cierra_la_frase:
	inc hl			;7b50
	inc hl			;7b51
	xor a			;7b52   ; el paso, a cero
	ld (ix+009h),a		;7b53
	call L_7C95		;7b56   ; y se apaga el canal
cuenta_el_paso:
	inc (ix+000h)		;7b59   ; un paso mas del canal
	jr L_7B90		;7b5c
apaga_los_canales:
	ld (0e042h),a		;7b5e   ; el valor que se guarda
	ld e,a			;7b61
	ld a,007h		;7b62   ; el registro 7 del PSG: el que enciende y apaga los canales
	jp 00093h		;7b64   ; BIOS WRTPSG - Writes data to PSG-register

; ----------------------------------------------------------------------
; Lo que el sonido hace en cada cuadro: recorre los tres canales del PSG y, en cada uno, o sigue el guion que tenga o lo deja callado.
; Lo que el sonido hace en cada cuadro: recorre los tres canales del PSG y, en cada uno, o sigue el guion que tenga o lo deja callado.
; Lo que el sonido hace en cada cuadro: recorre los tres canales del PSG y, en cada uno, o sigue el guion que tenga o lo deja callado.
; ----------------------------------------------------------------------
atiende_el_sonido:
	ld a,(0e042h)		;7b67   ; el estado de los canales
	call apaga_los_canales		;7b6a
	ld c,001h		;7b6d   ; el primer registro de tono del PSG
	ld ix,0e018h		;7b6f   ; el primer canal
	exx			;7b73
	ld b,003h		;7b74   ; los tres
	ld de,0000eh		;7b76   ; 0x0E es lo que hay entre canal y canal
atiende_un_canal:
	exx			;7b79
	ld a,(ix+002h)		;7b7a   ; el efecto que suena en el
	or a			;7b7d   ; sin efecto, se calla
	jr nz,L_7B85		;7b7e
	call L_7BE2		;7b80   ; y se apaga
	jr pasa_al_canal_siguiente		;7b83
L_7B85:
	call L_7B90		;7b85   ; y con efecto, se sigue el guion
pasa_al_canal_siguiente:
	inc c			;7b88   ; dos registros por canal
	inc c			;7b89   ; el tono es de 16 bits
	exx			;7b8a
	add ix,de		;7b8b
	djnz atiende_un_canal		;7b8d
	ret			;7b8f
L_7B90:
	ld a,(ix+002h)		;7b90
	or a			;7b93
	jp m,apaga_el_tono		;7b94
	dec (ix+000h)		;7b97
	ret nz			;7b9a

; ----------------------------------------------------------------------
; Lee el byte del guion del canal y decide que es: 0xFE cierra la frase, un valor mayor la termina, y si no, el medio byte alto dice el tipo de orden y el bajo su argumento.
; Lee el byte del guion del canal y decide que es: 0xFE cierra la frase, un valor mayor la termina, y si no, el medio byte alto dice el tipo de orden y el bajo su argumento.
; ----------------------------------------------------------------------
lee_el_guion_del_canal:
	ld l,(ix+003h)		;7b9b   ; el puntero al guion
	ld h,(ix+004h)		;7b9e
	ld a,(hl)			;7ba1   ; el byte que toca
	cp 0feh		;7ba2   ; el 0xFE cierra la frase
	jp z,avanza_el_guion		;7ba4
	jr nc,L_7BE2		;7ba7   ; y por encima, se acaba
	bit 7,(ix+002h)		;7ba9   ; el bit 7 del canal: esta en modo ruido
	jp nz,pon_el_volumen		;7bad   ; y entonces solo se toca el volumen
	and 0f0h		;7bb0   ; el medio byte alto es la orden
	cp 020h		;7bb2   ; la orden 2 cambia la duracion
	jr nz,toca_la_nota		;7bb4
	ld a,(hl)			;7bb6   ; su medio byte bajo
	and 00fh		;7bb7
	ld (ix+001h),a		;7bb9   ; es la duracion nueva
	inc hl			;7bbc   ; y se pasa al byte siguiente

; ----------------------------------------------------------------------
; Toca la nota: el medio byte alto es la octava y el bajo, junto con el byte que sigue, el tono que va a los dos registros del PSG.
; Toca la nota: el medio byte alto es la octava y el bajo, junto con el byte que sigue, el tono que va a los dos registros del PSG.
; ----------------------------------------------------------------------
toca_la_nota:
	ld a,(hl)			;7bbd   ; el byte de la nota
	and 0f0h		;7bbe   ; su medio byte alto: la octava
	ld b,a			;7bc0
	xor (hl)			;7bc1   ; y el bajo, quitandole la octava
	ld d,a			;7bc2
	inc hl			;7bc3   ; el byte siguiente
	ld e,(hl)			;7bc4   ; completa el tono
	call L_7C95		;7bc5   ; lo ajusta
	ex de,hl			;7bc8
	call L_7C83		;7bc9   ; y lo escala
	ld a,b			;7bcc   ; la octava
	rrca			;7bcd   ; cuatro vueltas: a su sitio
	rrca			;7bce
	rrca			;7bcf
	rrca			;7bd0
calla_el_canal:
	ld h,a			;7bd1   ; el canal, apagado
	ld a,(ix+001h)		;7bd2
	ld (ix+000h),a		;7bd5
	add a,002h		;7bd8
	ld (ix+008h),a		;7bda
	ld (ix+008h),a		;7bdd
	jr L_7C0D		;7be0
L_7BE2:
	xor a			;7be2
	ld (ix+00bh),a		;7be3
	ld (ix+002h),a		;7be6
	ld h,a			;7be9
	jr L_7C0D		;7bea
apaga_el_tono:
	dec (ix+000h)		;7bec   ; el registro de tono
	jr z,lee_el_guion_del_canal		;7bef
	dec (ix+008h)		;7bf1
	ld a,(ix+008h)		;7bf4
	cp (ix+000h)		;7bf7
	jr nz,L_7C01		;7bfa
	cp 002h		;7bfc
	jr c,L_7C04		;7bfe
	ret			;7c00
L_7C01:
	dec (ix+008h)		;7c01
L_7C04:
	ld a,(ix+007h)		;7c04
	dec a			;7c07
	ret m			;7c08
	ld (ix+007h),a		;7c09
	ld h,a			;7c0c
L_7C0D:
	ld a,c			;7c0d
	rrca			;7c0e
	add a,088h		;7c0f
	ld e,h			;7c11
	jp 00093h		;7c12   ; BIOS WRTPSG - Writes data to PSG-register
pon_el_volumen:
	ld a,(hl)			;7c15   ; el registro de volumen del canal
	and 0f0h		;7c16
	cp 0d0h		;7c18
	ld a,(hl)			;7c1a
	jr nz,pon_el_tono		;7c1b
	and 00fh		;7c1d
	ld (ix+00ah),a		;7c1f
	inc hl			;7c22
	ld a,(hl)			;7c23
pon_el_tono:
	cp 0f0h		;7c24   ; el registro de tono del canal
	jr c,avanza_la_nota		;7c26
	and 00fh		;7c28
	ld (ix+006h),a		;7c2a
	inc hl			;7c2d
	ld a,(hl)			;7c2e
avanza_la_nota:
	cp 0e0h		;7c2f   ; la nota siguiente del guion
	jr c,L_7C44		;7c31
	and 00fh		;7c33
	bit 3,a		;7c35
	jr z,L_7C3F		;7c37
	ld (ix+00bh),a		;7c39
	inc hl			;7c3c
	jr pon_el_volumen		;7c3d
L_7C3F:
	ld (ix+005h),a		;7c3f
	inc hl			;7c42
	ld a,(hl)			;7c43
L_7C44:
	and 00fh		;7c44
	ld b,a			;7c46
	ld a,(ix+00ah)		;7c47
	jr z,aplica_el_sobre		;7c4a
L_7C4C:
	add a,(ix+00ah)		;7c4c
	djnz L_7C4C		;7c4f
aplica_el_sobre:
	ld (ix+001h),a		;7c51   ; el volumen que toca a este paso
	ld a,(hl)			;7c54   ; el byte del sobre
	call L_7C95		;7c55
	and 0f0h		;7c58   ; su medio byte alto
	rrca			;7c5a   ; cuatro vueltas: el valor a la derecha
	rrca			;7c5b
	rrca			;7c5c
	rrca			;7c5d
	ld b,a			;7c5e
	sub 00ch		;7c5f   ; el 0x0C marca el final del sobre
	ld (ix+007h),a		;7c61   ; el paso del sobre
	jr z,escala_el_tono		;7c64   ; llegados al final, se mantiene
	ld a,(ix+006h)		;7c66   ; y si no, se guarda el volumen de antes
	ld (ix+007h),a		;7c69
escala_el_tono:
	call calla_el_canal		;7c6c   ; el tono, escalado por la rampa de 0x7c9d
	ld a,b			;7c6f
	ld hl,07c9dh		;7c70
	call suma_a_a_hl		;7c73
	ld l,(hl)			;7c76
	ld h,000h		;7c77
	ld a,(ix+005h)		;7c79
	or a			;7c7c
	jr z,L_7C83		;7c7d
	ld b,a			;7c7f
L_7C80:
	add hl,hl			;7c80
	djnz L_7C80		;7c81
L_7C83:
	ld a,(ix+00bh)		;7c83
	or a			;7c86
	jr z,L_7C8A		;7c87
	inc hl			;7c89
L_7C8A:
	ld a,c			;7c8a
	ld e,h			;7c8b
	call 00093h		;7c8c   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,c			;7c8f
	dec a			;7c90
	ld e,l			;7c91
	jp 00093h		;7c92   ; BIOS WRTPSG - Writes data to PSG-register
L_7C95:
	inc hl			;7c95
	ld (ix+003h),l		;7c96
	ld (ix+004h),h		;7c99
	ret			;7c9c

; ----------------------------------------------------------------------
; DATOS rampa_7c9d: 12 bytes decrecientes, indexados por 0x7c70
;   0x7c9d..0x7ca9  (12 bytes)
DATA_rampa_7c9d:
	defb 06ah,064h,05fh,059h,054h,050h,04bh,047h,043h,03fh,03ch,038h	; 7c9d  jd_YTPKGC?<8

; ----------------------------------------------------------------------
; DATOS tabla_de_guiones: 27 punteros a los guiones de movimiento; la indexa
;   0x7b10 con base 0x7ca7
;   0x7ca9..0x7cdf  (54 bytes)
DATA_tabla_de_guiones:
	defw 07e1eh,07de7h,07e05h,07d72h,07ce0h,07d99h,07d91h,07dc2h	; 7ca9
	defw 07e30h,07f5eh,07f96h,07e84h,07e9eh,07cdfh,07eb8h,07eb9h	; 7cb9
	defw 07ee5h,07ef9h,07efah,07f31h,07cf2h,07cdfh,07cdfh,07e61h	; 7cc9
	defw 07cdfh,07cdfh,07cdfh	; 7cd9  -> DATA_guiones_de_movimiento DATA_guiones_de_movimiento DATA_guiones_de_movimiento

; ----------------------------------------------------------------------
; DATOS guiones_de_movimiento: los 22 guiones distintos, en pares de bytes y
;   con 0xFF de separador
;   0x7cdf..0x7fc9  (746 bytes)
DATA_guiones_de_movimiento:
	defb 0ffh,022h,0e0h,0a0h,0d0h,0a0h,000h,000h,0e1h,000h,0d1h,000h,000h,000h,0e1h,050h	; 7cdf  .".............P
	defb 0d1h,050h,0ffh,021h,0e3h,0a0h,0e3h,050h,0e3h,000h,0e2h,0a0h,0e2h,050h,0e2h,000h	; 7cef  .P.!...P.....P..
	defb 0e1h,0a0h,0e1h,050h,0c1h,040h,0d3h,0a0h,0d3h,050h,0d3h,000h,0d2h,0a0h,0d2h,050h	; 7cff  ...P.@...P.....P
	defb 0d2h,000h,0d1h,0a0h,0d1h,050h,0b1h,040h,0c3h,0a0h,0c3h,050h,0c3h,000h,0c2h,0a0h	; 7d0f  .....P.@...P....
	defb 0c2h,050h,0c2h,000h,0c1h,0a0h,0c1h,050h,0a1h,040h,0b3h,0a0h,0b3h,050h,0b3h,000h	; 7d1f  .P.....P.@...P..
	defb 0b2h,0a0h,0b2h,050h,0b2h,000h,0b1h,0a0h,0b1h,050h,091h,040h,0a3h,0a0h,0a3h,050h	; 7d2f  ...P.....P.@...P
	defb 0a3h,000h,0a2h,0a0h,0a2h,050h,0a2h,000h,0a1h,0a0h,0a1h,050h,081h,040h,093h,0a0h	; 7d3f  .....P.....P.@..
	defb 093h,050h,093h,000h,092h,0a0h,092h,050h,092h,000h,091h,0a0h,091h,050h,071h,040h	; 7d4f  .P.....P.....Pq@
	defb 083h,0a0h,083h,050h,083h,000h,082h,0a0h,082h,050h,082h,000h,081h,0a0h,081h,050h	; 7d5f  ...P.....P.....P
	defb 061h,040h,0ffh,0d1h,0fdh,0e1h,040h,000h,040h,000h,040h,000h,0fch,040h,000h,040h	; 7d6f  a@....@.@.@..@.@
	defb 000h,040h,000h,0fbh,040h,000h,040h,000h,040h,000h,0fah,040h,000h,040h,000h,040h	; 7d7f  .@..@.@.@..@.@.@
	defb 000h,0ffh,021h,0e0h,0beh,0c0h,097h,000h,000h,0ffh,0d1h,0fdh,0e2h,040h,050h,060h	; 7d8f  ..!..........@P`
	defb 070h,080h,090h,0a0h,0b0h,0e1h,000h,010h,020h,030h,040h,050h,060h,090h,0b0h,0e0h	; 7d9f  p....... 0@P`...
	defb 000h,0fbh,0e2h,070h,090h,0b0h,0e1h,000h,020h,040h,050h,070h,090h,0b0h,0e0h,000h	; 7daf  ...p.... @Pp....
	defb 020h,040h,0ffh,021h,081h,080h,0a1h,070h,091h,060h,0a1h,050h,091h,040h,091h,030h	; 7dbf   @.!...p.`.P.@.0
	defb 091h,020h,0a1h,010h,091h,000h,0a1h,010h,091h,020h,091h,030h,091h,040h,091h,050h	; 7dcf  . ....... .0.@.P
	defb 081h,060h,081h,070h,0feh,0ffh,0c2h,07dh,022h,0a3h,0a0h,0c2h,050h,0b3h,0a0h,0d2h	; 7ddf  .`.p...}"...P...
	defb 050h,0b3h,0a0h,0d2h,050h,0c3h,0a0h,0e2h,050h,0c3h,0a0h,0e2h,050h,0d3h,0a0h,0f2h	; 7def  P...P...P...P...
	defb 050h,0c3h,0a0h,0e2h,050h,0ffh,021h,0d1h,090h,0d2h,090h,0d1h,070h,0d2h,070h,023h	; 7dff  P...P.!.....p.p#
	defb 000h,000h,021h,0d1h,080h,0d2h,080h,0d1h,060h,0d2h,060h,023h,000h,000h,0ffh,0d1h	; 7e0f  ..!.....`.`#....
	defb 0fdh,0e1h,040h,050h,040h,050h,0c0h,000h,010h,000h,010h,0c0h,0feh,002h,01eh,07eh	; 7e1f  ..@P@P.........~
	defb 0ffh,0d1h,0fch,0e3h,040h,0e2h,040h,0e3h,050h,0e2h,050h,0e3h,070h,0e2h,070h,0e3h	; 7e2f  ....@.@.P.P.p.p.
	defb 090h,0e2h,090h,0e3h,0b0h,0e2h,0b0h,0c1h,0f9h,0e3h,040h,0e2h,040h,0e3h,050h,0e2h	; 7e3f  ..........@.@.P.
	defb 050h,0e3h,070h,0e2h,070h,0e3h,090h,0e2h,090h,0e3h,0b0h,0e2h,0b0h,0c1h,0feh,0ffh	; 7e4f  P.p.p...........
	defb 030h,07eh,021h,0c0h,080h,0c0h,082h,0b0h,080h,0a0h,080h,090h,080h,0c0h,0c0h,0c0h	; 7e5f  0~!.............
	defb 0c2h,0b0h,0c0h,0a0h,0c0h,090h,0c0h,0feh,002h,061h,07eh,090h,0c0h,022h,080h,0c0h	; 7e6f  .........a~.."..
	defb 070h,0c0h,060h,0c0h,0ffh,0d1h,0fdh,0e1h,040h,050h,060h,0c8h,0e0h,060h,070h,060h	; 7e7f  p.`.....@P`..`p`
	defb 070h,060h,040h,030h,020h,010h,000h,0e1h,0b0h,0c8h,0feh,004h,084h,07eh,0ffh,0d1h	; 7e8f  p`@0 ........~..
	defb 0fdh,0e1h,000h,010h,020h,0c8h,0e0h,020h,030h,020h,030h,020h,000h,0e1h,0b0h,0a0h	; 7e9f  .... .. 0 0 ....
	defb 090h,080h,070h,0c8h,0feh,004h,09eh,07eh,0ffh,0e8h,0d1h,0fch,0e2h,055h,0c2h,057h	; 7eaf  ..p....~.....U.W
	defb 0c2h,099h,057h,0cbh,059h,0b9h,0e1h,009h,0e2h,055h,0c2h,057h,0c2h,099h,057h,0cbh	; 7ebf  ..W.Y....U.W..W.
	defb 0e1h,009h,007h,0cbh,0e2h,055h,0c2h,057h,0c2h,099h,057h,0cbh,059h,0b9h,0e1h,009h	; 7ecf  .....U.W..W.Y...
	defb 009h,0e2h,009h,049h,059h,0ffh,0d1h,0fbh,0e3h,059h,099h,049h,099h,029h,009h,009h	; 7edf  ...IY....Y.I.)..
	defb 009h,0feh,003h,0e8h,07eh,009h,029h,049h,059h,0ffh,0e8h,0d6h,0fch,0e1h,070h,0c0h	; 7eef  ....~.)IY.....p.
	defb 070h,0c0h,070h,040h,070h,050h,0c0h,050h,020h,0c0h,0e2h,0a0h,0e1h,000h,020h,0e2h	; 7eff  p.p@pP.P ..... .
	defb 0a0h,0e1h,000h,0c0h,000h,0c0h,000h,0e2h,070h,0e1h,000h,050h,0c0h,050h,020h,0c0h	; 7f0f  ........p..P.P .
	defb 0e2h,0a0h,0c0h,0e1h,020h,0c3h,0e2h,0b0h,0e1h,000h,0e2h,060h,070h,0e3h,0b0h,0e2h	; 7f1f  .... ......`p...
	defb 000h,0ffh,0d6h,0fch,0e2h,000h,0c0h,000h,0c0h,000h,0e3h,070h,0e2h,000h,020h,0c0h	; 7f2f  ...........p.. .
	defb 020h,0e3h,0a0h,0c0h,050h,0c2h,0e2h,070h,0c0h,070h,0c0h,070h,040h,070h,090h,0c0h	; 7f3f   ...P..p.p.p@p..
	defb 090h,070h,0c0h,050h,0c0h,090h,0c3h,030h,040h,0e3h,0a0h,0b0h,030h,040h,0ffh,0d7h	; 7f4f  .p.P...0@...0@..
	defb 0fch,0e2h,070h,070h,070h,0e1h,000h,0c0h,000h,040h,040h,0feh,003h,05eh,07fh,020h	; 7f5f  ..ppp....@@..^. 
	defb 040h,020h,0e2h,0b0h,0c0h,0b0h,070h,0b0h,0e1h,000h,000h,000h,040h,0c0h,040h,070h	; 7f6f  @ ....p.....@.@p
	defb 070h,0feh,003h,077h,07fh,050h,040h,020h,0e2h,0b0h,0fbh,0e1h,070h,0fch,0e2h,070h	; 7f7f  p..w.P@ ....p..p
	defb 0b0h,0e1h,020h,0feh,0ffh,05eh,07fh,0d7h,0fbh,0e3h,000h,000h,000h,040h,0c0h,040h	; 7f8f  .. ..^.......@.@
	defb 070h,070h,0feh,003h,096h,07fh,050h,070h,050h,020h,0c0h,020h,0e4h,0b0h,0b0h,0e3h	; 7f9f  pp....PpP . ....
	defb 000h,000h,000h,040h,0c0h,040h,070h,070h,0feh,003h,0aeh,07fh,090h,070h,050h,020h	; 7faf  ...@.@pp.....pP 
	defb 070h,0e4h,0b0h,0e3h,020h,070h,0feh,0ffh,096h,07fh	; 7fbf  p... p....

; ----------------------------------------------------------------------
; DATOS relleno_final: 42 bytes de 0xFF entre el ultimo dato y la marca
;   0x7fc9..0x7ff4  (43 bytes)
DATA_relleno_final:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fd9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fe9  ...........

; ----------------------------------------------------------------------
; DATOS marca_de_konami: el titulo en katakana del reves (9 bytes), su
;   longitud, el 0x28 de RC-728 y el 0xAA que cierra
;   0x7ff4..0x8000  (12 bytes)
DATA_marca_de_konami:
	defb 0bah,0b1h,0b7h,08bh,0ach,0a9h,0b8h,09ah,0a2h,009h,028h,0aah	; 7ff4  ..........(.
