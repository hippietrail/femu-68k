;
; fintrz emulation
;
; TODO: this is inaccurate implementation
;
FintrzHandler

	; Debug instruction
	WRITEDEBUG		#.DEBUGOP,INSTRUCTION

	; Increment PC
	INREMENTPC		#$04

	; Get data
	GETDATALENGTH	d0
	GETEAVALUE		d0,d1
	
	; Emulate instruction
	movea.l			MathIeeeDoubBasBase,a6
	jsr				_LVOIEEEDPFloor(a6)

	; Write results
	GETREGISTER		d5
	MOVEDNTOFPN		d5,d0,d1

	; Set condition codes
	SETCC			d0,d1

	; Done
	rts
	
	; Debug constants
	.DEBUGOP:
	dc.b 			"fintrz %08lx",10,0
	even