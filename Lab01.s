; Laboratório 01.s
; Desenvolvido para a placa EK-TM4C1294XL
; Polianna Beatriz Basso - 2302578
; Pedro Henrique Grossi da Silva - 2237172
; Prof. Paulo DaLuz  - 26/04/2023

;################################################################################
; Declarações EQU
; <NOME>	EQU <VALOR>
aleatorio EQU 0x20000400
primos EQU 0x20000500
;################################################################################
	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
; Se alguma função do arquivo for chamada em outro arquivo	
    EXPORT Start					; Permite chamar a função Start a partir de 
									; outro arquivo. No caso startup.s						
; Se chamar alguma função externa	
;	IMPORT <func>          			; Permite chamar dentro deste arquivo uma 
									; função <func>
;################################################################################
; Função main()
Start								;Label Start ... void main(void)
; Comece o código aqui <=========================================================

	BL grava_mem
	BL loop
    BL bubble_sort
    B break
	
grava_mem
	LDR R10, =aleatorio
    LDR R11, =primos
    MOV R0, #193
	STRB R0, [R10], #1
    MOV R0, #63
	STRB R0, [R10], #1
    MOV R0, #176
	STRB R0, [R10], #1
    MOV R0, #127
	STRB R0, [R10], #1
    MOV R0, #43
	STRB R0, [R10], #1
    MOV R0, #13
	STRB R0, [R10], #1
    MOV R0, #211
	STRB R0, [R10], #1
    MOV R0, #3
	STRB R0, [R10], #1
    MOV R0, #203
	STRB R0, [R10], #1
    MOV R0, #5
	STRB R0, [R10], #1
    MOV R0, #21
	STRB R0, [R10], #1
    MOV R0, #7
	STRB R0, [R10], #1
    MOV R0, #206
	STRB R0, [R10], #1
    MOV R0, #245
	STRB R0, [R10], #1
    MOV R0, #157
	STRB R0, [R10], #1
    MOV R0, #237
	STRB R0, [R10], #1
    MOV R0, #241
	STRB R0, [R10], #1
    MOV R0, #105
	STRB R0, [R10], #1
    MOV R0, #252
	STRB R0, [R10], #1
    MOV R0, #19
	STRB R0, [R10], #1
	LDR R7, =aleatorio
	BX LR

loop
	LDRB R0, [R7], #1
	CMP R0, #1 ;caso seja 1
	BEQ loop
	CMP R0, #2 ; caso seja 2
	STRBEQ R0, [R11], #1
	LSR R1, R0, #1
	ADD R1, R1, #1
	MOV R2, #2 
	PUSH{LR}
	BL primo
	POP{LR}
	CMP R10, R7 
	BNE loop
	LDR R7, =aleatorio
	LDR R9, =primos
	SUB R11, R11, #1
	BX LR

primo
	CMP R1, R2
	ADDNE R2, R2, #1
	UDIV R3, R0, R2
	MLS R4, R2, R3, R0
	CMP R4, #0
	ADDEQ R5, R5, #1 ;SE FOR DIVISIVEL POR OUTRO NUMERO
	CMP R1, R2
	BNE primo
	CMP R5, #0
	STRBEQ R0, [R11], #1
	MOV R5, #0
	BX LR
	
bubble_sort
	LDRB R0, [R9]
	LDRB R1, [R9, #1]
	CMP R1, R0 
	STRBLO R0, [R9, #1] 
	STRBLO R1, [R9]
	ADD R9, R9, #1
	CMP R11, R9
	BNE bubble_sort
	LDR R9, =primos
	SUB R11, R11, #1
	CMP R11, R9
	BNE bubble_sort
	BX LR
	
break

; Final do código aqui <=========================================================
    NOP
    ALIGN                       	;garante que o fim da seção está alinhada 
    END                         	;fim do arquivo
