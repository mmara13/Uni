.data 
	v: .long 2, 3, 4, 5, 6
	nrnoduri: .space 4
	x: .space 4
	formatscanf: .asciz "%d\n"
	formatprintf: .asciz "afis: %ld\n"

.text

.global main
main:
	#citim nr noduri
	pushl $nrnoduri
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx
	
	movl nrnoduri, %edx
	#OBS!!!! nr de noduri se citeste/afiseaza bine, prb la vector
	
	
	movl $0, %ecx #folosim ecx pe post de index (i)
	
et_for:
	movl nrnoduri, %edx
	cmp %ecx, %edx
	jle et_citirenodurilegate
	
	#citim pe rand elementele vectorului
	#pushl $x
	#pushl $formatscanf
	#call scanf
	#popl %ebx
	#popl %ebx
	
	#AFISARE DE PROBA FIECARE ELEMENT IN PARTE -nu merge
	#push x
	#push $formatprintf
	#call printf
	#popl %ebx
	#popl %ebx
	
	#movl x, %eax
	#movl $v, %edi #incarcam adresa lui v in %edi
	#movl %eax, (%edi, %ecx, 4) #v[i]=x


	#movl $0, x #pt a putea refolosi x si la urm pas
	incl %ecx #i++
	jmp et_for

et_citirenodurilegate: #afisare aici
	movl $0, %ecx
	jmp et_afis
et_afis:
	movl nrnoduri, %edx
	cmp %ecx, %edx #for(i=0;i<nrnoduri;i++)
	jle et_exit
	movl $v, %edi #incarcam adresa lui v in %edi
	movl (%edi, %ecx, 4), %eax
	movl %eax, x #x=v[i]
	pushl x
	pushl $formatprintf
	call printf #cout<<v[i]
	popl %ebx
	popl %ebx
	
	incl %ecx #i++
	jmp et_afis

et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
