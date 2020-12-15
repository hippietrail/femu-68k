	jmp						Ftest
	include					"utils/constants.asm"
	include					"utils/fpu.asm"
	include					"utils/math64.asm"
	include					"utils/macros.asm"
	DOSBase:				dc.l	0
	MathIeeeDoubBasBase:	dc.l	0
	MathIeeeDoubTransBase:	dc.l	0
	rts

	
;
; Random tests, nothing important here...
;
Ftest

	clr.w $100
	fabs.x		fp0
	rts
	
	move.l		#0,-(a7)
	trap  		#1
    rts
	
	
	.d:			dc.l 0,0,0,0,0,0
	

    .pok:
	nop
    rts

    fmove.d #3.14,fp0
    fmove.d #2.14,fp1
    fmove.d #1.14,fp2
    fmovem.x fp0-fp2,.zappa
    fmovem.x .zappa,fp0-fp2
    clr.w $100
    fmove.l  fp0,d0
    fmove.l  fp1,d1
    fmove.l  fp2,d2
    
    
    
    rts

    .zappa: dc.l    $ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff,$ffffffff
    
    
    


	
	movec		vbr,d3
	
	rts

	clr.l		d0
	clr.l		d1
	
	; Calculate 1024 byte aligned address
	move.l		#0,d0
	move.l		#DirectOpVectorsX,d1
	divul.l		#1024,d0:d1
	neg.l		d0
	add.l		#1024,d0
	add.l		#DirectOpVectorsX,d0
	
	; Move 512 byte vectors to aligned address
	move.l		#DirectOpVectorsX,a0
	move.l		d0,a1
	move.l		#511,d0
	.Move:
	move.l		(a0,d0.w),(a1,d0.w)
	dbf			d0,.Move
	
	clr.w $100
	rts
	
	
	dcb.b 1536

	
;
;
;	
DirectOpVectorsX
	dc.l		1	; 0000000 fmove
	dc.l		0	; 0000001 fint
	dc.l		0	; 0000010 fsinh
	dc.l		0	; 0000011 fintrz
	dc.l		0	; 0000100 fsqrt
	dc.l		0	; 0000101
	dc.l		0	; 0000110
	dc.l		0	; 0000111
	dc.l		0	; 0001000
	dc.l		0	; 0001001 ftanh
	dc.l		0	; 0001010 fatan
	dc.l		0	; 0001011
	dc.l		0	; 0001100 fasin
	dc.l		0	; 0001101 
	dc.l		0	; 0001110 fsin
	dc.l		0	; 0001111 ftan
	dc.l		0	; 0010000 fetox
	dc.l		0	; 0010001 ftwotox
	dc.l		0	; 0010010 ftentox
	dc.l		0	; 0010011
	dc.l		0	; 0010100 flogn
	dc.l		0	; 0010101 flog10
	dc.l		0	; 0010110 flog2
	dc.l		0	; 0010111
	dc.l		0	; 0011000 fabs
	dc.l		0	; 0011001 fcosh
	dc.l		0	; 0011010 fneg
	dc.l		0	; 0011011
	dc.l		0	; 0011100 facos
	dc.l		0	; 0011101 fcos
	dc.l		0	; 0011110 fgetexp
	dc.l		0	; 0011111 fgetman
	dc.l		0	; 0100000 fdiv
	dc.l		0	; 0100001
	dc.l		0	; 0100010 fadd
	dc.l		0	; 0100011 fmul
	dc.l		0	; 0100100 fsgldiv
	dc.l		0	; 0100101
	dc.l		0	; 0100110 fscale
	dc.l		0	; 0100111 fsglmul
	dc.l		0	; 0101000 fsub
	dc.l		0	; 0101001
	dc.l		0	; 0101010
	dc.l		0	; 0101011
	dc.l		0	; 0101100
	dc.l		0	; 0101101
	dc.l		0	; 0101110
	dc.l		0	; 0101111
	dc.l		0	; 0110000 fsincos
	dc.l		0	; 0110001 fsincos
	dc.l		0	; 0110010 fsincos
	dc.l		0	; 0110011 fsincos
	dc.l		0	; 0110100 fsincos
	dc.l		0	; 0110101 fsincos
	dc.l		0	; 0110110 fsincos
	dc.l		0	; 0110111 fsincos
	dc.l		0	; 0111000 fcmp
	dc.l		0	; 0111001
	dc.l		0	; 0111010 ftst
	dc.l		0	; 0111011
	dc.l		0	; 0111100
	dc.l		0	; 0111101
	dc.l		0	; 0111110
	dc.l		0	; 0111111
	dc.l		0	; 1000000 fsmove	
	dc.l		0	; 1000001 fssqrt
	dc.l		0	; 1000010
	dc.l		0	; 1000011
	dc.l		0	; 1000100 fdmove
	dc.l		0	; 1000101 fdsqrt
	dc.l		0	; 1000110
	dc.l		0	; 1000111
	dc.l		0	; 1001000
	dc.l		0	; 1001001
	dc.l		0	; 1001010
	dc.l		0	; 1001011
	dc.l		0	; 1001100
	dc.l		0	; 1001101
	dc.l		0	; 1001110
	dc.l		0	; 1001111
	dc.l		0	; 1010000
	dc.l		0	; 1010001
	dc.l		0	; 1010010
	dc.l		0	; 1010011
	dc.l		0	; 1010100
	dc.l		0	; 1010101
	dc.l		0	; 1010110
	dc.l		0	; 1010111
	dc.l		0	; 1011000 fsabs
	dc.l		0	; 1011001
	dc.l		0	; 1011010 fsneg 
	dc.l		0	; 1011011
	dc.l		0	; 1011100 fdabs
	dc.l		0	; 1011101
	dc.l		0	; 1011110 fdneg
	dc.l		0	; 1011111
	dc.l		0	; 1100000 fsdiv
	dc.l		0	; 1100001
	dc.l		0	; 1100010 fsadd
	dc.l		0	; 1100011 fsmul
	dc.l		0	; 1100100 fddiv
	dc.l		0	; 1100101
	dc.l		0	; 1100110 fdadd
	dc.l		0	; 1100111 fdmul
	dc.l		0	; 1101000 fssub
	dc.l		0	; 1101001
	dc.l		0	; 1101010
	dc.l		0	; 1101011
	dc.l		0	; 1101100 fdsub
	dc.l		0	; 1101101
	dc.l		0	; 1101110
	dc.l		0	; 1101111
	dc.l		0	; 1110000
	dc.l		0	; 1110001
	dc.l		0	; 1110010
	dc.l		0	; 1110011
	dc.l		0	; 1110100
	dc.l		0	; 1110101
	dc.l		0	; 1110110
	dc.l		0	; 1110111
	dc.l		0	; 1111000
	dc.l		0	; 1111001
	dc.l		0	; 1111010
	dc.l		0	; 1111011
	dc.l		0	; 1111100
	dc.l		0	; 1111101
	dc.l		0	; 1111110
	dc.l		2	; 1111111
	
	
	
	
	
	


	move.l #$ffffffff,d0 
	move.l #$00000000,d1
	move.l #$00003000,d2 
	move.l #$00000000,d3 
	
	clr.w $100
	
	MULU64 d0,d1,d2,d3

	;fmove.x fp1,.za
	
	rts
	.za: dc.l	0,0,0,0,0,0,0,0

	
	
	
	;move.l #$40091EB8,d0 ; 3.14 -> 400 91EB8 51EB851F
	;move.l #$51EB851F,d1
	;move.l #$4001C28F,d2 ; 2.22 -> 400 1C28F 5C28F5C3
	;move.l #$5C28F5C3,d3 ; 5.36 -> 401 570A3 D70A3D71
						 
	;move.l #$40091EB8,d2 ; 3.14  -> 400 91EB8 51EB851F
	;move.l #$51EB851F,d3
	;move.l #$403B07AE,d0 ; 27.03 -> 403 B07AE 147AE148 
	;move.l #$147AE148,d1 ; 30.17 -> 403 E2B85 1EB851EC 
						 
	;move.l #$C0091EB8,d0 ; -3.14 -> C00 91EB8 51EB851F
	;move.l #$51EB851F,d1
	;move.l #$C001C28F,d2 ; -2.22 -> C00 1C28F 5C28F5C3
	;move.l #$5C28F5C3,d3 ; -5.36 -> C01 570A3 D70A3D71
						 
	;move.l #$40091EB8,d2 ; 3.14  -> 400 91EB8 51EB851F
	;move.l #$51EB851F,d3
	;move.l #$3F9BA5E3,d0 ; 0.027 -> 3F9 BA5E3 53F7CED9
	;move.l #$53F7CED9,d1 ; 3.167 -> 400 95604 189374BC 
						 
	;move.l #$40091EB8,d0 ; 3.14  -> 400 91EB8 51EB851F
	;move.l #$51EB851F,d1
	;move.l #$3F9BA5E3,d2 ; 0.027 -> 3F9 BA5E3 53F7CED9
	;move.l #$53F7CED9,d3 ; 3.167 -> 400 95604 189374BC 
						 
	move.l #$40091EB8,d0 ;  3.14 -> 400 91EB8 51EB851F
	move.l #$51EB851F,d1
	move.l #$C001C28F,d2 ; -2.22 -> C00 1C28F 5C28F5C3
	move.l #$5C28F5C3,d3 ;  0.92 -> 3FE D70A3 D70A3D71 
	
	
	
		
	;move.l #$C0091EB8,d0 ; -3.14 -> C0091EB851EB851F
	;move.l #$51EB851F,d1
	;move.l #$C001C28F,d2 ; -2.22 -> C001C28F5C28F5C3
	;move.l #$5C28F5C3,d3 ; -5.36 -> C01570A3D70A3D71 
	
						 
	; TODO: algorithm 
	
	
	; TODO: handle negatives
	; TODO: handle underflows, overflows
	; TODO: handle subnormal numbers
	; TODO: if too great diff, then could just return bigger value
	; TODO: optimize bit shift loops wit lookup table?
	; TODO: do we need to bset #20 at all, probably not, just adjust normalization routine
	; TODO: check what happens if mantissas will be equal
	
	
	
	
	; Backup registers
	movem.l			d2-d7,-(sp)
	
	; Extract exponents
	bfextu			d0{1:11},d4
	bfextu			d2{1:11},d5

	; Extract mantissas 
	bfextu			d0{12:20},d6
	bfextu			d2{12:20},d7
	bset			#20,d6
	bset			#20,d7
	
	; Adjust exponents
	sub.w			d4,d5
	beq.s			.ExpOk
	bmi.s			.ExpNeg
	add.w			d5,d4
	.ExpPos:
	lsr.l			#1,d6
	roxr.l			#1,d1
	subi.w			#1,d5
	bgt.s			.ExpPos
	bra.s			.ExpOk
	.ExpNeg:
	lsr.l			#1,d7
	roxr.l			#1,d3
	addi.w			#1,d5
	bmi.s			.ExpNeg
	.ExpOk:
	
	; Sum mantissas 
	; TODO: 3.14 - 2.22 seems to lose last bits, roxl not working as intended?	
	; TODO: this sign check is a hack, think about better algorithm
	
	;
	move.l			#0,d5
	btst			#31,d0
	beq.s			.SrcPos
	addi.b			#1,d5
	.SrcPos:
	btst			#31,d2
	beq.s			.DstPos
	subi.b			#1,d5
	.DstPos:
	;
	bne.s			.Sub
	.Add:	
	ADD64			d6,d1,d7,d3
	bra.s			.Ok
	.Sub:
	SUB64			d6,d1,d7,d3
	.Ok:
	
	
	; TODO: Check zeroes
	.NoZ:
	
	
	; TODO: at this point, if answer is zero, return ieee double zero
	
	; Normalize mantissa
	.Normalize: 
	bfffo			d6{0:32},d7
	cmp.b			#11,d7
	beq.s			.NormalizeOk
	bgt.s			.NormalizeLeft
	.NormalizeRight:
	lsr.l			#1,d6
	roxr.l			#1,d1
	addi.w			#1,d4
	bra.s			.Normalize
	.NormalizeLeft:
	lsl.l			#1,d6
	roxl.l			#1,d1
	subi.w			#1,d4
	bra.s			.Normalize
	.NormalizeOk:
	
	; Construct double 
	bfins			d6,d0{12:20}
	bfins			d4,d0{1:11}
	
	
	; Restore registers
	movem.l			(sp)+,d2-d7
	
	

	
	; 01234567890123456789012345678901 23456789012345678901234567890123
	; 32109876543210987654321098765432 10987654321098765432109876543210
	; seeeeeeeeeeeffffffffffffffffffff ffffffffffffffffffffffffffffffff
	
	

	rts
	
	
	jsr FtestInit
	
	
	
	
	; dn-fpn-dn ok
	;fmove.d				#3.14,fp0
	;fmove.d				#2.14,fp1
	;fmove.d				fp1,.argv
	
	; fpn-ea-fpn ok
	;fmove.d				#2.14,fp0
	;fmove.d				#3.14,fp1
	;fmovem.x			fp0/fp1,.test
	;fmove.d				#0,fp0
	;fmove.d				#0,fp1
	;fmovem.x			.test,fp0/fp1
	;fmovem.x			fp0/fp1,.argv
	
	; fpn-fpn wip
	fmove.d				#3.14,fp0
	fmove.d				#2,fp1
	fadd.x				fp0,fp1
	fmove.d				fp1,.argv
	
	; test
	;lea.l				.argv,a0
	;move.l				#$01234567,(a0)
	;move.l				#$89abcdef,$04(a0)
	
	
	movea.l				DOSBase,a6
	move.l				#.fpntest,d1
	move.l				#.argv,d2	
	jsr					_LVOVPrintf(a6)
	jmp					.fpntestok
	.fpntest:			dc.b "FPNTEST: %08lx %08lx",10,0
	.argv:				dc.l 0,0,0,0,0,0,0,0,0,0,0,0
	.test:				dc.l 0,0,0,0,0,0,0,0,0,0,0,0
	.fpntestok:
	
	jsr FtestExit
	rts
	
	
	jsr FtestInit
	jsr FtestMathBase
	jsr FtestMathTrans
	jsr FtestCompare
	jsr FtestExit
	rts

	
;
; Comparison operator tests
;
FtestCompare

	movea.l				DOSBase,a6
	move.l				#compare_banner,d1
	move.l				#0,d2	
	jsr					_LVOVPrintf(a6)
	jmp					compare_banner_done
	compare_banner:	dc.b 10,"COMPARE",10,"-------",10,0
	compare_banner_done:
	
	Ftest_fcmp_lt:
	fmove.d			#10.50,fp0
	fmove.d			#10.49,fp1
	move.l			#$08000000,d0
	fmove.x			fp1,fp3
	fcmp.x			fp0,fp3
	fmove.l			fpsr,d1
	lea.l			fcmp_lt_msg,a0
	jsr				FtestCompare_result
	jmp			Ftest_fcmp_lt_done
	fcmp_lt_msg:	dc.b "fcmp",9,0
	Ftest_fcmp_lt_done:	
	
	Ftest_fcmp_eq:
	fmove.d			#11.50,fp0
	fmove.d			#11.50,fp1
	move.l			#$04000000,d0
	fmove.x			fp1,fp3
	fcmp.x			fp0,fp3
	fmove.l			fpsr,d1
	lea.l			fcmp_eq_msg,a0
	jsr				FtestCompare_result
	jmp			Ftest_fcmp_eq_done
	fcmp_eq_msg:	dc.b "fcmp",9,0
	Ftest_fcmp_eq_done:	
	
	Ftest_fcmp_gt:
	fmove.d			#12.40,fp0
	fmove.d			#12.50,fp1
	move.l			#0,d0
	fmove.x			fp1,fp3
	fcmp.x			fp0,fp3
	fmove.l			fpsr,d1
	lea.l			fcmp_gt_msg,a0
	jsr				FtestCompare_result
	jmp			Ftest_fcmp_gt_done
	fcmp_gt_msg:	dc.b "fcmp",9,0
	Ftest_fcmp_gt_done:	
	
	rts
	
;
; Base math tests
;
FtestMathBase

	movea.l				DOSBase,a6
	move.l				#mathbase_banner,d1
	move.l				#0,d2	
	jsr					_LVOVPrintf(a6)
	jmp					mathbase_banner_done
	mathbase_banner:	dc.b 10,"MATH BASE",10,"---------",10,0
	mathbase_banner_done:
	
	Ftest_fabs:
	fmove.d			#-5.5,fp0
	fmove.d			#0,fp1
	fmove.d			#5.5,fp2
	fmove.x			fp1,fp3
	fabs.x			fp0,fp3
	lea.l			fabs_msg,a0
	jsr				Ftest_math_result
	jmp			fabs_done
	fabs_msg:		dc.b "fabs",9,0
	fabs_done:
	
	fmove.d			#-5.5,fp0
	fmove.d			#0,fp1
	fmove.d			#5.5,fp2
	fmove.x			fp1,fp3
	fsabs.x			fp0,fp3
	lea.l			fsabs_msg,a0
	jsr				Ftest_math_result
	jmp			fsabs_done
	fsabs_msg:		dc.b "fsabs",9,0,0
	fsabs_done:
	
	fmove.d			#-5.5,fp0
	fmove.d			#0,fp1
	fmove.d			#5.5,fp2
	fmove.x			fp1,fp3
	fdabs.x			fp0,fp3
	lea.l			fdabs_msg,a0
	jsr				Ftest_math_result
	jmp			fdabs_done
	fdabs_msg:		dc.b "fdabs",9,0,0
	fdabs_done:
	
	fmove.d			#1.1,fp0
	fmove.d			#2.2,fp1
	fmove.d			#3.3,fp2
	fmove.x			fp1,fp3
	fadd.x			fp0,fp3
	lea.l			fadd_msg,a0
	jsr				Ftest_math_result
	jmp			fadd_done
	fadd_msg:		dc.b "fadd",9,0
	fadd_done:
	
	fmove.d			#1.1,fp0
	fmove.d			#2.2,fp1
	fmove.d			#3.3,fp2
	fmove.x			fp1,fp3
	fsadd.x			fp0,fp3
	lea.l			fsadd_msg,a0
	jsr				Ftest_math_result
	jmp			fsadd_done
	fsadd_msg:		dc.b "fsadd",9,0,0
	fsadd_done:
	
	fmove.d			#1.1,fp0
	fmove.d			#2.2,fp1
	fmove.d			#3.3,fp2
	fmove.x			fp1,fp3
	fdadd.x			fp0,fp3
	lea.l			fdadd_msg,a0
	jsr				Ftest_math_result
	jmp			fdadd_done
	fdadd_msg:		dc.b "fdadd",9,0,0
	fdadd_done:
	
	fmove.d			#2.5,fp0
	fmove.d			#25.25,fp1
	fmove.d			#10.1,fp2
	fmove.x			fp1,fp3
	fdiv.x			fp0,fp3
	lea.l			fdiv_msg,a0
	jsr				Ftest_math_result
	jmp			fdiv_done
	fdiv_msg:		dc.b "fdiv",9,0
	fdiv_done:
	
	fmove.d			#2.5,fp0
	fmove.d			#25.25,fp1
	fmove.d			#10.1,fp2
	fmove.x			fp1,fp3
	fsdiv.x			fp0,fp3
	lea.l			fsdiv_msg,a0
	jsr				Ftest_math_result
	jmp			fsdiv_done
	fsdiv_msg:		dc.b "fsdiv",9,0,0
	fsdiv_done:

	fmove.d			#2.5,fp0
	fmove.d			#25.25,fp1
	fmove.d			#10.1,fp2
	fmove.x			fp1,fp3
	fddiv.x			fp0,fp3
	lea.l			fddiv_msg,a0
	jsr				Ftest_math_result
	jmp			fddiv_done
	fddiv_msg:		dc.b "fddiv",9,0,0
	fddiv_done:
	
	fmove.d			#2.5,fp0
	fmove.d			#25.25,fp1
	fmove.d			#10.1,fp2
	fmove.x			fp1,fp3
	fsgldiv.x		fp0,fp3
	lea.l			fsgldiv_msg,a0
	jsr				Ftest_math_result
	jmp			fsgldiv_done
	fsgldiv_msg:	dc.b "fsgldiv",9,0,0	
	fsgldiv_done:
	
	fmove.d			#2.9,fp0
	fmove.d			#0,fp1
	fmove.d			#3,fp2
	fmove.x			fp1,fp3
	fint.x			fp0,fp3
	lea.l			fint_msg,a0
	jsr				Ftest_math_result
	jmp			fint_done
	fint_msg:	dc.b "fint",9,0
	fint_done:

	fmove.d			#2.9,fp0
	fmove.d			#0,fp1
	fmove.d			#2,fp2
	fmove.x			fp1,fp3
	fintrz.x		fp0,fp3
	lea.l			fintrz_msg,a0
	jsr				Ftest_math_result
	jmp			fintrz_done
	fintrz_msg:	dc.b "fintrz",9,0
	fintrz_done:

	fmove.d			#12.1,fp0
	fmove.d			#2.25,fp1
	fmove.d			#27.225,fp2
	fmove.x			fp1,fp3
	fmul.x			fp0,fp3
	lea.l			fmul_msg,a0
	jsr				Ftest_math_result
	jmp			fmul_done
	fmul_msg:		dc.b "fmul",9,0
	fmul_done:
	
	fmove.d			#12.1,fp0
	fmove.d			#2.25,fp1
	fmove.d			#27.225,fp2
	fmove.x			fp1,fp3
	fsmul.x			fp0,fp3
	lea.l			fsmul_msg,a0
	jsr				Ftest_math_result
	jmp			fsmul_done
	fsmul_msg:		dc.b "fsmul",9,0,0
	fsmul_done:
	
	fmove.d			#12.1,fp0
	fmove.d			#2.25,fp1
	fmove.d			#27.225,fp2
	fmove.x			fp1,fp3
	fdmul.x			fp0,fp3
	lea.l			fdmul_msg,a0
	jsr				Ftest_math_result
	jmp			fdmul_done
	fdmul_msg:		dc.b "fdmul",9,0,0
	fdmul_done:
	
	fmove.d			#12.1,fp0
	fmove.d			#0,fp1
	fmove.d			#-12.1,fp2
	fmove.x			fp1,fp3
	fneg.x			fp0,fp3
	lea.l			fneg_msg,a0
	jsr				Ftest_math_result
	jmp			fneg_done
	fneg_msg:		dc.b "fneg",9,0
	fneg_done:
	
	fmove.d			#12.1,fp0
	fmove.d			#0,fp1
	fmove.d			#-12.1,fp2
	fmove.x			fp1,fp3
	fsneg.x			fp0,fp3
	lea.l			fsneg_msg,a0
	jsr				Ftest_math_result
	jmp			fsneg_done
	fsneg_msg:		dc.b "fsneg",9,0,0
	fsneg_done:
	
	fmove.d			#12.1,fp0
	fmove.d			#0,fp1
	fmove.d			#-12.1,fp2
	fmove.x			fp1,fp3
	fdneg.x			fp0,fp3
	lea.l			fdneg_msg,a0
	jsr				Ftest_math_result
	jmp			fdneg_done
	fdneg_msg:		dc.b "fdneg",9,0,0
	fdneg_done:
	
	fmove.d			#120.1,fp0
	fmove.d			#50.2,fp1
	fmove.d			#-69.9,fp2
	fmove.x			fp1,fp3
	fsub.x			fp0,fp3
	lea.l			fsub_msg,a0
	jsr				Ftest_math_result
	jmp			fsub_done
	fsub_msg:		dc.b "fsub",9,0
	fsub_done:
	
	fmove.d			#120.1,fp0
	fmove.d			#50.2,fp1
	fmove.d			#-69.9,fp2
	fmove.x			fp1,fp3
	fssub.x			fp0,fp3
	lea.l			fssub_msg,a0
	jsr				Ftest_math_result
	jmp			fssub_done
	fssub_msg:		dc.b "fssub",9,0,0
	fssub_done:
	
	fmove.d			#120.1,fp0
	fmove.d			#50.2,fp1
	fmove.d			#-69.9,fp2
	fmove.x			fp1,fp3
	fdsub.x			fp0,fp3
	lea.l			fdsub_msg,a0
	jsr				Ftest_math_result
	jmp			fdsub_done
	fdsub_msg:		dc.b "fdsub",9,0,0	
	fdsub_done:
	
	rts


;
; Transcendental math tests 
;
FtestMathTrans

	movea.l				DOSBase,a6
	move.l				#mathtrans_banner,d1
	move.l				#0,d2	
	jsr					_LVOVPrintf(a6)
	jmp					mathtrans_banner_done
	mathtrans_banner:	dc.b 10,"MATH TRANS",10,"---------",10,0,0
	mathtrans_banner_done:
	
	fmove.d			#0.72,fp0
	fmove.d			#0,fp1
	fmove.d			#0.7669940078618667,fp2 
	fmove.x			fp1,fp3
	facos.x			fp0,fp3
	lea.l			facos_msg,a0
	jsr				Ftest_math_result
	jmp			facos_done
	facos_msg:		dc.b "facos",9,0,0
	facos_done:
		
	fmove.d			#0.71,fp0
	fmove.d			#0,fp1
	fmove.d			#0.7894982093461719,fp2 
	fmove.x			fp1,fp3
	fasin.x			fp0,fp3
	lea.l			fasin_msg,a0
	jsr				Ftest_math_result
	jmp			fasin_done
	fasin_msg:		dc.b "fasin",9,0,0
	fasin_done:
	
	fmove.d			#2.25,fp0
	fmove.d			#0,fp1
	fmove.d			#1.1525719972156676,fp2 
	fmove.x			fp1,fp3
	fatan.x			fp0,fp3
	lea.l			fatan_msg,a0
	jsr				Ftest_math_result
	jmp			fatan_done
	fatan_msg:		dc.b "fatan",9,0,0
	fatan_done:
	
	fmove.d			#0.75,fp0
	fmove.d			#0,fp1
	fmove.d			#0.7316888688738209,fp2 
	fmove.x			fp1,fp3
	fcos.x			fp0,fp3
	lea.l			fcos_msg,a0
	jsr				Ftest_math_result
	jmp			fcos_done
	fcos_msg:		dc.b "fcos",9,0
	fcos_done:
	
	fmove.d			#9.43,fp0
	fmove.d			#0,fp1
	fmove.d			#6228.263405943807,fp2 
	fmove.x			fp1,fp3
	fcosh.x			fp0,fp3
	lea.l			fcosh_msg,a0
	jsr				Ftest_math_result
	jmp			fcosh_done
	fcosh_msg:		dc.b "fcosh",9,0,0
	fcosh_done:
	
	fmove.d			#3.66,fp0
	fmove.d			#0,fp1
	fmove.d			#38.8613428713,fp2
	fmove.x			fp1,fp3
	fetox.x			fp0,fp3
	lea.l			fetox_msg,a0
	jsr				Ftest_math_result
	jmp			fetox_done
	fetox_msg:		dc.b "fetox",9,0,0
	fetox_done:
	
	fmove.d			#5.12,fp0
	fmove.d			#0,fp1
	fmove.d			#131825.673856,fp2
	fmove.x			fp1,fp3
	ftentox.x		fp0,fp3
	lea.l			ftentox_msg,a0
	jsr				Ftest_math_result
	jmp			ftentox_done
	ftentox_msg:	dc.b "ftentox",9,0,0
	ftentox_done:
	
	fmove.d			#12.5,fp0
	fmove.d			#0,fp1
	fmove.d			#5792.618751480198,fp2
	fmove.x			fp1,fp3
	ftwotox.x		fp0,fp3
	lea.l			ftwotox_msg,a0
	jsr				Ftest_math_result
	jmp			ftwotox_done
	ftwotox_msg:	dc.b "ftwotox",9,0,0
	ftwotox_done:
	
	fmove.d			#7.25,fp0
	fmove.d			#0,fp1
	fmove.d			#2.8579809951275723,fp2
	fmove.x			fp1,fp3
	flog2.x			fp0,fp3
	lea.l			flog2_msg,a0
	jsr				Ftest_math_result
	jmp			flog2_done
	flog2_msg:		dc.b "flog2",9,0,0
	flog2_done:

	fmove.d			#7.25,fp0
	fmove.d			#0,fp1
	fmove.d			#0.8603380065709937,fp2
	fmove.x			fp1,fp3
	flog10.x		fp0,fp3
	lea.l			flog10_msg,a0
	jsr				Ftest_math_result
	jmp			flog10_done
	flog10_msg:	dc.b "flog10",9,0
	flog10_done:

	fmove.d			#7.25,fp0
	fmove.d			#0,fp1
	fmove.d			#1.9810014688665833,fp2
	fmove.x			fp1,fp3
	flogn.x			fp0,fp3
	lea.l			flogn_msg,a0
	jsr				Ftest_math_result
	jmp			flogn_done
	flogn_msg:		dc.b "flogn",9,0,0
	flogn_done:
	
	fmove.d			#0.25,fp0
	fmove.d			#0,fp1
	fmove.d			#0.24740395925452294,fp2
	fmove.x			fp1,fp3
	fsin.x			fp0,fp3
	lea.l			fsin_msg,a0
	jsr				Ftest_math_result
	jmp			fsin_done
	fsin_msg:		dc.b "fsin",9,0
	fsin_done:
	
	fmove.d			#8.62,fp0
	fmove.d			#0,fp1
	fmove.d			#2770.6931066087172,fp2
	fmove.x			fp1,fp3
	fsinh.x			fp0,fp3
	lea.l			fsinh_msg,a0
	jsr				Ftest_math_result
	jmp			fsinh_done
	fsinh_msg:		dc.b "fsinh",9,0,0
	fsinh_done:
	
	fmove.d			#4.25,fp0
	fmove.d			#0,fp1
	fmove.d			#2.0615528128088303,fp2
	fmove.x			fp1,fp3
	fsqrt.x			fp0,fp3
	lea.l			fsqrt_msg,a0
	jsr				Ftest_math_result
	jmp			fsqrt_done
	fsqrt_msg:		dc.b "fsqrt",9,0,0
	fsqrt_done:
	
	fmove.d			#4.25,fp0
	fmove.d			#0,fp1
	fmove.d			#2.0615528128088303,fp2
	fmove.x			fp1,fp3
	fssqrt.x		fp0,fp3
	lea.l			fssqrt_msg,a0
	jsr				Ftest_math_result
	jmp			fssqrt_done
	fssqrt_msg:	dc.b "fssqrt",9,0
	fssqrt_done:
	
	fmove.d			#4.25,fp0
	fmove.d			#0,fp1
	fmove.d			#2.0615528128088303,fp2
	fmove.x			fp1,fp3
	fdsqrt.x		fp0,fp3
	lea.l			fdsqrt_msg,a0
	jsr				Ftest_math_result
	jmp			fdsqrt
	fdsqrt_msg:	dc.b "fdsqrt",9,0
	fdsqrt:
	
	fmove.d			#3.91,fp0
	fmove.d			#0,fp1
	fmove.d			#0.9665829335238821,fp2
	fmove.x			fp1,fp3
	ftan.x			fp0,fp3
	lea.l			ftan_msg,a0
	jsr				Ftest_math_result
	jmp			ftan_done
	ftan_msg:		dc.b "ftan",9,0
	ftan_done:
	
	fmove.d			#6.11,fp0
	fmove.d			#0,fp1
	fmove.d			#0.9999901383568018,fp2
	fmove.x			fp1,fp3
	ftanh.x			fp0,fp3
	lea.l			ftanh_msg,a0
	jsr				Ftest_math_result
	jmp			ftanh_done
	ftanh_msg:		dc.b "ftanh",9,0,0
	ftanh_done:
	
	rts
	
	
;
; 
;
FtestInit
	movea.l		_AbsExecBase,a6
	lea.l		DOSName,a1 
	move.l		#$24,d0
	jsr			_LVOOpenLibrary(a6)
    move.l		d0,DOSBase
	rts

	
;
; 
;
FtestExit
	movea.l		_AbsExecBase,a6
	movea.l		DOSBase,a1
	jsr			_LVOCloseLibrary(a6)
	rts
	
	
;
; Outputs result of compare test case.
;
; INPUTS
;	a0 -- Name of the operation
;	fp0 -- Left operand value
;	fp1 -- Right operand value
;	d0 -- Expected status register 
;	d1 -- Result status register
;	
FtestCompare_result	

	; Populate argv 
	move.l		a0,FtestCompare_argv_op
	lea.l		FtestCompare_argv_operands,a0
	fmove.d		fp0,(a0)
	fmove.d		fp1,$08(a0)
	move.l		d0,$10(a0)
	move.l		d1,$14(a0)
	
	; Check result 
	cmp.l		d0,d1
	beq		FtestCompare_result_ok
	move.l		#FtestCompare_msg_fail,FtestCompare_argv_status
	bra.s		FtestCompare_result_done
	FtestCompare_result_ok:
	move.l		#FtestCompare_msg_ok,FtestCompare_argv_status
	FtestCompare_result_done:	

	; Output results
	movea.l		DOSBase,a6
	move.l		#FtestCompare_msg_fmt,d1
	move.l		#FtestCompare_argv_op,d2	
	jsr			_LVOVPrintf(a6)
	rts
	
	; Argv 
	FtestCompare_msg_ok:			dc.b	"OK",0
	FtestCompare_msg_fail:			dc.b	"FAIL",0
	FtestCompare_msg_fmt:			dc.b	"%s %08lx%08lx %08lx%08lx %08lx %08lx %s",10,0,0
	FtestCompare_argv_op:			dc.l	0
	FtestCompare_argv_operands:		dc.l	0,0,0,0,0,0
	FtestCompare_argv_status:		dc.l	0

	
;
; Outputs result of math test case.
;
; INPUTS
;	a0 -- Name of the operation
;	fp0 -- Source operand value
;	fp1 -- Destination operand value
;	fp2 -- Expected result
;	fp3 -- Result
;	
Ftest_math_result	

	; Convert expected result and result to single and back to 
	; in order double to get rid of rounding errors
	fmove.s	fp2,__fp2
	fmove.s	__fp2,fp2
	fmove.s	fp3,__fp3
	fmove.s	__fp3,fp3
	
	; Populate argv 
	move.l		a0,Ftest_math_argv_op
	lea.l		Ftest_math_argv_operands,a0
	fmove.d		fp0,(a0)
	fmove.d		fp1,$08(a0)
	fmove.d		fp3,$10(a0)
	fmove.d		fp2,$18(a0)

	; Check result 
	fcmp.x		fp2,fp3
	fbeq		Ftest_math_result_ok
	move.l		#Ftest_math_msg_fail,Ftest_math_argv_status
	bra.s		Ftest_math_result_done
	Ftest_math_result_ok:
	move.l		#Ftest_math_msg_ok,Ftest_math_argv_status
	Ftest_math_result_done:
	
	; Output results
	movea.l		DOSBase,a6
	move.l		#Ftest_math_msg_fmt,d1
	move.l		#Ftest_math_argv_op,d2	
	jsr			_LVOVPrintf(a6)
	rts
	
	; Argv 
	Ftest_math_msg_ok:			dc.b	"OK",0
	Ftest_math_msg_fail:		dc.b	"FAIL",0
	Ftest_math_msg_fmt:			dc.b	"%s %08lx%08lx %08lx%08lx %08lx%08lx %08lx%08lx %s",10,0,0
	Ftest_math_argv_op:			dc.l	0
	Ftest_math_argv_operands:	dc.l	0,0,0,0,0,0,0,0
	Ftest_math_argv_status:		dc.l	0
	
	; WIP
	__fp2:	dc.l	0,0,0,0
	__fp3:	dc.l	0,0,0,0

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
; TODO:
	move.l		#4,d6
	lea.l		indirect,a6

	move.l			(a6,d6.l*1),d0
	fmove.l			(a6,d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			(d6.l*1),d0
	fmove.l			(d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			($22,a6,d6.l*1),d0
	fmove.l			($22,a6,d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			($22,d6.l*1),d0
	fmove.l			($22,d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			($10000,a6,d6.l*1),d0
	fmove.l			($10000,a6,d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			($10000,d6.l*1),d0
	fmove.l			($10000,d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			([a6]),d0
	fmove.l			([a6]),fp0
	fmove.l			fp0,d1
	
	move.l			([a6],$22),d0
	fmove.l			([a6],$22),fp0
	fmove.l			fp0,d1
	
	move.l			([a6],$40000000),d0
	fmove.l			([a6],$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6]),d0
	fmove.l			([$04,a6]),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6],$22),d0
	fmove.l			([$04,a6],$22),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6],$40000000),d0
	fmove.l			([$04,a6],$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([a6,d6.l*1]),d0
	fmove.l			([a6,d6.l*1]),fp0
	fmove.l			fp0,d1
	
	move.l			([a6,d6.l*1],$22),d0
	fmove.l			([a6,d6.l*1],$22),fp0
	fmove.l			fp0,d1
	
	move.l			([a6,d6.l*1],$40000000),d0
	fmove.l			([a6,d6.l*1],$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([d6.l*1]),d0
	fmove.l			([d6.l*1]),fp0
	fmove.l			fp0,d1
	
	move.l			([d6.l*1],$22),d0
	fmove.l			([d6.l*1],$22),fp0
	fmove.l			fp0,d1
	
	move.l			([d6.l*1],$40000000),d0
	fmove.l			([d6.l*1],$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6,d6.l*1]),d0
	fmove.l			([$04,a6,d6.l*1]),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6,d6.l*1],$22),d0
	fmove.l			([$04,a6,d6.l*1],$22),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6,d6.l*1],$40000000),d0
	fmove.l			([$04,a6,d6.l*1],$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,d6.l*1]),d0
	fmove.l			([$04,d6.l*1]),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,d6.l*1],$22),d0
	fmove.l			([$04,d6.l*1],$22),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,d6.l*1],$40000000),d0
	fmove.l			([$04,d6.l*1],$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([a6],d6.l*1),d0
	fmove.l			([a6],d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			([a6],d6.l*1,$22),d0
	fmove.l			([a6],d6.l*1,$22),fp0
	fmove.l			fp0,d1
	
	move.l			([a6],d6.l*1,$40000000),d0
	fmove.l			([a6],d6.l*1,$40000000),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6],d6.l*1),d0
	fmove.l			([$04,a6],d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6],d6.l*1,$22),d0
	fmove.l			([$04,a6],d6.l*1,$22),fp0
	fmove.l			fp0,d1
	
	move.l			([$04,a6],d6.l*1,$40000000),d0
	fmove.l			([$04,a6],d6.l*1,$40000000),fp0
	fmove.l			fp0,d1

	move.l			([$04],d6.l*1),d0
	fmove.l			([$04],d6.l*1),fp0
	fmove.l			fp0,d1
	
	move.l			([$04],d6.l*1,$22),d0
	fmove.l			([$04],d6.l*1,$22),fp0
	fmove.l			fp0,d1
	
	move.l			([$04],d6.l*1,$40000000),d0
	fmove.l			([$04],d6.l*1,$40000000),fp0
	fmove.l			fp0,d1
	
	rts
	indirect: dc.l $110 ; contains value 00f8 1908
	indirect2: dc.l $120 ; contains value 00f8 1908
	indirect3: dc.l $130 ; contains value 00f8 1908
	