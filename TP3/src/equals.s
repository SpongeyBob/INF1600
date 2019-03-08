.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */

        /* Write your solution here */
        sub $8, %esp 


        movl $0, -4(%ebp) 
        forR:
                movl -4(%ebp), %ecx
                cmp 16(%ebp), %ecx 
                jae end 


                movl $0,-8(%ebp)
				movl -8(%ebp), %eax
                cmp 16(%ebp), %eax 
                jae forREnd 

                forC:
                        if: 
                            movl -4(%ebp), %eax                      # inmatdata2[c + r * matorder]
                            mull 16(%ebp) 
                            addl -8(%ebp), %eax
                            movl 12(%ebp), %edx 
                            movl (%edx, %eax, 4), %ecx
                            movl 8(%ebp), %edx                      # inmatdata1[c + r * matorder]
                            cmp (%edx, %eax, 4), %ecx             
                            je forCEnd

                            movl $0, %eax
                            addl $8, %esp
                            leave
                            ret
                
                forCEnd:
                incl -8(%ebp)
                movl -8(%ebp), %ecx
				cmp 16(%ebp), %ecx
				jae forREnd
				jmp forC

        forREnd: 
		incl -4(%ebp)
        movl -4(%ebp), %ecx
		cmp 16(%ebp), %ecx
		jnae forR

	end:
    addl $8, %esp
        
        leave          /* Restore ebp and esp */
        ret            /* Return to the caller */
