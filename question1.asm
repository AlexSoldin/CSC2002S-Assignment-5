.data
prompt_string: .asciiz "Enter a number:\n"
output_string: .asciiz "The single digit divisors are:\n"
newLine: .asciiz "\n"
.text

main:
        li $v0, 4
        la $a0, prompt_string
        syscall

        li $v0, 5
        syscall
        move $t4, $v0

        la $a0, output_string
        li $v0, 4
        syscall

        li $t0, 1 #number to be incremented in $t0
        li $t1, 9 #number to stop at in $t1

        Loop:
            beq $t0, $t1, endLoop #if t0==t1, endLoop
            add $t0, $t0, 1

            div $t4, $t0

            #check loop is looping correctly
            #move $a0, $t0
            #li $v0, 1
            #syscall

            mfhi $t2 #remainder of the divide
            beq $t2, 0, remainderZero #if t2 == 0
            b   endif
            remainderZero:
                move $a0, $t0
                li $v0, 1
                syscall

                li	$v0, 4
                la	$a0, newLine
                syscall

            endif:
            b Loop
        endLoop:

        # 10 is the exit syscall
        li $v0, 10
        syscall