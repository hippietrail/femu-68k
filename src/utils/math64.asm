;
; Performs 64x64=64 unsigned multiply.
; 
; INPUTS
;	\1 -- High bits.
;	\2 -- Low bits.
;	\3 -- High bits.
;	\4 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
; TODO: WIP
;
MULU64 macro

; d0=low 32 bits of num1
; d1=high 32 bits of num1
; d2=low 32 bits of num2
; d3=high 32 bits of num2
   move.l \2,d4 ;d4 = high 32 bits of num1
   mulu.l \1,\4 ;\4 = low 32 bits of num1 x high 32 bits of num2 
   mulu.l \3,d4 ;d4 = low 32 bits of num2 x high 32 bits of num1 
   mulu.l \3,\2:\1 ;\2:\1 = low 32 bits of num2 x low 32 bits of num1
   add.l \4,\2 ;add partial sums
   add.l d4,\2 ;add partial sums
; \1=low 32 bits of the result
; d1=high 32 bits of the result	


	; TODO: wip
	; todo: d0/d1 -> d0

endm











;
; Performs 64 bit add.
; 
; INPUTS
;	\1 -- High bits.
;	\2 -- Low bits.
;	\3 -- High bits.
;	\4 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
ADD64 macro
	add.l			\2,\4
	addx.l			\1,\3
endm


;
; Performs 64 bit sub.
; 
; INPUTS
;	\1 -- High bits.
;	\2 -- Low bits.
;	\3 -- High bits.
;	\4 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
SUB64 macro
	sub.l			\2,\4
	subx.l			\1,\3
endm


;
; Performs 64 bit neg.
; 
; INPUTS
;	\1 -- High bits.
;	\2 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
NEG64 macro
	neg.l			\2
	negx.l			\1
endm


;
; Performs 64 bit abs.
; 
; INPUTS
;	\1 -- High bits.
;	\2 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
ABS64 macro

	;TODO: d6 stuff is WIP!
	moveq			 #0,d6
	
	btst			#31,\1
	beq.s			.\@Ok
	NEG64			\1,\2
	
	moveq			 #1,d6
	
	.\@Ok:
endm


;
; Performs 64 bit lsl. 
; 
; INPUTS
;	\1 -- Shift bits	.
;	\2 -- High bits.
;	\3 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
LSL64 macro

	cmp.b		#32,\1
	blt.s		.\@ShiftLess
	
	.\@ShiftMore:
	move.l		\3,\2
	move.l		#0,\3
	subi.l		#32,\1
	lsl.l		\1,\2
	addi.l		#32,\1
	bra.s		.\@ShiftOk
	
	.\@ShiftLess:
	LSL64L		\1,\2,\3
	
	.\@ShiftOk:

endm


;
; Performs 64 bit lsl. 
; Shifts 32 bits at max. 
; 
; INPUTS
;	\1 -- Shift bits	.
;	\2 -- High bits.
;	\3 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
LSL64L macro
	rol.l		\1,\3
	bfins		\3,\2{0:\1}
	rol.l		\1,\2
	lsr.l		\1,\3
	lsl.l		\1,\3
endm


;
; Performs 64 bit lsr. 
; 
; INPUTS
;	\1 -- Shift bits	.
;	\2 -- High bits.
;	\3 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
LSR64 macro

	cmp.b		#32,\1
	blt.s		.\@ShiftLess
	
	.\@ShiftMore:
	move.l		\2,\3
	move.l		#0,\2
	subi.l		#32,\1
	lsr.l		\1,\3
	addi.l		#32,\1
	bra.s		.\@ShiftOk
	
	.\@ShiftLess:
	LSR64L		\1,\2,\3
	
	.\@ShiftOk:

endm


;
; Performs 64 bit lsr. 
; Shifts 32 bits at max.
; 
; INPUTS
;	\1 -- Shift bits	.
;	\2 -- High bits.
;	\3 -- Low bits.
;
; RESULT
;	\1 -- High bits.
;	\2 -- Low bits.
;
LSR64L macro
	lsr.l		\1,\3
	bfins		\2,\3{0:\1}
	lsr.l		\1,\2
endm
