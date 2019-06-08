[BITS 16]	; tell nasm that its a 16 bit code

TIMES 510 - ($ - $$) db 0	;fill the rest of sector with 0
DW 0xAA55			; add boot signature at the end of bootloader
