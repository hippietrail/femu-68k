;
;
;
FMULHANDLER macro

	; Debug instruction
	WRITEDEBUG		#.DEBUGOP,INSTRUCTION

	; Increment PC
	INREMENTPC		#$04

	; Get data
	GETDATALENGTH	d0
	GETEAVALUE		d2,d3
	GETREGISTER		d5
	MOVEFPNTODN		d5,d0,d1
	
	; Emulate instruction
	movea.l			MathIeeeDoubBasBase,a6
	jsr				_LVOIEEEDPMul(a6)

	; Write results
	MOVEDNTOFPN		d5,d0,d1

	; Set condition codes
	SETCC			d0,d1
	
endm


;
; fmul emulation
;
FmulHandler
FsmulHandler
FdmulHandler
FsglmulHandler
	FMULHANDLER
	rts
	.DEBUGOP:
	dc.b 			"fmul %08lx",10,0
	even
