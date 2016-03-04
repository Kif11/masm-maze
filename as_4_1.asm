.586
.model  flat, stdcall
option casemap:none

; Link in the CRT.
includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib

extern printf:NEAR
extern scanf:NEAR
extern _getch:NEAR

.data
	gameBoardSize DD 10
	singleChar DB "%c", 0
	boardLine DB "%c", 0Ah, 0
	playerPosition 0, 0

    healthStr DB "Health: %c", 0Ah, 0
    health DD 10
.code

main PROC C
		push ebp
     	mov ebp,esp

		; int 3
		call RenderGameBoard
		add esp, 4

; MainLoop:	call _getch
; 			mov edi, eax
;
; 			; Check for quit
; 			cmp edi, 71h  ; 'q' key
; 			je Quit
;
; 			call ShowMsg
;
; 			jmp MainLoop
;
; Quit:		mov eax, 0

		mov esp,ebp
		pop ebp

		ret
main ENDP


RenderGameBoard PROC
		push ebp
     	mov ebp,esp

		mov ecx, gameBoardSize
		lineLoop:
			push gameBoardSize
			call PrintLine
			add esp, 4

			sub ecx, 1
		jnz lineLoop

		mov esp,ebp
     	pop ebp

		ret
RenderGameBoard ENDP


PrintLine PROC
		push ebp
     	mov ebp,esp


		pusha ; Push general-purpose registers onto stack

		mov ecx, [ebp+8] ; Start counter
		mainLoop:
			push 061h
			call PrintChar
			add esp, 4

			sub ecx, 1 ; Decrement counter
		jnz mainLoop

		; Go to new line
		push 0Ah
		call PrintChar
		add esp, 4

		popa ; Pop general-purpose registers from stack

		mov esp,ebp
     	pop ebp

		ret
PrintLine ENDP


PrintChar PROC
		push ebp
     	mov ebp,esp

		pusha

		push [ebp+8]
		push offset singleChar
		call printf
		add esp, 8

		popa

		mov esp,ebp
     	pop ebp

		ret
PrintChar ENDP


END
