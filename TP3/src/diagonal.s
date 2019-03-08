.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */

		/* Write your solution here */
        subl $8, %esp
		
		movl $0, -4(%ebp)    # Init r a 0 et fait ++r
        forR:
                movl -4(%ebp), %ecx
                cmp 16(%ebp), %ecx 
                jae end 
       
				movl $0,-8(%ebp)
				forC:
					movl -8(%ebp), %ecx
					cmp 16(%ebp), %ecx 
					jae forREnd 

						if: 
							movl -4(%ebp), %ecx
							movl -8(%ebp), %edx
							cmp %ecx, %edx
							jne else

							movl -4(%ebp), %eax			# outmatdata[c + r * matorder] = inmatdata[c + r * matorder];
							mull 16(%ebp) 
							addl -8(%ebp), %eax 
							movl 8(%ebp), %edx 
							movl (%edx, %eax, 4), %ecx 	# %ecx = inmatdata[c + r * matorder]
							
							movl 12(%ebp), %edx 
							movl %ecx, (%edx, %eax, 4)  # outmatdata[c + r * matorder] = %ecx 
							jmp forCEnd
						
						else:
							movl -4(%ebp), %eax			# outmatdata[c + r * matorder] = 0;
							mull 16(%ebp) 
							addl -8(%ebp), %eax 
							movl 12(%ebp), %edx 
							movl $0, (%edx, %eax, 4) 
							jmp forCEnd

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
		
       leave          			/* Restore ebp and esp */
       ret            			/* Return to the caller */

