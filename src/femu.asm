; 
; femu - A FPU emulator for classic Amigas
;
; For UAE debugger:
;   w 0 $100 1 W
;   clr.w $100
;
; Author: Jari Eskelinen <jari.eskelinen@iki.fi>
;
    jmp         FemuMain
    include		"utils/constants.asm"
	include		"utils/debug.asm"
	include		"utils/double.asm"
	include		"utils/macros.asm"
	include		"utils/fhandler.asm"
	include		"utils/fpu.asm"
	include		"utils/op.asm"
	include		"utils/ea.asm"
	include		"utils/math64.asm"
	include		"utils/type.asm"
	include		"ops/fabs.asm"
	include		"ops/facos.asm"
	include		"ops/fadd.asm"
	include		"ops/fasin.asm"
	include		"ops/fatan.asm"
	include		"ops/fbcc.asm"
	include		"ops/fgetexp.asm"
	include		"ops/fgetman.asm"
	include		"ops/fscc.asm"
	include		"ops/fcmp.asm"
	include		"ops/fcos.asm"
	include		"ops/fcosh.asm"
	include		"ops/fdbcc.asm"
	include		"ops/fdiv.asm"
	include		"ops/fetox.asm"
	include		"ops/fint.asm"
	include		"ops/fintrz.asm"
	include		"ops/flogn.asm"
	include		"ops/flog2.asm"
	include		"ops/flog10.asm"
	include		"ops/fmove.asm"
	include		"ops/fmovefpcr.asm"
	include		"ops/fmovecr.asm"
	include		"ops/fmovem.asm"
	include		"ops/fmul.asm"
	include		"ops/fneg.asm"
	include		"ops/frestore.asm"
	include		"ops/fsave.asm"
	include		"ops/fscale.asm"
	include		"ops/fsin.asm"
	include		"ops/fsincos.asm"
	include		"ops/fsinh.asm"
	include		"ops/fsub.asm"
	include		"ops/fsqrt.asm"
	include		"ops/ftentox.asm"
	include		"ops/ftan.asm"
	include		"ops/ftanh.asm"
	include		"ops/ftst.asm"
	include		"ops/ftwotox.asm"
	include		"ops/unsupported.asm"
	DOSBase:				dc.l	0
	MathIeeeDoubBasBase:	dc.l	0
	MathIeeeDoubTransBase:	dc.l	0
	AttnFlags:				dc.w	0
	ExceptionVector:		dc.l	0
	
	
;
; Main.
;
FemuMain

	; Initialize
	jsr			FemuInit
	tst.l		d0
	bne.s		.Error
	
	; Wait for a break signal
	move.l		_AbsExecBase,a6
	move.l		#SIGBREAKF,d0
	jsr			_LVOWait(a6)

	; Successful exit
	jsr			FemuExit
	move.l		#0,d0
	rts

	; Unsuccessful exit
	.Error:
	jsr			FemuExit
	move.l		#30,d0
	rts
	
	
;
; Initializes femu. 
;
FemuInit

	; Open the dos.library
	OPENLIB 	DOSName,36,DOSBase,.LibError
	
	; Open the mathieeedoubbas.library
	OPENLIB 	MathIeeeDoubBasName,45,MathIeeeDoubBasBase,.LibError
	
	; Open the mathieeedoubtrans.library
	OPENLIB 	MathIeeeDoubTransName,45,MathIeeeDoubTransBase,.LibError
	
	; Get and modify AttnFlags to indicate a FPU presence
	movea.l		_AbsExecBase,a6
	move.w		_LVOAttnFlags(a6),d0
	move.w		d0,AttnFlags
	ori.w		#$70,d0
	move.w		d0,_LVOAttnFlags(a6)
	
	; Get and modify the exception vector 
	jsr			GetVbrBase
	move.l		$2c(a0),ExceptionVector
	lea.l		HandleException(pc),a1
	move.l		a1,$2c(a0)
	
	; Output welcome message
	WRITEOUT	#VERSTRING
		
	; Done
	move.l		#0,d0
	rts
	
	; Opening library failed
	.LibError:
	move.l		#30,d0
	rts
		
	
;
; Cleans up femu - restores the exception vector and 
; AttnFlags and closes all open resources.
;
FemuExit

	; Restore the exception vector
	tst.l		ExceptionVector
	beq.s		.ExceptionVectorOk
	move.w		AttnFlags,d0
	jsr			GetVbrBase
	move.l		ExceptionVector,$2c(a0)
	.ExceptionVectorOk:
	
	; Restore AttnFlags
	tst.l		AttnFlags
	beq.s		.AttnFlagsOk
	movea.l		_AbsExecBase,a6
	move.w		AttnFlags,_LVOAttnFlags(a6)
	.AttnFlagsOk:

	; Close the mathieeedoubtrans.library
	CLOSELIB	MathIeeeDoubTransBase
	
	; Close the mathieeedoubbas.library
	CLOSELIB	MathIeeeDoubBasBase

	; Close the dos.library
	CLOSELIB	DOSBase
	
	; Done
	rts
	

;
; Gets the VBR base address.
;
; INPUTS
;	d0 -- AttnFlags
;
; RESULT
;	a0 -- The VBR base address.
;	
GetVbrBase
	movem.l		a5/a6,-(sp)
	movea.l		_AbsExecBase,a6
	lea.l		.GetVbrRegister(pc),a5
	jsr			_LVOSupervisor(a6)
	movem.l		(sp)+,a5/a6
	rts
	.GetVbrRegister:
	movec		vbr,a0
	rte


;
; Pre-exception registers. We write everything to memory before the instruction 
; is emulated and restore registers just before returning from exception. 
; Please notice that these are on the bottom on purpose for avoiding cache 
; problems.
;
			cnop	64,4
RegDn		dc.l	0,0,0,0,0,0,0,0
RegAn		dc.l	0,0,0,0,0,0,0
RegSp		dc.l	0
