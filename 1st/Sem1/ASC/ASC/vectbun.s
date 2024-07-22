.data
	nrnoduri: .space 4
	x: .space 4
	v: .space 20
	formatscanf: .asciz "%d " 
	formatprintf: .asciz "Afisare: %d\n"
	
.text

.global main
main:
	pushl $nrnoduri
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx #index==0  TREBUIE RESTAURAT
	lea v, %edi
	subl $1,nrnoduri
	
et_for:
	cmp nrnoduri, %ecx
	je et_afis
	
	pushl %ecx #pt restaurare ecx
	
	pushl $x
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	xorl %ebx, %ebx
	movl x, %ebx
	
	movl %ebx, (%edi, %ecx, 4)
	
	incl %ecx
	jmp et_for
	
et_afis:
	#restauram indicele %ecx
	xorl %ecx, %ecx
	
et_afisare:
	cmp nrnoduri, %ecx
	je et_exit
	
	xor %ebx, %ebx
	movl (%edi, %ecx, 4), %ebx
	movl %ebx, x
	
	pushl %ecx
	
	pushl x
	pushl $formatprintf
	call printf
	popl %ebx
	popl %ebx
	
	
	popl %ecx
	
	incl %ecx
	jmp et_afisare
	
et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
