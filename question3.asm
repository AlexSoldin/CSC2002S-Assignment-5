.data
prompt_string1: .asciiz "Enter the first number:\n"
prompt_string2: .asciiz "Enter the second number:\n"
output_stringYes: .asciiz "The two numbers are relatively prime"
output_stringNo: .asciiz "The two numbers are not relatively prime"
.text

main:

        li $v0, 4
        la $a0, prompt_string1
        syscall

        li $v0, 5
        syscall
        move $t0, $v0 #$t0 stores first number

        li $v0, 4
        la $a0, prompt_string2
        syscall

        li $v0, 5
        syscall
        move $t1, $v0 #$t1 stores second number

        li $t2, 1 #number to be incremented in $t0

        bgt $t0, $t1, setFinal
        move $t3, $t0 #number to stop at in $t0
        b endCounterIf

        endCounterIf:

        setFinal:
        move $t3, $t1 #number to stop at in $t1

        Loop:
            beq $t2, $t3, endLoop #if t0==t1, endLoop
            add $t2, $t2, 1

            div $t0, $t2
            mfhi $t4

            div $t1, $t2
            mfhi $t5

            add $t6, $t4, $t5

            beq $t6, 0, remainderZero #if $t6==0, remainderZero
            b   endif
            remainderZero:
                li $t7, 1

            endif:

            b Loop
        endLoop:

        bne $t7, 1, OutputYes
        la $a0, output_stringNo
        li $v0, 4
        syscall
        b   endOutputIf

        OutputYes:
        la $a0, output_stringYes
        li $v0, 4
        syscall

        endOutputIf:

        # 10 is the exit syscall
        li $v0, 10
        syscall