	.file	"bbsorter.c"
	.section	.rodata
.LC0:
	.string	"Enter a number: "
.LC1:
	.string	"%ld"
	.align 4
.LC2:
	.string	"I ended your input list, now I will sort your list: "
	.align 4
.LC3:
	.string	"\nTotal Elements in the Array are(Including the size in the 0th Element) : %ld\n"
	.align 4
.LC4:
	.string	"\nNumber of Elements I sorted: %ld\n"
.LC5:
	.string	"Element#%ld = %ld\n"
	.text
.globl bbsorter
	.type	bbsorter, @function
bbsorter:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$68, %esp
	movl	$10, -12(%ebp)
	movl	-12(%ebp), %eax
	sall	$2, %eax
	movl	%eax, (%esp)
	call	malloc
	movl	%eax, -16(%ebp)
	movl	$0, -20(%ebp)
	movl	$0, -24(%ebp)
	movl	$1, -28(%ebp)
	movl	$1, -32(%ebp)
	movl	$1, -36(%ebp)
	movl	$1, -40(%ebp)
	movl	$0, -44(%ebp)
	movl	$0, -48(%ebp)
	movl	$1, -52(%ebp)
	jmp	.L2
.L7:
	movl	$.LC0, %eax
	movl	%eax, (%esp)
	call	printf
	movl	-28(%ebp), %eax
	sall	$2, %eax
	movl	%eax, %ebx
	addl	-16(%ebp), %ebx
	movl	$4, (%esp)
	call	malloc
	movl	%eax, (%ebx)
	movl	$.LC1, %eax
	leal	-20(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__isoc99_scanf
	movl	%eax, -40(%ebp)
	cmpl	$0, -40(%ebp)
	je	.L3
	movl	-32(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	%edx, (%eax)
	movl	-28(%ebp), %eax
	sall	$2, %eax
	addl	-16(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, (%eax)
	addl	$1, -28(%ebp)
	movl	-32(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -32(%ebp)
	jmp	.L4
.L3:
	movl	$.LC2, (%esp)
	call	puts
.L4:
	movl	-32(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jne	.L2
	sall	-12(%ebp)
	movl	-12(%ebp), %eax
	sall	$2, %eax
	movl	%eax, (%esp)
	call	malloc
	movl	%eax, -56(%ebp)
	movl	$0, -44(%ebp)
	jmp	.L5
.L6:
	movl	-44(%ebp), %eax
	sall	$2, %eax
	addl	-56(%ebp), %eax
	movl	-44(%ebp), %edx
	sall	$2, %edx
	addl	-16(%ebp), %edx
	movl	(%edx), %edx
	movl	%edx, (%eax)
	addl	$1, -44(%ebp)
.L5:
	movl	-32(%ebp), %eax
	cmpl	%eax, -44(%ebp)
	jl	.L6
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	free
	movl	-56(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	$0, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, (%esp)
	call	free
.L2:
	cmpl	$0, -40(%ebp)
	jne	.L7
	movl	-32(%ebp), %edx
	movl	$.LC3, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	-16(%ebp), %edx
	movl	-52(%ebp), %ecx
	movl	-36(%ebp), %ebx
#APP
# 163 "bbsorter.c" 1
	whileLoop:
	movl $0, %ebx
	movl $1, %ecx
	Greatest:
	movl (%edx, %ecx, 4), %eax 
	incl %ecx
	cmpl %eax, (%edx, %ecx, 4) 
	jl sh2
	jmp sh3
	sh2: 
	xchgl	(%edx, %ecx, 4), %eax 
	decl %ecx 
	movl %eax, (%edx, %ecx, 4) 
	movl $1, %ebx
	sh3: 
	cmpl %ecx, -32(%ebp)
	jg Greatest
	movl -32(%ebp), %ecx
	least:
	movl (%edx, %ecx, 4), %eax 
	decl %ecx
	cmpl %eax, (%edx, %ecx, 4) 
	jg sh4
	jmp sh5
	sh4: 
	xchgl	(%edx, %ecx, 4), %eax 
	incl %ecx 
	movl %eax, (%edx, %ecx, 4) 
	movl $1, %ebx
	sh5: 
	cmpl $1, %ecx
	jg least
	cmpl $1, %ebx
	je whileLoop
	done:
	
# 0 "" 2
#NO_APP
	movl	%eax, -24(%ebp)
	movl	$1, -48(%ebp)
	jmp	.L8
.L9:
	movl	-48(%ebp), %eax
	sall	$2, %eax
	addl	-16(%ebp), %eax
	movl	(%eax), %edx
	movl	$.LC5, %eax
	movl	%edx, 8(%esp)
	movl	-48(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	addl	$1, -48(%ebp)
.L8:
	movl	-32(%ebp), %eax
	cmpl	%eax, -48(%ebp)
	jl	.L9
	movl	-16(%ebp), %eax
	addl	$68, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	bbsorter, .-bbsorter
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
