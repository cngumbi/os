[org 0x7c00]
mov ah, 0x0e

mov al, "1"
int 0x10

mov al, [the_test_word]
int 0x10
int 0x10
int 0x10

jmp $

the_test_word:
	db "X"

times 510-($-$$) db 0
dw 0xaa55
