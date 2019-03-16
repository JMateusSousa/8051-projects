ORG	00H
AJMP	INICIO
ORG	03H
AJMP	EXT_0
ORG	13H
AJMP	EXT_1
ORG	23H
AJMP	SERIAL


;=======================================================
INICIO:			MOV		IE,#95H
			MOV		TMOD,#21H
			SETB		INT0
			SETB		INT1
			SETB		IT0
			SETB		IT1
			MOV		SCON,#50H
			MOV		PCON,#00H
			MOV		TH1,#0FDH
			MOV		TL1,#0FDH
			SETB		TR1
			MOV		SP,#02FH
			MOV		R7,#11H
			MOV		R1,#00H
			MOV		R2,#00H
			MOV		R3,#00H
			MOV		R4,#00H
;==========================================			

DISPLAY:		MOV		DPTR,#TAB
			MOV		P2,R7	;1
			MOV		A,R1
			ACALL		MOSTRA
			ACALL		TIMER
			MOV		A,R7
			RL		A
			MOV		R7,A

			MOV		P2,R7	;2
			MOV		A,R2
			ACALL		MOSTRA
			ACALL		TIMER
			MOV		A,R7
			RL		A
			MOV		R7,A

			MOV		P2,R7	;3
			MOV		A,R3
			ACALL		MOSTRA
			ACALL		TIMER
			MOV		A,R7
			RL		A
			MOV		R7,A

			MOV		P2,R7	;4
			MOV		A,R4
			ACALL		MOSTRA
			ACALL		TIMER
			MOV		A,R7
			RL		A
			MOV		R7,A
			
			AJMP		DISPLAY
		
;====================================================
			
MOSTRA:			MOVC		A,@A+DPTR
			MOV		P0,A
			RET
;=====================================================			
TIMER:			MOV		TH0,#3CH
			MOV		TL0,#0AFH
			SETB		TR0
			JNB		TF0,$
			CLR		TF0
			MOV		TH0,#3CH
			MOV		TL0,#0AFH
			CLR		TR0
			RET
;=====================================================
EXT_0:			INC		R1
			CJNE		R1,#10,OUT_0
			MOV		R1,#0
			INC		R2
			CJNE		R2,#10,OUT_0
			MOV		R2,#0
			INC		R3
			CJNE		R3,#10,OUT_0
			MOV		R3,#0
			INC		R4
			CJNE		R4,#10,OUT_0
			MOV		R4,#0
OUT_0:			ACALL		SERIAL
			RETI
;================================================
EXT_1:		
			CJNE		R1,#0,DEC_R1
			MOV		R1,#9
			AJMP		OUTRO_1
DEC_R1:			DEC		R1
			AJMP		OUT_1

OUTRO_1:		CJNE		R2,#0,DEC_R2
			MOV		R2,#9
			AJMP		OUTRO_2
DEC_R2:			DEC		R2
			AJMP		OUT_1

OUTRO_2:		CJNE		R3,#0,DEC_R3
			MOV		R3,#9
			AJMP		OUTRO_3
DEC_R3:			DEC		R3
			AJMP		OUT_1

OUTRO_3:		CJNE		R4,#0,DEC_R4
			MOV		R4,#9
			AJMP		OUT_1
DEC_R4:			DEC		R4
OUT_1:			RETI
;======================================================
SERIAL:			MOV		DPTR,#TAB_1
			MOV		A,R4
			MOVC		A,@A+DPTR
			ACALL		TX_BYTE
			
			
			MOV		A,R3
			MOVC		A,@A+DPTR
			ACALL		TX_BYTE

		
			MOV		A,R2
			MOVC		A,@A+DPTR
			ACALL		TX_BYTE


			MOV		A,R1
			MOVC		A,@A+DPTR
			ACALL		TX_BYTE
			MOV		A,#0DH
			MOV		SBUF,A
			JNB		TI,$
			CLR		TI
			
			RET
;====================================
TX_BYTE:		MOV		SBUF,A
			JNB		TI,$
			CLR		TI
			RET

;======================================================
TAB:	DB	01H,0CFH,92H,06H,4CH,24H,20H,0FH,00H,04H
TAB_1:	DB	30H,31H,32H,33H,34H,35H,36H,37H,38H,39H
END
