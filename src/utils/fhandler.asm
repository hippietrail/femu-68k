;
; Saves registers to stack. Special handling is necessary for a7 because
; if CPU was in user mode before the exception then a7 must be retrieved
; from usp.
;
; TODO: special handling is not implemented atm, implement it
;
SAVEREGS macro 
	movem.l			d0-d7/a0-a6,RegDn ; dn/an
	dc.w			$4e68             ; move.l usp,a0
	move.l			a0,RegSp          ; a0 is a7 (usp)
endm


;
; Restores registers from stack. Special handling is necessary for a7 
; because if CPU was in user mode before the exception then a7 must be 
; restored to usp.
;
; TODO: special handling is not implemented atm, implement it
;
RESTOREREGS macro 
	movea.l			RegSp,a0          ; a0 is a7 (usp)
	dc.w			$4e60             ; move.l a0,usp
	movem.l			RegDn,d0-d7/a0-a6 ; dn/an
endm


;
; Gets address of the stack frame to STACKFRAME and
; faulting instruction to INSTRUCTION.
;
GETSTACKFRAME macro
	move.l			sp,STACKFRAME
	ifd STACK020
		move.l			$02(STACKFRAME),FAULTPC
	endif
	ifd STACK040 
		move.l			$0c(STACKFRAME),FAULTPC
	endif
	move.l			(FAULTPC),INSTRUCTION
endm


;
; Updates program counter in stack to point to new address.
;
UPDATESTACKFRAME macro 
	ifd STACK020
		move.l		FAULTPC,$02(STACKFRAME)
	endif
endm


;
;
;
PREHANDLEEXCEPTION macro

	; Disable interrupts
	;ori.w		#%0000011100000000,sr
	
	; Save registers
	SAVEREGS	
	
	; Get stack frame 
	GETSTACKFRAME
	
	; Debug instruction
	;WRITEDEBUG	#DEBUGINSTRUCTION,INSTRUCTION
	
endm


;
;
;
POSTHANDLEEXCEPTION macro

	; Update stack frame
	UPDATESTACKFRAME
	
	; Restore registers
	RESTOREREGS
	
	; Return from the exception
	rte
	
endm


;
; Exception handler.
;
HandleException
	PREHANDLEEXCEPTION
	jsr EmulateInstruction
	POSTHANDLEEXCEPTION


;
; Generic unsupported feature function. Will print error message, dump some
; memory for futher analysis and then halt.
;
; INPUTS
;	a0 -- Address to error message.
;
Unsupported

	; Output error message
	movea.l		$02(STACKFRAME),a1
	movea.l		$0c(STACKFRAME),a2
	WRITEOUT	#MSGUNSUPPORTED,a0,(STACKFRAME),$04(STACKFRAME),$08(STACKFRAME),$0c(STACKFRAME),(a1),(a2)

	; Trigger debugger
	clr.w		$100

	; Halt
	stop		#$2700