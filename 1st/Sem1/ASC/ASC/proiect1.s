.data

	nrcerinta: .space 4
	nrnoduri: .space 4
	#in loc de indici k,l folosesc registri ebx, ecx (eax ramane pt citire)
	lineindex: .space 4
	columnindex: .space 4
	index: .space 4
	stanga: .space 4
	dreapta: .space 4
	formatscanf: .asciz "%ld"
	formatprintf: .asciz "%ld\n"
	newline: .asciz "\n"
.text
.global main

main:

	#citire numarul cerintei
	pushl $nrcerinta
	pushl $formatscanf
	call scanf
	pop %ebx
	pop %ebx
	
	#citire numar de noduri
	pushl $nrnoduri
	pushl $formatscanf
	call scanf 
	pop %ebx
	pop %ebx
	
	#simulare for(i=0; i<noduri; i++) cin>> v[i]
	
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
	
