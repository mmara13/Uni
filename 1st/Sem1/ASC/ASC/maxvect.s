.data
	v: .long 5, 3, 2, 1, 10, 15, 20, 23
	n: .long 8 
	Max: .long 0
	formatStr: .asciz "Maximul este %d\n"

.text
.global main
main:
	mov $v, %edi
	mov $0, %ecx
	mov (%edi, %ecx, 4), %eax #primul element
	mov $1, %ecx
	
et_for:
	cmp n, %ecx
	je et_exit
	movl (%edi, %ecx, 4), %ebx #elementul curent
	incl %ecx
	cmp %eax, %ebx
	jg et_atrib 
	jmp et_for
	
et_atrib:
	mov %ebx, %eax
	jmp et_for
et_exit:
	movl %eax, Max
	push Max
	push $formatStr
	call printf
	popl %ebx
	popl %ebx
	
	movl $0, %eax
	movl $1, %ebx
	int $0x80
	
	
