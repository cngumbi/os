;--------------------------------------------------------------------
;create a functions to enables us to print
;-------------------------------------------------------------------
;-------------------------------------------------------------------
;------create a function to print the data--------------------------
;------push files/register in stack(pfis)---------------------------
pfis:
	pusha

;----the comparision for the string n charactors---------------------
start:
	mov al, [bx]	;the base address for string
	cmp al, 0	;checks if al is equal to 0
	je fis

	;-----the BIOS helps us print the characters
	mov ah, 0x0e
	int 0x10 	;calls the interrupt to print content of al

	;------increments pointer and continous the loop
	add bx, 1
	jmp start

;------function to pop what is stored at stack-----------------------
;------files/rehister in stack(fis)----------------------------------
fis:
	popa
	ret

;-------function to print new line-----------------------------------
;-------print new line-----------------------------------------------
pnl:
	pusha

	mov ah, 0x0e
	mov al, 0x0a	;newline char
	int 0x10
	mov al, 0x0d	;carriage return
	int 0x10

	popa
	ret


