.data 
	v: .long 1, 2, 3, 4, 6, 5, 7
	n: .long 7
	formatStr: .asciz "Incepand cu pozitia %d vectorul nu mai este crescator\n"
	formatStr2: .asciz "Vectorul este crescator"
	
.text

.global main
main:
	mov $v, %edi
	movl $0, %ecx #primul element
	movl (%edi, %ecx, 4), %eax 
	movl $1, %ecx
et_for:
	cmp n, %ecx
	je et_exit1
	movl (%edi, %ecx, 4), %ebx #elementul curent
	cmp %eax, %ebx
	jl et_exit2
	movl %ebx, %eax
	incl %ecx
	jmp et_for
et_exit2: #inseamna ca vectorul nu este crescator, cel putin din acest punct inainte
	push %ecx
	push $formatStr
	call printf
	pop %ebx
	pop %ebx
	
	movl $0, %eax
	movl $1, %ebx
	int $0x80

et_exit1: #inseamna ca vectorul a fost parcurs fara prob pana la final deci e cresc
	push $formatStr2
	call printf
	pop %ebx
	
	movl $0, %eax
	movl $1, %ebx
	int $0x80
