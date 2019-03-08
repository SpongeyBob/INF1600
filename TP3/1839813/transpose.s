.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */

         subl $8, %esp                  # reservec space for r & c


        movl $0, -4(%ebp) 
        forR:
                movl -4(%ebp), %ecx
                cmp 16(%ebp), %ecx              # Compare r et matorder 
                jae end 


                movl $0,-8(%ebp)
				movl -8(%ebp), %eax
                cmp 16(%ebp), %eax              # Compare c & matorder 
                jae forREnd 

                forC:

                    movl -8(%ebp), %eax         # outmatdata[c + r * matorder] = inmatdata[r + c * matorder]; 
                    mull 16(%ebp) 
                    addl -4(%ebp), %eax
                    movl 8(%ebp), %edx 
                    movl (%edx, %eax, 4), %ecx      # %ecx = inmatdata[r + c * matorder] 
                    
                    movl -4(%ebp), %eax 
                    mull 16(%ebp) 
                    addl -8(%ebp), %eax 
                    movl 12(%ebp), %edx 

                    movl %ecx, (%edx, %eax, 4)       # outmatdata[c + r * matorder] = %ecx
                
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
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
