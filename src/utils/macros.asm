;
;
;
MOVETOC macro
    dc.w        $4e7b,$\1\2
endm


;
; TODO: describe
;
OPENLIB macro
	movea.l		_AbsExecBase,a6
	lea.l		\1,a1 
	move.l		#\2,d0 
	jsr			_LVOOpenLibrary(a6)
    move.l		d0,\3
	tst.l		d0
	beq.w		\4
endm


;
; TODO: describe
;
CLOSELIB macro
	tst.l		\1
	beq.s		.\@Ok
	movea.l		_AbsExecBase,a6
	movea.l		\1,a1
	jsr			_LVOCloseLibrary(a6)
	.\@Ok:
endm
	

;
; TODO: describe
;
TESTCONDITION macro
	
	; Get truth table entry for fpsrcc
	bfextu		RegFpsrCc{0:8},d1
	move.l		(FPCCTABLE,d1.w*4),d1
	
	; Test truth bit for the predicate
	btst		d0,d1
	bne.w		\1
	bra.w		\2

endm
FPCCTABLE				
				dc.l	$cccccccc,$ff00ff00,$cccccccc,$ff00ff00
				dc.l	$aaaaaaaa,$bf2abf2a,$aaaaaaaa,$bf2abf2a
				dc.l	$f0f0f0f0,$ff00ff00,$f0f0f0f0,$ff00ff00
				dc.l	$aaaaaaaa,$bf2abf2a,$aaaaaaaa,$bf2abf2a


;
; Moves value from floating point register to data registers.
;
; INPUTS
;	\1 -- Index register.
;	\2 -- Data register.
;	\3 -- Data register.
;
MOVEFPNTODN macro
	lea.l		RegFpn,a1
	movem.l		(a1,\1.w*8),\2/\3
endm


;
; Moves value from data registers to floating point register.
; 
; INPUTS
;	\1 -- Index register.
;	\2 -- Data register.
;	\3 -- Data register.
;
MOVEDNTOFPN macro
	lea.l		RegFpn,a1
	movem.l		\2/\3,(a1,\1.w*8)
endm


;
; Moves value from floating point register to memory.
;
; INPUTS
;	\1 -- Index register.
;	\2 -- Address register.
;
MOVEFPNTOEA macro
	lea.l		RegFpn,a0
	move.l		(a0,\1.w*8),(\2)
	move.l		($04,a0,\1.w*8),$04(\2)
endm


;
; Moves value from memory to floating point register.
; 
; INPUTS
;	\1 -- Index register.
;	\2 -- Address register.
;
; TODO: swap inputs to be coherent
;
MOVEEATOFPN macro
	lea.l		RegFpn,a0
	move.l		(\2),(a0,\1.w*8)
	move.l		$04(\2),($04,a0,\1.w*8)
endm


;
; Shifts stack and stack frame to left.
; 
; INPUTS
;	\1 -- Data length.
;	STACKFRAME -- Stack frame address.
;
; RESULT
;	a1 -- End of the stack frame.
;
; TODO: this won't work with bytes and words!!!
;
STACKSL macro 

	; Calculate amount of shift
	move.l		\1,d0
	neg.l		d0
	
	; Calculate region to shift (from a0 to a1)
	movea.l		a7,a0
	movea.l		STACKFRAME,a1
	ifd STACK020 
		adda.l		#8,a1
	endif
	ifd STACK040 
		adda.l		#16,a1
	endif
	
	; Shift blocks
	.Loop:
	move.l		(a0),(a0,d0.l)
	adda.l		#4,a0
	cmpa.l		a0,a1
	bgt.s		.Loop
	
	; Adjust stack pointer and stack frame address
	suba.l		\1,a7
	suba.l		\1,STACKFRAME
	
	; Return end of shifted area
	suba.l		\1,a1
	
endm

;
; Shifts stack and stack frame to right.
; 
; INPUTS
;	\1 -- Data length.
;	STACKFRAME -- Stack frame address.
;
; TODO: this won't work with bytes and words!!!
;
STACKSR macro 
	
	; Calculate amount of shift
	move.l		\1,d0
	
	; Calculate region to shift (from a0 to a1)
	movea.l		a7,a0
	movea.l		STACKFRAME,a1
	ifd STACK020 
		adda.l		#8,a1
	endif
	ifd STACK040 
		adda.l		#16,a1
	endif

	; TODO: this is hideous hack, we copy ea data to another location because
	; this shifting will overwrite it... think about somethign proper........
	; also this is implemented in hurry, one can optimize a lot :)
	move.l		\1,d1
	movem.l		a2/a3,.HackAn
	lea.l		.HackEa,a2
	.HackLoop:
	subi.b		#4,d1
	move.l		(a1,d1),(a2,d1)
	bge.s		.HackLoop
	
	; Shift blocks
	.Loop:
	suba.l		#4,a1
	move.l		(a1),(a1,d0.l)
	cmpa.l		a1,a0
	blt.s		.Loop
	
	; Adjust stack pointer and stack frame address
	adda.l		\1,a7
	adda.l		\1,STACKFRAME	
	
	; More hack
	movem.l		.HackAn,a2/a3
	
	jmp .Hack
	.HackAn:	dc.l 0,0
	.HackEa:	dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.Hack:
	
endm


;
; TODO: wip
;
INREMENTPC macro 
	add.l		\1,FAULTPC
endm


;
; 
;
REVERSEBYTE macro
    bfclr       \1{0:24}
    move.b      (ReversedBytes,\1.w),\1
endm
ReversedBytes:
    dc.b      $00,$80,$40,$c0,$20,$a0,$60,$e0,$10,$90,$50,$d0,$30,$b0,$70,$f0
    dc.b      $08,$88,$48,$c8,$28,$a8,$68,$e8,$18,$98,$58,$d8,$38,$b8,$78,$f8
    dc.b      $04,$84,$44,$c4,$24,$a4,$64,$e4,$14,$94,$54,$d4,$34,$b4,$74,$f4
    dc.b      $0c,$8c,$4c,$cc,$2c,$ac,$6c,$ec,$1c,$9c,$5c,$dc,$3c,$bc,$7c,$fc
    dc.b      $02,$82,$42,$c2,$22,$a2,$62,$e2,$12,$92,$52,$d2,$32,$b2,$72,$f2
    dc.b      $0a,$8a,$4a,$ca,$2a,$aa,$6a,$ea,$1a,$9a,$5a,$da,$3a,$ba,$7a,$fa
    dc.b      $06,$86,$46,$c6,$26,$a6,$66,$e6,$16,$96,$56,$d6,$36,$b6,$76,$f6
    dc.b      $0e,$8e,$4e,$ce,$2e,$ae,$6e,$ee,$1e,$9e,$5e,$de,$3e,$be,$7e,$fe
    dc.b      $01,$81,$41,$c1,$21,$a1,$61,$e1,$11,$91,$51,$d1,$31,$b1,$71,$f1
    dc.b      $09,$89,$49,$c9,$29,$a9,$69,$e9,$19,$99,$59,$d9,$39,$b9,$79,$f9
    dc.b      $05,$85,$45,$c5,$25,$a5,$65,$e5,$15,$95,$55,$d5,$35,$b5,$75,$f5
    dc.b      $0d,$8d,$4d,$cd,$2d,$ad,$6d,$ed,$1d,$9d,$5d,$dd,$3d,$bd,$7d,$fd
    dc.b      $03,$83,$43,$c3,$23,$a3,$63,$e3,$13,$93,$53,$d3,$33,$b3,$73,$f3
    dc.b      $0b,$8b,$4b,$cb,$2b,$ab,$6b,$eb,$1b,$9b,$5b,$db,$3b,$bb,$7b,$fb
    dc.b      $07,$87,$47,$c7,$27,$a7,$67,$e7,$17,$97,$57,$d7,$37,$b7,$77,$f7
    dc.b      $0f,$8f,$4f,$cf,$2f,$af,$6f,$ef,$1f,$9f,$5f,$df,$3f,$bf,$7f,$ff


;
; Sets FPCC based on double value on \1/\2. Function will modify values and 
; will not restore them so be aware (call this as last step). 
;
; TODO: I and NAN flags (how to get these from math libs?)
; NAN: sign = either 0 or 1.
;      biased exponent = all 1 bits.   
;      fraction = anything except all 0 bits (since all 0 bits represents infinity).
; I: sign = 0 for positive infinity, 1 for negative infinity.
;    biased exponent = all 1 bits.
;    fraction = all 0 bits.
; 
; INPUTS
;	\1/\2 -- Double.
; 
SETCC macro

	; Clear all flags
	clr.b		RegFpsrCc
	
	; Clear sign and set N flag
	bclr.l		#31,\1
	beq.s		.NoN
	ori.b		#CCN,RegFpsrCc
	.NoN:
	
	; Check and set Z flag
	tst.l		\1
	bne.s		.NoZ
	tst.l		\2
	bne.s		.NoZ
	ori.b		#CCZ,RegFpsrCc
	bra.s		.FlagsOk
	.NoZ:
	
	; Check NaN and I flags
	cmp.l		#$7ff00000,\1
	bmi.s		.FlagsOk
	
	; Check and set I flag
	bne.s		.IsNan
	tst.l		\2
	bne.s		.IsNan
	ifnd		NOCCINF
		ori.b		#CCI,RegFpsrCc
	endif
	bra.s		.FlagsOk
	
	; Check and set NaN flag
	.IsNan:
	ifnd		NOCCNAN
		ori.b		#CCNAN,RegFpsrCc
	endif
	
	; Done
	.FlagsOk:
	
endm
