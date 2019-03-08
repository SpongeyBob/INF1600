.globl matrix_multiply_asm

matrix_multiply_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */

          subl $16, %esp 

		movl $0, -4(%ebp) 
        forR:
                movl -4(%ebp), %ecx
				cmp 20(%ebp), %ecx
				jae end

				movl $0, -8(%ebp)
				movl -8(%ebp), %ecx
                cmp 20(%ebp), %ecx                      # Compare c et matorder 
                jae forREnd 

				forC:
					movl $0, -16(%ebp)

					movl $0, -12(%ebp)
					movl -12(%esp), %ecx
					cmp 20(%ebp), %ecx
					jae forCEnd

					forI:
						movl -12(%ebp), %eax					# elem += inmatdata1[i + r * matorder] * inmatdata2[c + i * matorder];
						mull 20(%ebp) 
						addl -8(%ebp), %eax
						movl 12(%ebp), %edx 
						movl (%edx, %eax, 4), %ecx 				# %ecx = inmatdata2[c + i * matorder] 

						movl -4(%ebp), %eax 
						mull 20(%ebp) 
						addl -12(%ebp), %eax 
						movl 8(%ebp), %edx
						pushl (%edx, %eax, 4)					# inmatdata1[i + r * matorder] dans la pile 
						popl %eax 
						imull %ecx		
						addl %eax, -16(%ebp)

					forIEnd:
						incl -12(%ebp)
						movl -12(%ebp), %ecx
						cmp 20(%ebp), %ecx
						jae forCEnd
						jmp forI

				forCEnd:
				movl -4(%ebp), %eax 			# outmatdata[c + r * matorder] = elem;
				mull 20(%ebp) 
				addl -8(%ebp), %eax 
				movl 16(%ebp), %ecx 
				movl -16(%ebp), %edx 
				movl %edx, (%ecx, %eax, 4) 

				incl -8(%ebp)
				movl -8(%ebp), %ecx
				cmp 20(%ebp), %ecx
				jae forREnd
				jmp forC

		forREnd:
		incl -4(%ebp)
		movl -4(%ebp), %ecx
		cmp 20(%ebp), %ecx
		jnae forR

		end:
		addl $16, %esp 
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
