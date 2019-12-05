	.data
	.align 2
_var1:	.space 4
	.text
_test_fn_void1:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 4
	.data
.L1:	.asciiz "void function1\n"
	.text
	la    $t0, .L1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L0:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
	.text
_test_fn_void2:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 4
	.data
.L3:	.asciiz "void function2\n"
	.text
	la    $t0, .L3
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	b     .L2
.L2:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
	.text
_test_fn:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 12
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	.data
.L5:	.asciiz "test_fn: "
	.text
	la    $t0, .L5
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	.data
.L6:	.asciiz "\n"
	.text
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $v0, 4($sp)	#POP
	addu  $sp, $sp, 4
	b     .L4
	.data
.L7:	.asciiz "output after return\n"
	.text
	la    $t0, .L7
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, 8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $v0, 4($sp)	#POP
	addu  $sp, $sp, 4
	b     .L4
.L4:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
	.text
_recursion_fn:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 0
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sle   $t0, $t0, $t1
	beq   $t0, 0, .L10
	b     .L9
.L9:
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $v0, 4($sp)	#POP
	addu  $sp, $sp, 4
	b     .L8
	b     .L11
.L10:
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sub   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _recursion_fn
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sub   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _recursion_fn
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $v0, 4($sp)	#POP
	addu  $sp, $sp, 4
	b     .L8
.L11:
.L8:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
	.text
_while_loop_addition_fn:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 4
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
.L13:
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sgt   $t0, $t0, $t1
	beq   $t0, 0, .L15
	b     .L14
.L14:
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	sub   $t0, $t0, 1
	sw    $t0, 0($t1)
	b     .L13
.L15:
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $v0, 4($sp)	#POP
	addu  $sp, $sp, 4
	b     .L12
.L12:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
	.text
_test_local_in_if:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 24
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($fp)
	beq   $t0, 0, .L18
	b     .L17
.L17:
	li    $t0, 4
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 8
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -24($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -24($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -16($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	b     .L19
.L18:
	li    $t0, 4
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -16($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
.L19:
.L20:
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sgt   $t0, $t0, $t1
	beq   $t0, 0, .L22
	b     .L21
.L21:
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -28($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	sub   $t0, $t0, 1
	sw    $t0, 0($t1)
	b     .L20
.L22:
	lw    $t0, -16($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $v0, 4($sp)	#POP
	addu  $sp, $sp, 4
	b     .L16
.L16:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
	.text
	.globl main
main:	# FUNCTION ENTRY
	sw    $ra, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	sw    $fp, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	addu  $fp, $sp, 8
	subu  $sp, $sp, 20
	li    $t0, 8
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	li    $t1, -1
	mult  $t0, $t1
	mflo  $t0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _test_fn_void1
	add   $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _test_fn_void2
	add   $sp, 4
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _test_fn
	add   $sp, 8
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	.data
.L24:	.asciiz "Fibonacci Recursion Test:\n"
	.text
	la    $t0, .L24
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _recursion_fn
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _recursion_fn
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 10
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _recursion_fn
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 100
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _while_loop_addition_fn
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _test_local_in_if
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	jal   _test_local_in_if
	add   $sp, 4
	sw    $v0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	.data
.L25:	.asciiz "Hello world!"
	.text
	la    $t0, .L25
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 8
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sub   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 3
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	mult  $t0, $t1
	mflo  $t0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	div   $t0, $t1
	mflo  $t0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, 1
	sw    $t0, 0($t1)
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	sub   $t0, $t0, 1
	sw    $t0, 0($t1)
	lw    $t0, _var1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	lw    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	seq   $t0, $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	b     .L26
.L26:
	li    $t0, 0
.L27:
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	.data
.L28:	.asciiz " "
	.text
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	b     .L29
.L29:
	li    $t0, 1
.L30:
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	b     .L32
.L31:
	li    $t0, 0
.L32:
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 0
	b     .L33
.L33:
	li    $t0, 0
.L34:
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	slt   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	slt   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sgt   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sgt   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sle   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sle   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sle   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sge   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sge   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sge   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	seq   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	seq   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sne   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L28
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sne   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	b     .L35
.L35:
	.data
.L37:	.asciiz "branch test 01"
	.text
	la    $t0, .L37
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L36:
	li    $t0, 0
	b     .L39
.L38:
	.data
.L40:	.asciiz "branch test 01 failed"
	.text
	la    $t0, .L40
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L39:
	li    $t0, 1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	beq   $t0, 0, .L42
	b     .L41
.L41:
	.data
.L43:	.asciiz "branch test 02"
	.text
	la    $t0, .L43
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L42:
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -8($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	beq   $t0, 0, .L45
	b     .L44
.L44:
	.data
.L46:	.asciiz "branch test 02 failed"
	.text
	la    $t0, .L46
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L45:
	li    $t0, 1
	b     .L47
.L47:
	.data
.L50:	.asciiz "branch test 03"
	.text
	la    $t0, .L50
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	b     .L49
.L48:
	.data
.L51:	.asciiz "branch test 03 failed"
	.text
	la    $t0, .L51
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L49:
	li    $t0, 0
	b     .L53
.L52:
	.data
.L55:	.asciiz "branch test 04 failed"
	.text
	la    $t0, .L55
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	b     .L54
.L53:
	.data
.L56:	.asciiz "branch test 04"
	.text
	la    $t0, .L56
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L54:
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
.L57:
	lw    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 10
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	slt   $t0, $t0, $t1
	beq   $t0, 0, .L59
	b     .L58
.L58:
	lw    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	add   $t0, $t0, 1
	sw    $t0, 0($t1)
	b     .L57
.L59:
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	.data
.L60:	.asciiz "yidong"
	.text
	la    $t0, .L60
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, .L60
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	seq   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L60
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	.data
.L61:	.asciiz "yidong2"
	.text
	la    $t0, .L61
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	seq   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L60
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, .L61
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sne   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L60
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, .L60
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sne   $t0, $t0, $t1
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $t0, 1
	b     .L63
.L62:
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
.L63:
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	li    $t0, 2
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	li    $t0, 3
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	seq   $t0, $t0, $t1
	beq   $t0, 0, .L65
	b     .L64
.L64:
	li    $t0, 0
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	la    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t1, 4($sp)	#POP
	addu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $t0, 0($t1)
.L65:
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	lw    $t0, -12($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $v0, 5
	syscall
	la    $t0, -16($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sne   $t1, $v0, 0
	sw    $t1, 0($t0)
	lw    $t0, -16($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
	li    $v0, 5
	syscall
	la    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	sw    $v0, 0($t0)
	lw    $t0, -20($fp)
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 1
	syscall
	la    $t0, .L6
	sw    $t0, 0($sp)	#PUSH
	subu  $sp, $sp, 4
	lw    $t0, 4($sp)	#POP
	addu  $sp, $sp, 4
	move  $a0, $t0
	li    $v0, 4
	syscall
.L23:
		#FUNCTION EXIT
	lw    $ra, 0($fp)
	move  $t0, $fp
	lw    $fp, -4($fp)
	move  $sp, $t0
	jr    $ra
