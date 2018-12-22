ORG 		000H
AJMP		INICIO
;=================================	
INICIO:		MOV 	TMOD,#01H
			MOV 	R2,#0FEH

VOLTA: 		MOV 	DPTR,#TABELA
			MOV 	R3,#043			;letras x 5(formato da letra) + espaco + 8
PASS:		MOV		R1,#003			;velocidade de passagem: tempo de delay x r1 x 8
LOOP1:		MOV 	R4,#08H

LOOP:		MOV 	A,R2
			MOV 	P2,A
			RL 		A
			MOV 	R2,A
			MOV 	A,R4
			MOVC 	A,@A+DPTR
			MOV 	P1,A
			ACALL 	DELAY
			DJNZ 	R4,LOOP
			DJNZ	R1,LOOP1
			INC 	DPTR
			DJNZ 	R3,PASS
			SJMP 	VOLTA
;=============================================
DELAY:		MOV 	TH0,#0ECH	;	25hz
			MOV 	TL0,#077H	
			SETB 	TR0

			JNB 	TF0,$
			CLR 	TR0
			CLR 	TF0
			RET
;================================================
TABELA:		DB		0H,0H,0H,0H,0H,0H,0H,0H		;	NOTHING
			DB		0FEH,020H,010H,020H,0FEH,0H	;	M
			DB		0FEH,090H,090H,090H,0FEH,0H	;	A
			DB		080H,080H,0FEH,080H,080H,0H	;	T
			DB		0FEH,092H,092H,092H,092H,0H	;	E
			DB		0FEH,002H,002H,002H,0FEH,0H	;	U
			DB		0F2H,092H,092H,092H,09EH,0H	;	S
;====================================================================
      END
