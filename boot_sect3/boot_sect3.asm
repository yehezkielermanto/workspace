;
; A simple boot sector program that demonstrates addressing.
;
	mov ah , 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

; First attempt
	mov al , the_secret
	int 0x10 					; Does this print an X? No, it prints the wrong address

; Second attempt
	mov al , [the_secret]
	int 0x10 					; Does this print an X? No, it prints the content of the wrong address

; Third attempt

	mov bx , the_secret
	add bx , 0x7c00
	mov al , [bx]
	int 0x10 					; Does this print an X? Yes, it print the content of the correct address

; Fourth attempt
	mov al , [0x7c1d]
	int 0x10 					; Does this print an X? Yes, it prints the content of the manual counted address

	jmp $ ; Jump forever.

the_secret:
db "X"

; Padding and magic BIOS number.
times 510 -($-$$) db 0
dw 0xaa55
