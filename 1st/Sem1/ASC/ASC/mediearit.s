.data
	medie: .long 0
	v: .long 5, 3, 2, 8, 7, 8, 4, 0
	n: .long 8
	cate: .long 0
	suma: .long 0
	catm: .long 0
	formatStr: .asciz "%d    Sunt %d numere care sunt egale cu catul mediei aritmetice a numerelor din vector\n"
.text

.global main
main:
	#parcurgem o data vectorul pentru a face media aritmetica a tuturor numerelor
	movl $0, %ecx
	mov $v, %edi
	
	
	
et_for:
	cmp n, %ecx
	je et_urm
	mov (%edi, %ecx, 4), %eax #elementul curent
	addl %eax, suma
	incl %ecx
	jmp et_for
et_urm:
	#calcul medie artimetica
	movl $0, %edx
	movl suma, %eax
	divl n
	movl %eax, catm #catul mediei artimetice
	
	#reinitializam %ecx cu 0 mergem al al doilea for
	movl $0, %ecx
	jmp et_for2
et_for2:
	cmp n, %ecx
	je et_exit
	mov (%edi, %ecx, 4), %eax
	incl %ecx
	cmp %eax, catm
	je et_atribuire
	jmp et_for2
	
et_atribuire:
	addl $1, cate
	jmp et_for2
et_exit:
	push cate
	push $formatStr
	call printf
	pop %ebx
	pop %ebx
	
	movl $0, %eax
	movl $1, %ebx
	int $0x80
	
	

