TITLE CS2810 Assembler Template

; Hunter Burningham:
; 11/21/2021:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	
	vMpeg00 byte "MPEG Version 2.5",0
	vMpeg01 byte "MPEG RESERVED",0
	vMpeg10 byte "MPEG Version 2",0
	vMpeg11 byte "MPEG Version 1",0

.code
main PROC
	;--------- Enter Code Below Here
	call clrscr
	;call DisplaySemester
	;call DisplayAssignment
	;call DisplayName
	
	
	call DisplayAudioVersion
	;call DisplayLayer
	;call DisplaySample

	jmp OffACliff

	DisplayAudioVersion:
	mov eax, 0FFFB9264h
			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM <------Template
	and eax, 00000000000110000000000000000000b
	shr eax, 19 ; shift right bits to move BB to least significant

	cmp eax, 00b ;if
	jz DMPEG00
	cmp eax, 01b ;if
	jz DMPEG01
	cmp eax, 10b ;if
	jz DMPEG10
	jmp DMPEG11 ; else (unconditional jump)
	
	DMpeg00:
	mov edx, offset VMpeg00
	jmp DisplayString
	DMpeg01:
	mov edx, offset VMpeg01
	jmp DisplayString
	DMpeg10:
	mov edx, offset VMpeg10
	jmp DisplayString
	DMpeg11:
	mov edx, offset VMPeg11
	jmp DisplayString
	ret

	DisplayString:
	call WriteString
	ret

	OffaCliff:
	xor ecx, ecx
	call ReadChar

	exit


main ENDP

END main