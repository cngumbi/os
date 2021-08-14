;----------------------------------------------------------------------------------------
;-----------------------routine to enable BOIS to read/load the disk drive---------------
;----------------------------------------------------------------------------------------
;-----------------------load sectors to ES:BX from drive---------------------------------
d_load:
	pusha
	push dx		;store dx in stack to recall the number of sector
			;to be read

;----------------------------------------------------------------------------------------
;-----------------------BOIS read sector function----------------------------------------
;----------------------------------------------------------------------------------------
mov ah, 0x02		;set register to read(0x02)
mov al, dh		;read DH sector
mov ch, 0x00		;select Cylinder zero(0)
mov dh, 0x00		;select Head zero(0)
mov cl, 0x02		;start reading from the second sector(after the bootsector)

int 0x13		;BOIS interrupt

jc disk_err		;jump if error(i.e CF set)
;----------------------------------------------------------------------------------------
;-----------------------restore data from stack------------------------------------------
;----------------------------------------------------------------------------------------
pop dx			;restore dx from stack
cmp dh, al		;if AL != DH (sector read != sector expected)
jne sector_err		;error message when the number of sector is incorrect
popa
ret

;----------------------------------------------------------------------------------------
;-----------------------function to display error message--------------------------------
;----------------------------------------------------------------------------------------
disk_err:
	mov bx, DISK_ERR_MSG
	call pfis
	call pnl
	mov dh, ah		;prints the disk that has error
	call p_hex 
	jmp $

sector_err:
	mov bx, SEC_ERR
	call pfis

;----------------------------------------------------------------------------------------
;-----------------------variable declaration---------------------------------------------
;----------------------------------------------------------------------------------------
DISK_ERR_MSG db "Disk read error!", 0
SEC_ERR:  db "incorrect number of sector", 0


