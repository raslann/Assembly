	.file	"bbsorter.c"
	.section	.rodata
.LC0:
	.string	"Enter a number: "
.LC1:
	.string	"%ld"
	.align 8
.LC2:
	.string	"I ended your input list, now I will sort your list: "
	.align 8
.LC3:
	.string	"\nTotal Elements in the Array are(Including the size in the 0th Element) : %ld\n"
	.align 8
.LC4:
	.string	"\nNumber of Elements I sorted: %ld\n"
.LC5:
	.string	"Element#%ld = %ld\n"
	.text
.globl bbsorter
	.type	bbsorter, @function
bbsorter:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$104, %rsp
	movq	$10, -24(%rbp)
	movq	-24(%rbp), %rax
	salq	$3, %rax
	movq	%rax, %rdi
	.cfi_offset 3, -24
	call	malloc
	movq	%rax, -32(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
	movq	$1, -56(%rbp)
	movq	$1, -64(%rbp)
	movq	$1, -72(%rbp)
	movq	$1, -80(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -96(%rbp)
	movq	$1, -104(%rbp)
	jmp	.L2
.L7:
	movl	$.LC0, %eax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movq	-56(%rbp), %rax
	salq	$3, %rax
	movq	%rax, %rbx
	addq	-32(%rbp), %rbx
	movl	$8, %edi
	call	malloc
	movq	%rax, (%rbx)
	movl	$.LC1, %eax
	leaq	-40(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf
	cltq
	movq	%rax, -80(%rbp)
	cmpq	$0, -80(%rbp)
	je	.L3
	movq	-64(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-56(%rbp), %rax
	salq	$3, %rax
	addq	-32(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$1, -56(%rbp)
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -64(%rbp)
	jmp	.L4
.L3:
	movl	$.LC2, %edi
	call	puts
.L4:
	movq	-64(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jne	.L2
	salq	-24(%rbp)
	movq	-24(%rbp), %rax
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -112(%rbp)
	movq	$0, -88(%rbp)
	jmp	.L5
.L6:
	movq	-88(%rbp), %rax
	salq	$3, %rax
	addq	-112(%rbp), %rax
	movq	-88(%rbp), %rdx
	salq	$3, %rdx
	addq	-32(%rbp), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, (%rax)
	addq	$1, -88(%rbp)
.L5:
	movq	-64(%rbp), %rax
	cmpq	%rax, -88(%rbp)
	jl	.L6
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-112(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	free
.L2:
	cmpq	$0, -80(%rbp)
	jne	.L7
	movq	-64(%rbp), %rdx
	movl	$.LC3, %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movq	-64(%rbp), %rax
	leaq	-1(%rax), %rdx
	movl	$.LC4, %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movq	-32(%rbp), %rdx
	movq	-104(%rbp), %rcx
	movq	-72(%rbp), %rbx
#APP
# 81 "bbsorter.c" 1
	whileLoop:
	movq $0, %rbx
	movq $1, %rcx
	Greatest:
	movq (%rdx, %rcx, 8), %rax 
	incq %rcx
	cmpq %rax, (%rdx, %rcx, 8) 
	jl sh2
	jmp sh3
	sh2: 
	xchgq (%rdx, %rcx, 8), %rax 
	decq %rcx 
	movq %rax, (%rdx, %rcx, 8) 
	movq $1, %rbx
	sh3: 
	cmpq %rcx, -64(%rbp)
	jg Greatest
	movq -64(%rbp), %rcx
	least:
	movq (%rdx, %rcx, 8), %rax 
	decq %rcx
	cmpq %rax, (%rdx, %rcx, 8) 
	jg sh4
	jmp sh5
	sh4: 
	xchgq (%rdx, %rcx, 8), %rax 
	incq %rcx 
	movq %rax, (%rdx, %rcx, 8) 
	movq $1, %rbx
	sh5: 
	cmpq $1, %rcx
	jg least
	cmpq $1, %rbx
	je whileLoop
	done:
	
# 0 "" 2
#NO_APP
	movq	%rax, -48(%rbp)
	movq	$1, -96(%rbp)
	jmp	.L8
.L9:
	movq	-96(%rbp), %rax
	salq	$3, %rax
	addq	-32(%rbp), %rax
	movq	(%rax), %rdx
	movl	$.LC5, %eax
	movq	-96(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	addq	$1, -96(%rbp)
.L8:
	movq	-64(%rbp), %rax
	cmpq	%rax, -96(%rbp)
	jl	.L9
	movq	-32(%rbp), %rax
	addq	$104, %rsp
	popq	%rbx
	leave
	ret
	.cfi_endproc
.LFE0:
	.size	bbsorter, .-bbsorter
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
