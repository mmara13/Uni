.data
	v: .long 1,2,3,4
	n: .long 4
	suma: .space 4
	formatStr: .asciz "Suma este: %d\n"
.text
.global main
main:
	lea v, %edi
	xor %ecx, %ecx
et_loop:
	cmp %ecx, n
	je et_exit
	movl (%edi, %ecx, 4), %ebx
	movl suma, %eax
	add %ebx, %eax
	movl %eax, suma
	incl %ecx
	jmp et_loop
et_exit:
	pushl suma
	pushl $formatStr
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
