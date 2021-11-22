TITLE CS2810 Assembler Template

; Hunter Burningham:
; 11/21/2021:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here

	vName Byte "Hunter Burningham",0
	vSemester byte "CS2810 Fall Semester 2021",0
	vAssignment byte "Assembler Assignment #3",0
	vPrompt byte "Please enter an MP3 frame header in Hex",0

	vMpeg00 byte "MPEG Version 2.5",0
		V00rate00 byte "Sampling rate: 11025 Hz",0
		V00rate01 byte "Sampling rate: 12000 Hz",0
		V00rate10 byte "Sampling rate: 8000 Hz",0
		
	vMpeg01 byte "MPEG RESERVED",0
		
	vMpeg10 byte "MPEG Version 2",0
		V10rate00 byte "Sampling rate: 22050 Hz",0
		V10rate01 byte "Sampling rate: 24000 Hz",0
		V10rate10 byte "Sampling rate: 16000 Hz",0
		
	vMpeg11 byte "MPEG Version 1",0
		V11rate00 byte "Sampling rate: 44100 Hz",0
		V11rate01 byte "Sampling rate: 48000 Hz",0
		V11rate10 byte "Sampling rate: 32000 Hz",0

		vrate11 byte "Sampling rate: Reserved",0

	VLayer00 byte "LAYER RESERVED",0
	VLayer01 byte "LAYER III",0
	VLayer10 byte "LAYER II",0
	VLayer11 byte "LAYER I",0
		

.code
main PROC
	;--------- Enter Code Below Here
	call clrscr
	
	mov dh, 12
	mov dl, 12
	call Gotoxy
	mov edx, OFFSET vSemester
	call writeString

	mov dh, 13
	mov dl, 12
	call Gotoxy
	mov edx, OFFSET vAssignment
	call writeString

	mov dh, 14
	mov dl, 12
	call Gotoxy
	mov edx, OFFSET vName
	call writeString

	mov dh, 16
	mov dl, 12
	call Gotoxy
	mov edx, OFFSET vPrompt
	call writeString
	call readhex 

	mov ecx, eax ; backup

	mov eax, ecx
	mov dh, 18
	mov dl, 12
	call gotoxy
	call displayVersion

	mov eax, ecx
	mov dh, 19
	mov dl, 12
	call Gotoxy
	call displayLayer

	mov eax, ecx
	mov dh, 20
	mov dl, 12
	call Gotoxy
	call displayRate

	jmp OffACliff ;end

	DisplayVersion:
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

	DisplayLayer:
			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM <------Template
	and eax, 00000000000001100000000000000000b
	shr eax, 17 ; shift right bits to move CC to least significant

	cmp eax, 00b ;if
	jz Layer00
	cmp eax, 01b ;if
	jz Layer01
	cmp eax, 10b ;if
	jz Layer10

	jmp Layer11 

	Layer00:
	mov edx, offset VLayer00
	jmp DisplayString
	Layer01:
	mov edx, offset VLayer01
	jmp DisplayString
	Layer10:
	mov edx, offset VLayer10
	jmp DisplayString
	Layer11:
	mov edx, offset VLayer11
	jmp DisplayString
	ret

	DisplayRate:

			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM <------Template
	and eax, 00000000000110000000110000000000b
	shr eax, 10 ; shift right bits to move FF to least significant


	cmp eax, 00000000000b
	jz b0000
	cmp eax, 00000000001b
	jz b0001
	cmp eax, 00000000010b
	jz b0010

	cmp eax, 10000000000b
	jz b1000
	cmp eax, 10000000001b
	jz b1001
	cmp eax, 10000000010b 
	jz b1010

	cmp eax, 11000000000b
	jz b1100
	cmp eax, 11000000001b
	jz b1101
	cmp eax, 11000000010b
	jz b1110

	jmp rsv

	b0000:
	mov edx, offset V00rate00
	jmp DisplayString

	b0001:
	mov edx, offset v00rate01
	jmp DisplayString

	b0010:
	mov edx, offset v00rate10
	jmp DisplayString

	b1000:
	mov edx, offset v10rate00
	jmp DisplayString

	b1001:
	mov edx, offset v10rate01
	jmp DisplayString

	b1010:
	mov edx, offset V10rate10
	jmp DisplayString

	b1100:
	mov edx, offset V11rate00
	jmp DisplayString
	
	b1101:
	mov edx, offset V11rate01
	jmp DisplayString
	
	b1110:
	mov edx, offset V11rate10
	jmp DisplayString

	rsv:
	mov edx, offset Vrate11
	jmp DisplayString


	DisplayString:
	call WriteString
	ret

	offacliff:
	xor ecx, ecx
	call ReadChar

	exit

main ENDP
END main