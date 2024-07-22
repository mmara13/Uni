.data
	v: .space 20
	nrnoduri: .space 4
	x: .space 4
	formatscanf: .asciz "%d"
	formatprintf: .asciz "afis: %d\n"

.text

.global main
main:
	#citim nr noduri
	pushl $nrnoduri
	pushl $formatscanf
	call scanf
	pop %ebx
	pop %ebx
	
	#afisare nr noduri pt proba STERGE
	#pushl nrnoduri
	#pushl $formatprintf
	#call printf
	#pop %ebx
	#pop %ebx
	
	xor %ecx, %ecx #indexare de la 0, folosim ecx pe post de indice (i)
	
et_for:
	movl nrnoduri, %edx
	cmp %ecx, %edx 
	jle et_afis
	
	#citim pe rand x drept urmatorul element din vector
	pushl $x
	pushl $formatscanf
	call scanf
	pop %ebx
	pop %ebx
	
	movl x, %eax #mutam in eax numarul citit
	movl $v, %edi #adresa lui v este permanent in edi
	movl %eax, (%edi, %ecx, 4) #    v[i]=x, unde i=%ecx
	
	incl %ecx
	jmp et_for

et_afis:
	xor %ecx, %ecx #ne intoarcem la prima pozitie din vector
	jmp afisare #mergem la eticheta de afisare
afisare:
	movl nrnoduri, %edx
	cmp %ecx, %edx
	jle et_exit
	
	#afisam pe rand
	movl (%edi, %ecx, 4), %eax
	movl %eax, x
	pushl x
	pushl $formatprintf
	call printf #     cout<<v[i], unde i=%ecx
	pop %ebx
	pop %ebx
	
	incl %ecx
	jmp afisare
	
et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
