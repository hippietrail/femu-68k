;
; Mnemonics for global registers - these registers are reserved 
; for stated purpose  and are used and expected to contain stated 
; values across subroutines. 
;
INSTRUCTION				equr	d7
FAULTPC					equr	a4
STACKFRAME				equr	a5
LIBCALL					equr	a6


;
; Messages and errors.
;
VERSTRING				dc.b	"$VER: femu 0.11-WIP (XX-XXX-XXXX)",10,0
MSGUNSUPPORTED			dc.b	"Error: %s",10,10,"Status: %04x",10,"PC    : %08lx",10,"Vector: %04x",10,"EA    : %08lx",10,"Fault : %08lx",10,10,"PC op   : %08lx",10,"Fault op: %08lx",10,0
ERRUNSUPPORTEDSFRAME	dc.b	"Unsupported state frame!",10,0
ERRUNSUPPORTEDREGLIST	dc.b	"Unsupported register list format!",10,0
ERRUNSUPPORTEDOP		dc.b	"Instruction unsupported!",10,0
ERRUNSUPPORTEDEA		dc.b	"Unsupported addressing mode!",10,0
ERRUNSUPPORTEDFMT		dc.b	"Data format unsupported!",10,0
ERRPACKEDTODOUBLE		dc.b	"Packed to double conversion unsupported!",10,0
ERRDOUBLETOPACKED		dc.b	"Double to packed conversion unsupported!",10,0
ERRMATHBAS				dc.b	"Cannot open mathieeedoubbas.library!",10,0
ERRMATHTRANS			dc.b	"Cannot open mathieeedoubtrans.library!",10,0
DEBUGINSTRUCTION		dc.b	"%08lx",10,0
						even


;
; Constants and vectors for exec.library.
;
_AbsExecBase			equ		$04
_LVOOpenLibrary			equ		-$228
_LVOCloseLibrary		equ		-$19e
_LVOSupervisor			equ		-$1e
_LVOWait				equ		-$13e
_LVODisable				equ		-$78
_LVOEnable				equ		-$7e
_LVOForbid				equ		-$84
_LVOPermit				equ		-$8a
_LVOAttnFlags			equ		$128


;
; Constants and vectors for dos.library.
;
DOSName					dc.b	"dos.library",0
_LVOPutStr				equ		-$3b4
_LVOVPrintf				equ		-$3ba
_LVOFlush				equ		-$168
						even


;
; Constants and vectors for mathieeedoubbas.library.
;
MathIeeeDoubBasName		dc.b	"mathieeedoubbas.library",0
_LVOIEEEDPAbs			equ		-$36
_LVOIEEEDPAdd			equ		-$42
_LVOIEEEDPCeil			equ		-$60
_LVOIEEEDPCmp			equ		-$2a
_LVOIEEEDPDiv			equ		-$54
_LVOIEEEDPFix			equ		-$1e
_LVOIEEEDPFloor			equ		-$5a
_LVOIEEEDPFlt			equ		-$24
_LVOIEEEDPMul			equ		-$4e
_LVOIEEEDPNeg			equ		-$3c
_LVOIEEEDPSub			equ		-$48
_LVOIEEEDPTst			equ		-$30
						even


;
; Constants and vectors for mathieeedoubtrans.library.
;
MathIeeeDoubTransName	dc.b	"mathieeedoubtrans.library",0
_LVOIEEEDPAcos			equ		-$78
_LVOIEEEDPAsin			equ		-$72
_LVOIEEEDPAtan			equ		-$1e
_LVOIEEEDPCos			equ		-$2a
_LVOIEEEDPCosh			equ		-$42
_LVOIEEEDPExp			equ		-$4e
_LVOIEEEDPFieeee		equ		-$6c
_LVOIEEEDPLog			equ		-$54
_LVOIEEEDPLog10			equ		-$7e
_LVOIEEEDPPow			equ		-$5a
_LVOIEEEDPSin			equ		-$24
_LVOIEEEDPSincos		equ		-$36
_LVOIEEEDPSinh			equ		-$3c
_LVOIEEEDPSqrt			equ		-$60	
_LVOIEEEDPTan			equ		-$30
_LVOIEEEDPTanh			equ		-$48
_LVOIEEEDPTieee			equ		-$66
						even


;
; Miscellaneous constants
;
SIGBREAKF				equ		$f000
