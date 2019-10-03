.data
prompt_string: .asciiz "Enter a number:"
output_string2: .asciiz "It is divisible by 2\n"
output_string3: .asciiz "It is divisible by 3\n"
output_string23: .asciiz "It is divisible by both 2 and 3\n"
output_string0: .asciiz "It is neither divisible by 2 nor 3\n"
.text

main:

        li $t0, 0 #number to be incremented in $t0
        li $t1, 5 #number to stop at in $t1

        li $t2, 2 #divide by 2
        li $t3, 3 #divide by 3

        Loop:
            beq $t0, $t1, endLoop #if t0==t1, endLoop
            add $t0, $t0, 1

            li $v0, 4
            la $a0, prompt_string
            syscall

            li $v0, 5
            syscall
            move $t4, $v0

            div $t4, $t2
            mfhi $t5 #remainder of the divide by 2

            div $t4, $t3
            mfhi $t6 #remainder of the divide by 3

            add $t7, $t5, $t6

            bne $t7, 0, divide2 #if t7 != 0 (addition of both remainders) therefore both divisible
            la $a0, output_string23
            li $v0, 4
            syscall
            b   endif

            divide2:
            bne $t5, 0, divide3
            la $a0, output_string2
            li $v0, 4
            syscall
            b   endif

            divide3:
            bne $t6, 0, default
            la $a0, output_string3
            li $v0, 4
            syscall
            b   endif

            default:
            la $a0, output_string0
            li $v0, 4
            syscall

            endif:
            b Loop
        endLoop:

        # 10 is the exit syscall
        li $v0, 10
        syscall