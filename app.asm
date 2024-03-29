;--------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------
;set/tell the location where you expect 
;the code to be loaded in memory
;---------------------------------------------------------------------------------------
[org 0x7c00]

mov [BT_DRIVE], dl		;the store boot drive in BOIS

;---------------------------------------------------------------------------------------
;set the stack at 0x8000
;safely away from the bootsector
;---------------------------------------------------------------------------------------
mov bp, 0x8000			;set the stack at 0x8000
mov sp, bp

;---------------------------------------------------------------------------------------
;load the sectors from the boot disk
;---------------------------------------------------------------------------------------

mov bx, 0x9000			;set ES:BX to 0x0000:0x9000
mov dh, 2			;read the two sectors
mov dl, [BT_DRIVE]
call d_load			;call disk load

mov dx, [0x9000]		;print the first loaded word
call p_hex

mov dx, [0x9000 + 512]		;print first word from second loaded sector
call p_hex

;---------------------------------------------------------------------------------------
;set the jamp to the carrent registor
;---------------------------------------------------------------------------------------
jmp $

;---------------------------------------------------------------------------------------
;include all the files needed for the bootsector
;---------------------------------------------------------------------------------------
%include "muamba/Pstring.asm"
%include "muamba/hex_com.asm"
%include "muamba/drivers/disk/d_load.asm"

;---------------------------------------------------------------------------------------
;Global variables
;---------------------------------------------------------------------------------------
BT_DRIVE:	db 0

;---------------------------------------------------------------------------------------
;to set the padding and BOIS magic number
;---------------------------------------------------------------------------------------
times 510 - ($-$$) db 0
dw 0xaa55

;---------------------------------------------------------------------------------------
;set additional sectors for the BIOs to load
;---------------------------------------------------------------------------------------
times 256 dw 0xdada		;sector two = 512 bytes
times 256 dw 0xface		;sector three = 512 bytes
