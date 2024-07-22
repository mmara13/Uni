.data
	v: .long 2, 3, 4, 5, 6, 7, 10
	nrnoduri: .space 4
	formatscanf: .asciz "%d"
	formatprintf: .asciz "%d\n"
.text

.global main
main:
	#citire nrnoduri
	pushl $nrnoduri
	pushl $formatscanf
	call scanf
	pop %ebx
	pop %ebx
	movl $0, %ecx
	movl nrnoduri, %eax
et_for:
	cmp %ecx, %eax
	
