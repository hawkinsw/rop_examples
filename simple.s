bits 64
section .data
; Put the string Hello\n in memory and label
; it as output so that we can refer to it later.
output: db 'H', 'e', 'l', 'l', 'o', `\n`

section .text
global _start

_start:
; Program control starts here. This is done by the linker/loader.
; Let's jump straight to 'main', a function defined below.
	jmp main

GADGETC:
; Invoke a system call
	syscall
; Take the system call's return value and put it in rbx.
; The shell will use this as the program's overall return value.
	mov rbx, rax
; Tell the system that we exited without a problem (rax == 1)
; and then actually stop the program's execution.
	mov rax, 1
	int 0x80
GADGETB:
; Move output (whose value will be replaced by a constant
; by the compiler -- see simple.obj for its actual value)
; into rsi
	mov rsi, output
; Move 6 into rdx
	mov rdx, 6
	ret
GADGETA:
; Move 0x1 into rax and rdi.
	mov rax, 0x1
	mov rdi, 0x1
	ret

main:
; Push some addresses on the stack. These 'labels' are
; turned into constant numeric values by the compiler.
; See simple.obj for their actual values.
	push GADGETC
	push GADGETB
	push GADGETA
; Remember that ROP uses rets to transfer program control.
; Where do we go first?
	ret
