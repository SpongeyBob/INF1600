.global func_s

func_s:
	    mov     [rbp-16], 0
.L5:
        cmp    $10, -16(%rbp)
        jnae      .L6				#boucle for
        mov    -12(%rbp), %edx
        mov    -20(%rbp), %eax
        add    %edx, %eax
        sub    -4(%rbp), %eax		
        mov    %eax, -24(%rbp)		#a = d + e - b

        mov    -4(%rbp), %eax
		sub	$1000, %edx 
        mov    -8(%rbp), %eax
        add    $500, %eax
        cmp    %eax, %edx
        jnae      .L3				#if ((b-1000) < (c+500))
        sub    $500, -8(%rbp)
        mov    -4(%rbp), %eax
        cmp    -8(%rbp), %eax
        jae     .L4					#if(b>c)
        sub    $500, -4(%rbp)
        jmp     .L4
.L3:		#else
        mov    -20(%rbp), %eax
        sub    %eax, -4(%rbp)
        add    $500, -12(%rbp)
.L4:
        add    $1, -16(%rbp)		#i++
        jmp     .L5
.L6:
        popq    %rbp
        ret
