.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		/* Write your solution here */

        pushl $0 #c 
        pushl $0 #r
        pushl $0 #elem

        jmp test_loop_1          # Commence la premiere loop for

        loop_1: 
            jmp test_loop_2       # Commence le deuxième  loop for() 

            loop_2: 
                movl -8(%ebp), %eax    # elem += inmatdata[c + r * matorder];
                mull 16(%ebp) 
                addl -4(%ebp), %eax
                movl 8(%ebp), %ecx 
                movl -12(%ebp), %edx 
                addl (%ecx, %eax, 4), %edx
                movl %edx, -12(%ebp) 
                
                incl -4(%ebp) 

            test_loop_2: 
                mov -4(%ebp), %ecx    # Le deuxième loop for() est terminé 
                cmp 16(%ebp), %ecx
                jnae loop_2

            mov -12(%ebp), %eax       # outmatdata[r] = elem/matorder;
            divl 16(%ebx) 
            mov 12(%ebp), %ecx  
            mov -8(%ebp), %edx 
            mov %eax, (%ecx, %edx, 4)
            
            incl -8(%ebp)

        test_loop_1: 
            mov -8(%ebp), %ecx        
            cmp 16(%ebp), %ecx  
            jnae loop_1

		mov %ebp, %esp 
		
        leave          			/* Restore ebp and esp */
        ret           			/* Return to the caller */
		
