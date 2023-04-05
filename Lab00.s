; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Esquele de um novo Projeto para Keil
; Prof. Guilherme de S. Peron	- 12/03/2018
; Prof. Marcos E. P. Monteiro	- 12/03/2018
; Prof. DaLuz           		- 25/02/2022

;################################################################################
; Declarações EQU
; <NOME>	EQU <VALOR>
;################################################################################
	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
; Se alguma função do arquivo for chamada em outro arquivo	
    EXPORT Start					; Permite chamar a função Start a partir de 
									; outro arquivo. No caso startup.s
								
; Se chamar alguma função externa	
;	IMPORT <func>          			; Permite chamar dentro deste arquivo uma 
									; função <func>
aleatorio EQU 0x20000400
primos EQU 0x20000500
;################################################################################
; Função main()
Start								;Label Start ... void main(void)
; Comece o código aqui <=========================================================

;Exercicio 01
	MOV R0, #65
	MOV R1, #0x1B001B00
	MOVT R1, #0x1B00
	MOV R2, #0x5678
	MOVT R2, #0x1234
	MOV R3, #0x0040
	MOVT R3, #0x2000
	STR R0, [R3]
	STR R1, [R3, #0x04]
	STR R2, [R3, #0x08]
	MOV R4, #0x1000
	MOVT R4, #0xF000
	STR R4, [R3, #0x0C]
	MOV R5, #0xCD
	STRB R5, [R3, #0x06]
	LDR R7, [R3]
	LDR R8, [R3, #0x08]
	MOV R9, R7
;Exercicio 02
	MOV R1, #0xF0
	ANDS R0, R1, #2_00110011
	MOV R2, #2_11001100
	ANDS R1, R2, #2_00110011
	MOV R3, #2_10000000
	ORRS R2, R3, #2_00110111
	MOV R4, #0xABCD
	MOVT R4, #0xABCD
	MOV R5, #0x0000
	MOVT R5, #0xFFFF
	BICS R3, R4, R5 
;Exercicio 3
	MOV R0, #701
	LSRS R0, #5
	MOV R1, #32067
	NEG R1, R1
	LSRS R1, #4
	MOV R2, #701
	ASRS R2, #3
	MOV R3, #32067
	ASRS R3, #5
	MOV R4, #255
	LSLS R4, #8
	MOV R5, #58982 
	NEG R5, R5
	LSLS R5, #18
	MOV R6, #0x1234
	MOVT R6, #0xFABC
	ROR R6, R6, #10
	MOV R7, #0x1234
	MOVT R7, #0x0000
	RRX R7, R7
	RRX R7, R7
;Exercício 4
	MOV R0, #101
	ADDS R0, R0, #253
	MOV R1, #40543
	ADD R1, R1, #1500
	MOV R2, #340
	SUBS R2, R2, #123
	MOV R3, #1000
	SUBS R3, R3, #2000
	MOV R4, #54378
	MOV R5, #4
	MUL R4, R4, R5	;semelhante a LSL
	MOV R6, #0x3344
	MOVT R6, #0x1122
	MOV R7, #0x2211
	MOVT R7, #0x4433
	UMULL R6, R7, R6, R7 ;049081B5F4A06F84
	MOV R8, #0x7560
	MOVT R8, 0xFFFF
	MOV R9, #1000
	SDIV R8, R8, R9
	UDIV R9, R8, R9	
;Exercicio 5
	MOV R0, #10
	CMP R0, #9
	ITTE HS 
	MOVHS R1, 50
	ADDHS R2, R1, #32
	MOVLO R3, 75
	CMP R0, #11
	ITTE HS 
	MOVHS R1, 50
	ADDHS R2, R1, #32
	MOVLO R3, 75
;Exercicio 6
	MOV R0, #10
	MOV R1, #0xCC22
	MOVT R1, #0xFF11
	MOV R2, #1234
	MOV R3, #0x300
	PUSH{R0}
	PUSH {R1-R3}
	MOV R0, #60
	MOV R2, #0x1234
	POP{R1-R3}
	POP {R0}
;Exercício 7
	MOV R0, #10
	BL loop
	BL func
	B break

loop
	CMP R0, #50
	ADDNE R0, R0, #5
	BNE loop
	BX LR
func
	MOV R1, R0
	CMP R1, #50
	ADDLO R1, R1, #5
	NEGHS R1, R1
	BLO func
	BX LR
break
;Exercicio 8
	MOV R6, #0x0040
	MOVT R6, #0x2000
	MOV R7, #4
	STR R7, [R6]
	LDR R1, [R6]
	MOV R2, #1
	MOV R3, #1
	BL fatorial
	B break
fatorial
	MUL R2, R2, R1
	SUB R1, R1, #1 
	CMP R1, R3
	BNE fatorial
	BX LR
break

; Final do código aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da seção está alinhada 
    END                         	;fim do arquivo