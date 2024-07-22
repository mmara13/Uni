.data
	matrice: .space 40000
	vectorleg: .space 400
	indexcol: .space 4
	indexlin: .space 4
	nrcerinta: .space 4
	nrnoduri: .space 4
	index: .space 4
	left: .space 4
	right: .space 4
	x: .space 4
	y: .space 4
	i: .space 4
	v_i: .space 4
	formatPrintf: .asciz "%ld "
	formatScanf: .asciz "%ld"
	newline: .asciz "\n"
	
.text

.global main
main:
	pushl $nrcerinta
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $nrnoduri
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	lea vectorleg, %edi
	
et_for:
	cmp %ecx, nrnoduri
	je et_auxiliara
	
	pushl %ecx #pt restaurare
	
	pushl $x
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	popl %ecx #restaurare
	
	movl x, %ebx
	movl %ebx, (%edi, %ecx, 4)
	
	incl %ecx #i++
	jmp et_for #loop
	
et_auxiliara:
	xor %ecx, %ecx
	
et_constructiematrice:
	movl $0, indexlin
	for_lin:
		movl indexlin, %ecx
		movl %ecx, i
		cmp %ecx, nrnoduri
		je et_afisarematrice
		lea vectorleg, %edi
		movl (%edi, %ecx, 4) , %ebx
		movl %ebx, v_i
		movl $0, indexcol
		
		for_col:
			movl indexcol, %ecx
			cmp %ecx, v_i
			je et_contforlinii
			#citirea nodului y cu care i are leg
			
			pushl %ecx
			
			pushl $y
			pushl $formatScanf
			call scanf
			popl %ebx
			popl %ebx
			
			popl %ecx
			
			movl i, %eax #indexlinie=eax
			movl $0, %edx
			mull nrnoduri #eax=eax*nrnoduri
			addl y, %eax #eax=indexlin*nrnoduri+y
			
			lea matrice, %edi
			movl $1, (%edi, %eax, 4)
			incl indexcol
			jmp for_col
	et_contforlinii:
		incl indexlin
		jmp for_lin
		
et_afisarematrice:
	movl $0, indexlin
	for_linii:
		movl indexlin, %ecx
		cmp %ecx, nrnoduri
		je et_exit
		movl $0, indexcol
		
		for_coloane:
			movl indexcol, %ecx
			cmp %ecx, nrnoduri
			je cont
			movl indexlin, %eax
			movl $0, %edx
			mull nrnoduri
			addl indexcol, %eax
			
			lea matrice, %edi
			movl (%edi, %eax, 4), %ebx
			
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl indexcol
			jmp for_coloane
	cont:
		push $newline
		call printf
		pop %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		incl indexlin
		jmp for_linii		
et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
