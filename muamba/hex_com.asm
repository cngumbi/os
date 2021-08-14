;---------------------------------------------------------------------------------------
;-------------------creatint a function to help in the----------------------------------
;-------------------in the processing of hexadecimal------------------------------------
;-------------------natation------------------------------------------------------------
;---------------------------------------------------------------------------------------
p_hex:
	pusha
	

mov cx, 0	    		;index variable

;----------------------------------------------------------------------------------------
;---------------------functions----------------------------------------------------------
;----------------------------------------------------------------------------------------

hex_loop:
	cmp cx, 4		;loop 4 times
	je end

	; convert last char of 'dx' to ascii
	mov ax, dx		;register ax will be the working dir
	add ax, 0x000f		;0x0004
	add al, 0x30		;add 0x30 to convert N to ASCII "N"
	cmp al, 0x39		;if > 9,
	jle gcp
	add al, 7		;'A' is ACSII 65 instead of 58,65-58=7

;---------------------------------------------------------------------------------------
;-------get correct position-----of the string to place ASCII char----------------------
;---------------------------------------------------------------------------------------
gcp:
	mov bx, HEX_OUT + 5	;base address + string length
	sub bx, cx		;index variable
	mov [bx], al		;copy char in al to poksition pointed by bx
	ror dx, 4
	
	; increment and loop
	add cx, 1
	jmp hex_loop

end:
	;prepare the parameter and call the function
	;print receives parameters in 'bx'
	mov bx, HEX_OUT
	call pfis

	popa
	ret


HEX_OUT:
	db '0x0000', 0		;reserve memory for our new string
