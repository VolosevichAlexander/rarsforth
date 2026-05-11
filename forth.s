	.text
	.globl	vm
.data
	.align	2
vm:
	.space 66064
	.globl	dict
	.align	2
dict:
	.space 15360
	.globl	dict_len
.data
	.align	2
dict_len:
	.space 4
	.globl	vocab_count
.data
	.align	2
vocab_count:
	.word	1
	.text
	.align	2
sext16:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	li	a5,32768
	and	a5,a4,a5
	beq	a5,zero,.L2
	lw	a4,-20(s0)
	li	a5,-65536
	or	a5,a4,a5
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	cell_fetch
cell_fetch:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-36(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	lw	a5,-36(s0)
	add	a5,a4,a5
	lbu	a5,520(a5)
	andi	a5,a5,0xff
	mv	a3,a5
	lw	a5,-36(s0)
	addi	a5,a5,1
	slli	a5,a5,16
	srli	a5,a5,16
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	add	a5,a4,a5
	lbu	a5,520(a5)
	andi	a5,a5,0xff
	slli	a5,a5,8
	or	a5,a3,a5
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	li	a5,32768
	and	a5,a4,a5
	beq	a5,zero,.L5
	lw	a4,-20(s0)
	li	a5,-65536
	or	a5,a4,a5
	sw	a5,-20(s0)
.L5:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	ucell_fetch
ucell_fetch:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a5,520(a5)
	andi	a5,a5,0xff
	mv	a3,a5
	lw	a5,-20(s0)
	addi	a5,a5,1
	slli	a5,a5,16
	srli	a5,a5,16
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	add	a5,a4,a5
	lbu	a5,520(a5)
	andi	a5,a5,0xff
	slli	a5,a5,8
	or	a5,a3,a5
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	cell_store
cell_store:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	andi	a4,a5,0xff
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	lw	a5,-20(s0)
	add	a5,a3,a5
	sb	a4,520(a5)
	lw	a5,-24(s0)
	srai	a4,a5,8
	lw	a5,-20(s0)
	addi	a5,a5,1
	slli	a5,a5,16
	srli	a5,a5,16
	andi	a4,a4,0xff
# DELETED LUI: 	lui	a3,%hi(vm)
	la a3, vm
	add	a5,a3,a5
	sb	a4,520(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	byte_fetch
byte_fetch:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a5,520(a5)
	andi	a5,a5,0xff
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	byte_store
byte_store:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	andi	a4,a5,0xff
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	lw	a5,-20(s0)
	add	a5,a3,a5
	sb	a4,520(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	my_strcmp
my_strcmp:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	j	.L14
.L16:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L14:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	beq	a5,zero,.L15
	lw	a5,-20(s0)
	lbu	a4,0(a5)
	lw	a5,-24(s0)
	lbu	a5,0(a5)
	beq	a4,a5,.L16
.L15:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	mv	a4,a5
	lw	a5,-24(s0)
	lbu	a5,0(a5)
	sub	a5,a4,a5
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	my_strcpy
my_strcpy:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	j	.L19
.L20:
	lw	a5,-24(s0)
	lbu	a4,0(a5)
	lw	a5,-20(s0)
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L19:
	lw	a5,-24(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L20
	lw	a5,-20(s0)
	sb	zero,0(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	digit_value
digit_value:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a4,-36(s0)
	li	a5,47
	ble	a4,a5,.L22
	lw	a4,-36(s0)
	li	a5,57
	bgt	a4,a5,.L22
	lw	a5,-36(s0)
	addi	a5,a5,-48
	sw	a5,-20(s0)
	j	.L23
.L22:
	lw	a4,-36(s0)
	li	a5,64
	ble	a4,a5,.L24
	lw	a4,-36(s0)
	li	a5,90
	bgt	a4,a5,.L24
	lw	a5,-36(s0)
	addi	a5,a5,-55
	sw	a5,-20(s0)
	j	.L23
.L24:
	lw	a4,-36(s0)
	li	a5,96
	ble	a4,a5,.L25
	lw	a4,-36(s0)
	li	a5,122
	bgt	a4,a5,.L25
	lw	a5,-36(s0)
	addi	a5,a5,-87
	sw	a5,-20(s0)
	j	.L23
.L25:
	li	a5,-1
	j	.L26
.L23:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L27
	li	a5,-1
	j	.L26
.L27:
	lw	a5,-20(s0)
.L26:
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	current_base
current_base:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a0,2
	call	cell_fetch
	sw	a0,-20(s0)
	lw	a4,-20(s0)
	li	a5,1
	ble	a4,a5,.L29
	lw	a4,-20(s0)
	li	a5,36
	ble	a4,a5,.L30
.L29:
	li	a5,10
	sw	a5,-20(s0)
.L30:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	is_number
is_number:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	call	current_base
	sw	a0,-20(s0)
	lw	a5,-36(s0)
	lbu	a4,0(a5)
	li	a5,45
	bne	a4,a5,.L33
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L33:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L36
	li	a5,0
	j	.L35
.L38:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	lw	a1,-20(s0)
	mv	a0,a5
	call	digit_value
	mv	a5,a0
	bge	a5,zero,.L37
	li	a5,0
	j	.L35
.L37:
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L36:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L38
	li	a5,1
.L35:
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	my_atoi
my_atoi:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	call	current_base
	sw	a0,-28(s0)
	li	a5,1
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	lbu	a4,0(a5)
	li	a5,45
	bne	a4,a5,.L40
	li	a5,-1
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L40:
	sw	zero,-24(s0)
	j	.L41
.L44:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	lw	a1,-28(s0)
	mv	a0,a5
	call	digit_value
	sw	a0,-32(s0)
	lw	a5,-32(s0)
	blt	a5,zero,.L46
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	mul	a5,a4,a5
	lw	a4,-32(s0)
	add	a5,a4,a5
	sw	a5,-24(s0)
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L41:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L44
	j	.L43
.L46:
	nop
.L43:
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mul	a5,a4,a5
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	print_in_base
print_in_base:
	addi	sp,sp,-96
	sw	ra,92(sp)
	sw	s0,88(sp)
	addi	s0,sp,96
	sw	a0,-84(s0)
	sw	a1,-88(s0)
	lw	a5,-84(s0)
	bne	a5,zero,.L48
	li	a5,48
	sb	a5,-33(s0)
	lbu	a5,-33(s0)
	sw	a5,-40(s0)
	lw	a5,-40(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L47
.L48:
	sw	zero,-20(s0)
	lw	a5,-84(s0)
	bge	a5,zero,.L50
	li	a5,1
	sw	a5,-20(s0)
	lw	a5,-84(s0)
	neg	a5,a5
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-24(s0)
	j	.L51
.L50:
	lw	a5,-84(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-24(s0)
.L51:
	sw	zero,-28(s0)
	j	.L52
.L55:
	lw	a5,-88(s0)
	lw	a4,-24(s0)
	remu	a5,a4,a5
	sw	a5,-32(s0)
	lw	a4,-32(s0)
	li	a5,9
	bgt	a4,a5,.L53
	lw	a5,-32(s0)
	andi	a5,a5,0xff
	addi	a5,a5,48
	andi	a5,a5,0xff
	j	.L54
.L53:
	lw	a5,-32(s0)
	andi	a5,a5,0xff
	addi	a5,a5,55
	andi	a5,a5,0xff
.L54:
	lw	a4,-28(s0)
	addi	a3,a4,1
	sw	a3,-28(s0)
	addi	a4,a4,-16
	add	a4,a4,s0
	sb	a5,-60(a4)
	lw	a5,-88(s0)
	lw	a4,-24(s0)
	divu	a5,a4,a5
	sw	a5,-24(s0)
.L52:
	lw	a5,-24(s0)
	bne	a5,zero,.L55
	lw	a5,-20(s0)
	beq	a5,zero,.L57
	li	a5,45
	sb	a5,-41(s0)
	lbu	a5,-41(s0)
	sw	a5,-48(s0)
	lw	a5,-48(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L57
.L58:
	lw	a5,-28(s0)
	addi	a5,a5,-1
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a5,-60(a5)
	sb	a5,-49(s0)
	lbu	a5,-49(s0)
	sw	a5,-56(s0)
	lw	a5,-56(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
.L57:
	lw	a5,-28(s0)
	bgt	a5,zero,.L58
.L47:
	lw	ra,92(sp)
	lw	s0,88(sp)
	addi	sp,sp,96
	jr	ra
	.align	2
	.globl	print_in_base_unsigned
print_in_base_unsigned:
	addi	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	addi	s0,sp,80
	sw	a0,-68(s0)
	sw	a1,-72(s0)
	lw	a5,-68(s0)
	bne	a5,zero,.L61
	li	a5,48
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L60
.L61:
	sw	zero,-20(s0)
	j	.L63
.L66:
	lw	a5,-72(s0)
	lw	a4,-68(s0)
	remu	a5,a4,a5
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	li	a5,9
	bgt	a4,a5,.L64
	lw	a5,-24(s0)
	andi	a5,a5,0xff
	addi	a5,a5,48
	andi	a5,a5,0xff
	j	.L65
.L64:
	lw	a5,-24(s0)
	andi	a5,a5,0xff
	addi	a5,a5,55
	andi	a5,a5,0xff
.L65:
	lw	a4,-20(s0)
	addi	a3,a4,1
	sw	a3,-20(s0)
	addi	a4,a4,-16
	add	a4,a4,s0
	sb	a5,-44(a4)
	lw	a5,-72(s0)
	lw	a4,-68(s0)
	divu	a5,a4,a5
	sw	a5,-68(s0)
.L63:
	lw	a5,-68(s0)
	bne	a5,zero,.L66
	j	.L67
.L68:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a5,-44(a5)
	sb	a5,-33(s0)
	lbu	a5,-33(s0)
	sw	a5,-40(s0)
	lw	a5,-40(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
.L67:
	lw	a5,-20(s0)
	bgt	a5,zero,.L68
.L60:
	lw	ra,76(sp)
	lw	s0,72(sp)
	addi	sp,sp,80
	jr	ra
.data
	.align	2
.LC0:
	.string	"Dict Full!\n"
	.text
	.align	2
	.globl	create_word_lv
create_word_lv:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	sw	s1,52(sp)
	addi	s0,sp,64
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	sw	a3,-48(s0)
	sw	a4,-52(s0)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
	li	a5,255
	ble	a4,a5,.L71
# DELETED LUI: 	lui	a5,%hi(.LC0)
	la a5, .LC0
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L70
.L71:
	lw	a5,-40(s0)
	li	a4,31
	ble	a5,a4,.L73
	li	a5,31
.L73:
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L74
.L75:
	lw	a5,-20(s0)
	lw	a4,-36(s0)
	add	a5,a4,a5
# DELETED LUI: 	lui	a4,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
	lbu	a3,0(a5)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a2, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a4,a2,a5
	lw	a5,-20(s0)
	add	a5,a4,a5
	sb	a3,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L74:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L75
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a4,a3,a5
	lw	a5,-20(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,-40(s0)
	sw	a4,32(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,-44(s0)
	sw	a4,36(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,-48(s0)
	sw	a4,40(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	sw	zero,44(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,-52(s0)
	sw	a4,48(a5)
	lw	a5,-44(s0)
	seqz	a5,a5
	andi	a3,a5,0xff
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a4, 0(t6)
	mv	a2,a3
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a2,52(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw s1, 0(t6)
	li	a0,12
	call	cell_fetch
	mv	a3,a0
# DELETED LUI: 	lui	a5,%hi(dict)
	la a4, dict
	mv	a5,s1
	slli	a5,a5,4
	sub	a5,a5,s1
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,56(a5)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,1
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	sw a4, 0(t6)
.L70:
	lw	ra,60(sp)
	lw	s0,56(sp)
	lw	s1,52(sp)
	addi	sp,sp,64
	jr	ra
	.align	2
	.globl	create_word
create_word:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	sw	a3,-48(s0)
	sw	zero,-20(s0)
	j	.L77
.L78:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L77:
	lw	a5,-20(s0)
	lw	a4,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L78
	lw	a4,-48(s0)
	lw	a3,-44(s0)
	lw	a2,-40(s0)
	lw	a1,-20(s0)
	lw	a0,-36(s0)
	call	create_word_lv
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	names_match
names_match:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-36(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,32(a5)
	lw	a4,-44(s0)
	beq	a4,a5,.L80
	li	a5,0
	j	.L81
.L80:
	lw	a5,-44(s0)
	li	a4,31
	ble	a5,a4,.L82
	li	a5,31
.L82:
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L83
.L85:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-36(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a4,a3,a5
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a4,0(a5)
	lw	a5,-20(s0)
	lw	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	beq	a4,a5,.L84
	li	a5,0
	j	.L81
.L84:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L83:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L85
	li	a5,1
.L81:
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	find_id_lv
find_id_lv:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	li	a0,10
	call	cell_fetch
	sw	a0,-28(s0)
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a5,a5,-1
	sw	a5,-20(s0)
	j	.L87
.L90:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,56(a5)
	lw	a4,-28(s0)
	bne	a4,a5,.L88
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lw	a0,-20(s0)
	call	names_match
	mv	a5,a0
	beq	a5,zero,.L88
	lw	a5,-20(s0)
	j	.L89
.L88:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-20(s0)
.L87:
	lw	a5,-20(s0)
	bge	a5,zero,.L90
	lw	a5,-28(s0)
	beq	a5,zero,.L91
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a5,a5,-1
	sw	a5,-24(s0)
	j	.L92
.L94:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-24(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,56(a5)
	bne	a5,zero,.L93
	lw	a2,-40(s0)
	lw	a1,-36(s0)
	lw	a0,-24(s0)
	call	names_match
	mv	a5,a0
	beq	a5,zero,.L93
	lw	a5,-24(s0)
	j	.L89
.L93:
	lw	a5,-24(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)
.L92:
	lw	a5,-24(s0)
	bge	a5,zero,.L94
.L91:
	li	a5,-1
.L89:
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	find_id
find_id:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	zero,-20(s0)
	j	.L96
.L97:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L96:
	lw	a5,-20(s0)
	lw	a4,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L97
	lw	a1,-20(s0)
	lw	a0,-36(s0)
	call	find_id_lv
	mv	a5,a0
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	forth_init
forth_init:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	zero,0(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	zero,260(a5)
	sw	zero,-20(s0)
	j	.L100
.L101:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	lw	a5,-20(s0)
	add	a5,a4,a5
	sb	zero,520(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L100:
	lw	a4,-20(s0)
	li	a5,65536
	blt	a4,a5,.L101
	li	a1,0
	li	a0,0
	call	cell_store
	li	a1,10
	li	a0,2
	call	cell_store
	li	a1,0
	li	a0,4
	call	cell_store
	li	a1,0
	li	a0,6
	call	cell_store
	li	a1,0
	li	a0,8
	call	cell_store
	li	a1,0
	li	a0,10
	call	cell_store
	li	a1,0
	li	a0,12
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	li	a4,1232
	sw	a4,520(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC1:
	.string	"S-Ovf!\n"
	.text
	.align	2
	.globl	push
push:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,0(a5)
	li	a5,63
	bgt	a4,a5,.L103
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	s1,0(a5)
	addi	a4,s1,1
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	a4,0(a5)
	lw	a0,-36(s0)
	call	sext16
	mv	a3,a0
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	slli	a5,s1,2
	add	a5,a4,a5
	sw	a3,4(a5)
	j	.L105
.L103:
# DELETED LUI: 	lui	a5,%hi(.LC1)
	la a5, .LC1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
 #APP
# 27 "rars_lib.h" 1
	li a7, 10
	ecall
# 0 "" 2
 #NO_APP
	nop
.L105:
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	addi	sp,sp,48
	jr	ra
.data
	.align	2
.LC2:
	.string	"S-Udf!\n"
	.text
	.align	2
	.globl	pop
pop:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	ble	a5,zero,.L107
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	sw	a5,0(a4)
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	j	.L108
.L107:
# DELETED LUI: 	lui	a5,%hi(.LC2)
	la a5, .LC2
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	li	a5,0
.L108:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC3:
	.string	"R-Ovf!\n"
	.text
	.align	2
	.globl	rpush
rpush:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,260(a5)
	li	a5,63
	bgt	a4,a5,.L110
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	s1,260(a5)
	addi	a4,s1,1
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	a4,260(a5)
	lw	a0,-36(s0)
	call	sext16
	mv	a3,a0
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	addi	a5,s1,64
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,8(a5)
	j	.L112
.L110:
# DELETED LUI: 	lui	a5,%hi(.LC3)
	la a5, .LC3
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
 #APP
# 27 "rars_lib.h" 1
	li a7, 10
	ecall
# 0 "" 2
 #NO_APP
	nop
.L112:
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	addi	sp,sp,48
	jr	ra
.data
	.align	2
.LC4:
	.string	"R-Udf!\n"
	.text
	.align	2
	.globl	rpop
rpop:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	ble	a5,zero,.L114
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	sw	a5,260(a4)
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	addi	a5,a5,64
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,8(a5)
	j	.L115
.L114:
# DELETED LUI: 	lui	a5,%hi(.LC4)
	la a5, .LC4
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	li	a5,0
.L115:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	in_user_word
.data
	.align	2
in_user_word:
	.space 4
	.globl	exit_flag
	.align	2
exit_flag:
	.space 4
	.globl	abort_flag
	.align	2
abort_flag:
	.space 4
	.text
	.align	2
	.globl	execute_user_word
execute_user_word:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,-36(s0)
	sw	a4,524(a5)
# DELETED LUI: 	lui	a5,%hi(in_user_word)
	la t6, in_user_word
	lw a5, 0(t6)
	addi	a4,a5,1
# DELETED LUI: 	lui	a5,%hi(in_user_word)
	la t6, in_user_word
	sw a4, 0(t6)
.L123:
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	la t6, abort_flag
	lw a5, 0(t6)
	bne	a5,zero,.L124
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	cell_fetch
	sw	a0,-24(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
	lw	a4,-24(s0)
	li	a5,-1
	beq	a4,a5,.L125
	lw	a5,-24(s0)
	blt	a5,zero,.L120
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	lw	a4,-24(s0)
	bge	a4,a5,.L120
	lw	a0,-24(s0)
	call	execute_dict
.L120:
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	la t6, abort_flag
	lw a5, 0(t6)
	bne	a5,zero,.L126
# DELETED LUI: 	lui	a5,%hi(exit_flag)
	la t6, exit_flag
	lw a5, 0(t6)
	beq	a5,zero,.L123
# DELETED LUI: 	lui	a5,%hi(exit_flag)
	la t6, exit_flag
	sw zero, 0(t6)
	j	.L118
.L124:
	nop
	j	.L118
.L125:
	nop
	j	.L118
.L126:
	nop
.L118:
# DELETED LUI: 	lui	a5,%hi(in_user_word)
	la t6, in_user_word
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(in_user_word)
	la t6, in_user_word
	sw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,524(a5)
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	execute_dict
execute_dict:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,52(a5)
	li	a4,5
	beq	a5,a4,.L128
	li	a4,5
	bgt	a5,a4,.L135
	li	a4,4
	beq	a5,a4,.L130
	li	a4,4
	bgt	a5,a4,.L135
	li	a4,3
	beq	a5,a4,.L131
	li	a4,3
	bgt	a5,a4,.L135
	li	a4,2
	beq	a5,a4,.L132
	li	a4,2
	bgt	a5,a4,.L135
	beq	a5,zero,.L133
	li	a4,1
	beq	a5,a4,.L134
	j	.L135
.L133:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,36(a5)
	jalr	a5
	j	.L129
.L134:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	mv	a0,a5
	call	execute_user_word
	j	.L129
.L132:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	mv	a0,a5
	call	push
	j	.L129
.L131:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	mv	a0,a5
	call	cell_fetch
	mv	a5,a0
	mv	a0,a5
	call	push
	j	.L129
.L130:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	mv	a0,a5
	call	push
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,44(a5)
	mv	a0,a5
	call	execute_user_word
	j	.L129
.L128:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	mv	a1,a5
	li	a0,10
	call	cell_store
	nop
.L129:
.L135:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC5:
	.string	"Mem Full!\n"
	.text
	.align	2
	.globl	comma
comma:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,520(a5)
	li	a5,65536
	addi	a5,a5,-2
	bgt	a4,a5,.L137
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	lw	a1,-36(s0)
	mv	a0,a5
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,520(a5)
	j	.L139
.L137:
# DELETED LUI: 	lui	a5,%hi(.LC5)
	la a5, .LC5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
 #APP
# 27 "rars_lib.h" 1
	li a7, 10
	ecall
# 0 "" 2
 #NO_APP
	nop
.L139:
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	c_comma
c_comma:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,520(a5)
	li	a5,65536
	bge	a4,a5,.L141
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	lw	a1,-36(s0)
	mv	a0,a5
	call	byte_store
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	addi	a4,a5,1
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,520(a5)
	j	.L143
.L141:
# DELETED LUI: 	lui	a5,%hi(.LC5)
	la a5, .LC5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
 #APP
# 27 "rars_lib.h" 1
	li a7, 10
	ecall
# 0 "" 2
 #NO_APP
	nop
.L143:
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_add
w_add:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_sub
w_sub:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	sub	a5,a4,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_mul
w_mul:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mul	a5,a4,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_div
w_div:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	beq	a5,zero,.L148
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	div	a5,a4,a5
	j	.L149
.L148:
	li	a5,0
.L149:
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_mod
w_mod:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	beq	a5,zero,.L151
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	rem	a5,a4,a5
	j	.L152
.L151:
	li	a5,0
.L152:
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_div_mod
w_div_mod:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	bne	a5,zero,.L154
	li	a0,0
	call	push
	li	a0,0
	call	push
	j	.L153
.L154:
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	rem	a5,a4,a5
	mv	a0,a5
	call	push
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	div	a5,a4,a5
	mv	a0,a5
	call	push
.L153:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_one_plus
w_one_plus:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	addi	a5,a5,1
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_one_minus
w_one_minus:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	addi	a5,a5,-1
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_two_plus
w_two_plus:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	addi	a5,a5,2
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_two_minus
w_two_minus:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	addi	a5,a5,-2
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_abs
w_abs:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	srai	a4,a5,31
	lw	a5,-20(s0)
	xor	a5,a4,a5
	sub	a5,a5,a4
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_negate
w_negate:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	neg	a5,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_min
w_min:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	ble	a5,a4,.L163
	mv	a5,a4
.L163:
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_max
w_max:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	bge	a5,a4,.L165
	mv	a5,a4
.L165:
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_mul_div
w_mul_div:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	lw	a5,-20(s0)
	bne	a5,zero,.L167
	li	a0,0
	call	push
	j	.L166
.L167:
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	mul	a4,a4,a5
	lw	a5,-20(s0)
	div	a5,a4,a5
	mv	a0,a5
	call	push
.L166:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_mul_div_mod
w_mul_div_mod:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	lw	a5,-20(s0)
	bne	a5,zero,.L170
	li	a0,0
	call	push
	li	a0,0
	call	push
	j	.L169
.L170:
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	mul	a5,a4,a5
	sw	a5,-32(s0)
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	rem	a5,a4,a5
	mv	a0,a5
	call	push
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	div	a5,a4,a5
	mv	a0,a5
	call	push
.L169:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_zero_eq
w_zero_eq:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	seqz	a5,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_zero_lt
w_zero_lt:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	srli	a5,a5,31
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_zero_gt
w_zero_gt:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	sgt	a5,a5,zero
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_and
w_and:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	and	a5,a4,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_or
w_or:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	or	a5,a4,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_xor
w_xor:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	xor	a5,a4,a5
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_u_lt
w_u_lt:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	sltu	a5,a4,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_u_mul
w_u_mul:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mul	a5,a4,a5
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	mv	a0,a5
	call	push
	lw	a5,-28(s0)
	srli	a5,a5,16
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_u_div_mod
w_u_div_mod:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-24(s0)
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	bne	a5,zero,.L181
	li	a0,0
	call	push
	li	a0,0
	call	push
	j	.L180
.L181:
	lw	a5,-24(s0)
	slli	a5,a5,16
	lw	a4,-28(s0)
	or	a5,a4,a5
	sw	a5,-32(s0)
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	remu	a5,a4,a5
	slli	a5,a5,16
	srli	a5,a5,16
	mv	a0,a5
	call	push
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	divu	a5,a4,a5
	slli	a5,a5,16
	srli	a5,a5,16
	mv	a0,a5
	call	push
.L180:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_to_r
w_to_r:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	mv	a0,a5
	call	rpush
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_r_from
w_r_from:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	rpop
	mv	a5,a0
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_r_fetch
w_r_fetch:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	ble	a5,zero,.L187
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	addi	a5,a5,64
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,8(a5)
	mv	a0,a5
	call	push
.L187:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_q_dup
w_q_dup:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	ble	a5,zero,.L190
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	beq	a5,zero,.L190
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a0,a5
	call	push
.L190:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.data
	.align	2
.LC6:
	.string	"PICK err\n"
	.text
	.align	2
	.globl	w_pick
w_pick:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	ble	a5,zero,.L192
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	lw	a4,-20(s0)
	ble	a4,a5,.L193
.L192:
# DELETED LUI: 	lui	a5,%hi(.LC6)
	la a5, .LC6
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	li	a0,0
	call	push
	j	.L191
.L193:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,0(a5)
	lw	a5,-20(s0)
	sub	a5,a4,a5
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a0,a5
	call	push
.L191:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC7:
	.string	"ROLL err\n"
	.text
	.align	2
	.globl	w_roll
w_roll:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-24(s0)
	lw	a5,-24(s0)
	ble	a5,zero,.L196
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	lw	a4,-24(s0)
	ble	a4,a5,.L197
.L196:
# DELETED LUI: 	lui	a5,%hi(.LC7)
	la a5, .LC7
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L195
.L197:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,0(a5)
	lw	a5,-24(s0)
	sub	a5,a4,a5
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	sw	a5,-28(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,0(a5)
	lw	a5,-24(s0)
	sub	a5,a4,a5
	sw	a5,-20(s0)
	j	.L199
.L200:
	lw	a5,-20(s0)
	addi	a5,a5,1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,4(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,4(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L199:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
	lw	a4,-20(s0)
	blt	a4,a5,.L200
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,4(a5)
.L195:
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_plus_store
w_plus_store:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a0,-20(s0)
	call	cell_fetch
	mv	a4,a0
	lw	a5,-24(s0)
	add	a5,a4,a5
	mv	a1,a5
	lw	a0,-20(s0)
	call	cell_store
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_cmove
w_cmove:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	lw	a5,-24(s0)
	ble	a5,zero,.L207
	sw	zero,-20(s0)
	j	.L205
.L206:
	lw	a4,-28(s0)
	lw	a5,-20(s0)
	add	s1,a4,a5
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	byte_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L205:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L206
	j	.L202
.L207:
	nop
.L202:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_move
w_move:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	lw	a5,-24(s0)
	ble	a5,zero,.L213
	sw	zero,-20(s0)
	j	.L211
.L212:
	lw	a5,-20(s0)
	slli	a4,a5,1
	lw	a5,-28(s0)
	add	s1,a4,a5
	lw	a5,-20(s0)
	slli	a4,a5,1
	lw	a5,-32(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	cell_fetch
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	cell_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L211:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L212
	j	.L208
.L213:
	nop
.L208:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_fill
w_fill:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	lw	a5,-28(s0)
	ble	a5,zero,.L219
	sw	zero,-20(s0)
	j	.L217
.L218:
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	lw	a1,-24(s0)
	mv	a0,a5
	call	byte_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L217:
	lw	a4,-20(s0)
	lw	a5,-28(s0)
	blt	a4,a5,.L218
	j	.L214
.L219:
	nop
.L214:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_count
w_count:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	byte_fetch
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	mv	a0,a5
	call	push
	lw	a0,-24(s0)
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_type
w_type:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	lw	a5,-24(s0)
	ble	a5,zero,.L226
	sw	zero,-20(s0)
	j	.L224
.L225:
	lw	a4,-28(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	andi	a5,a5,0xff
	sb	a5,-29(s0)
	lbu	a5,-29(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L224:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L225
	j	.L221
.L226:
	nop
.L221:
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_dash_trailing
w_dash_trailing:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	bge	a5,zero,.L230
	lw	a0,-24(s0)
	call	push
	li	a0,0
	call	push
	j	.L227
.L232:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-20(s0)
.L230:
	lw	a5,-20(s0)
	ble	a5,zero,.L231
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	addi	a5,a5,-1
	mv	a0,a5
	call	byte_fetch
	mv	a4,a0
	li	a5,32
	beq	a4,a5,.L232
.L231:
	lw	a0,-24(s0)
	call	push
	lw	a0,-20(s0)
	call	push
.L227:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	tmp_buf
.data
	.align	2
tmp_buf:
	.space 256
	.text
	.align	2
	.globl	w_word
w_word:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	sw	s1,52(sp)
	addi	s0,sp,64
	call	pop
	mv	a5,a0
	andi	a5,a5,255
	sw	a5,-32(s0)
	li	a0,4
	call	cell_fetch
	sw	a0,-20(s0)
	li	a5,16
	sw	a5,-36(s0)
.L237:
	lw	a4,-36(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	sw	a0,-40(s0)
	lw	a5,-40(s0)
	beq	a5,zero,.L244
	lw	a4,-40(s0)
	lw	a5,-32(s0)
	bne	a4,a5,.L245
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	j	.L237
.L244:
	nop
	j	.L235
.L245:
	nop
.L235:
	lw	a5,-20(s0)
	sw	a5,-44(s0)
.L239:
	lw	a4,-36(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	sw	a0,-48(s0)
	lw	a5,-48(s0)
	beq	a5,zero,.L238
	lw	a4,-48(s0)
	lw	a5,-32(s0)
	beq	a4,a5,.L238
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	j	.L239
.L238:
	lw	a4,-20(s0)
	lw	a5,-44(s0)
	sub	a5,a4,a5
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	li	a5,31
	ble	a4,a5,.L240
	li	a5,31
	sw	a5,-24(s0)
.L240:
	lw	a1,-24(s0)
	li	a0,1136
	call	byte_store
	sw	zero,-28(s0)
	j	.L241
.L242:
	lw	a5,-28(s0)
	addi	s1,a5,1137
	lw	a4,-36(s0)
	lw	a5,-44(s0)
	add	a4,a4,a5
	lw	a5,-28(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	byte_store
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L241:
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L242
	lw	a4,-36(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	sw	a0,-52(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1137
	lw	a1,-52(s0)
	mv	a0,a5
	call	byte_store
	lw	a5,-52(s0)
	beq	a5,zero,.L243
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L243:
	lw	a1,-20(s0)
	li	a0,4
	call	cell_store
	li	a0,1136
	call	push
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	lw	s1,52(sp)
	addi	sp,sp,64
	jr	ra
	.align	2
	.globl	w_find
w_find:
	addi	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	addi	s0,sp,80
	li	a0,32
	call	push
	call	w_word
	call	pop
	sw	a0,-24(s0)
	lw	a0,-24(s0)
	call	byte_fetch
	sw	a0,-28(s0)
	lw	a5,-28(s0)
	bne	a5,zero,.L247
	li	a0,0
	call	push
	j	.L246
.L247:
	lw	a5,-28(s0)
	li	a4,31
	ble	a5,a4,.L249
	li	a5,31
.L249:
	sw	a5,-32(s0)
	sw	zero,-20(s0)
	j	.L250
.L251:
	lw	a5,-24(s0)
	addi	a4,a5,1
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	andi	a4,a5,0xff
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	sb	a4,-52(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L250:
	lw	a4,-20(s0)
	lw	a5,-32(s0)
	blt	a4,a5,.L251
	lw	a5,-32(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	sb	zero,-52(a5)
	addi	a5,s0,-68
	mv	a0,a5
	call	find_id
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	bge	a5,zero,.L252
	li	a0,0
	call	push
	j	.L246
.L252:
	lw	a0,-36(s0)
	call	push
.L246:
	lw	ra,76(sp)
	lw	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.align	2
	.globl	w_expect
w_expect:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	lw	a5,-28(s0)
	ble	a5,zero,.L264
	lw	a5,-28(s0)
	li	a4,255
	ble	a5,a4,.L258
	li	a5,255
.L258:
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	addi	a5,a5,1
# DELETED LUI: 	lui	a4,%hi(tmp_buf)
	la a4, tmp_buf
	sw	a4,-44(s0)
	sw	a5,-48(s0)
	lw	a5,-44(s0)
	sw	a5,-52(s0)
	lw	a5,-48(s0)
	sw	a5,-56(s0)
	lw	a5,-52(s0)
	lw	a4,-56(s0)
 #APP
# 23 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	li a7, 8
	ecall
# 0 "" 2
 #NO_APP
	nop
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L259
.L263:
# DELETED LUI: 	lui	a5,%hi(tmp_buf)
	la a4, tmp_buf
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sb	a5,-37(s0)
	lbu	a5,-37(s0)
	beq	a5,zero,.L265
	lbu	a4,-37(s0)
	li	a5,10
	beq	a4,a5,.L266
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a4,-37(s0)
	mv	a1,a4
	mv	a0,a5
	call	byte_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L259:
	lw	a4,-24(s0)
	lw	a5,-36(s0)
	blt	a4,a5,.L263
	j	.L261
.L265:
	nop
	j	.L261
.L266:
	nop
.L261:
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	li	a1,0
	mv	a0,a5
	call	byte_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	lw	a4,-28(s0)
	ble	a4,a5,.L255
	lw	a4,-32(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	addi	a5,a5,1
	li	a1,0
	mv	a0,a5
	call	byte_store
	j	.L255
.L264:
	nop
.L255:
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.align	2
	.globl	w_query
w_query:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
# DELETED LUI: 	lui	a5,%hi(tmp_buf)
	la a5, tmp_buf
	sw	a5,-32(s0)
	li	a5,81
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-44(s0)
	lw	a5,-40(s0)
	lw	a4,-44(s0)
 #APP
# 23 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	li a7, 8
	ecall
# 0 "" 2
 #NO_APP
	nop
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L268
.L270:
# DELETED LUI: 	lui	a5,%hi(tmp_buf)
	la a4, tmp_buf
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	beq	a5,zero,.L269
	lbu	a4,-25(s0)
	li	a5,10
	beq	a4,a5,.L269
	lw	a5,-20(s0)
	addi	a5,a5,16
	lbu	a4,-25(s0)
	mv	a1,a4
	mv	a0,a5
	call	byte_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L268:
	lw	a4,-24(s0)
	li	a5,79
	ble	a4,a5,.L270
.L269:
	lw	a5,-20(s0)
	addi	a5,a5,16
	li	a1,0
	mv	a0,a5
	call	byte_store
	li	a1,0
	li	a0,4
	call	cell_store
	li	a1,0
	li	a0,6
	call	cell_store
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_abort
w_abort:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	zero,0(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	zero,260(a5)
	li	a1,0
	li	a0,0
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	li	a4,1
	la t6, abort_flag
	sw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(exit_flag)
	la t6, exit_flag
	sw zero, 0(t6)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_quit_word
w_quit_word:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	sw	zero,260(a5)
	li	a1,0
	li	a0,0
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	li	a4,1
	la t6, abort_flag
	sw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(exit_flag)
	la t6, exit_flag
	sw zero, 0(t6)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_bl
w_bl:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,32
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_79_standard
w_79_standard:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	read_next_name
read_next_name:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	li	a0,32
	call	push
	call	w_word
	call	pop
	sw	a0,-24(s0)
	lw	a0,-24(s0)
	call	byte_fetch
	sw	a0,-28(s0)
	lw	a5,-28(s0)
	bne	a5,zero,.L276
	lw	a5,-36(s0)
	sb	zero,0(a5)
	li	a5,0
	j	.L277
.L276:
	lw	a5,-28(s0)
	li	a4,31
	ble	a5,a4,.L278
	li	a5,31
.L278:
	sw	a5,-32(s0)
	sw	zero,-20(s0)
	j	.L279
.L280:
	lw	a5,-24(s0)
	addi	a4,a5,1
	lw	a5,-20(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a3,a0
	lw	a5,-20(s0)
	lw	a4,-36(s0)
	add	a5,a4,a5
	andi	a4,a3,0xff
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L279:
	lw	a4,-20(s0)
	lw	a5,-32(s0)
	blt	a4,a5,.L280
	lw	a5,-32(s0)
	lw	a4,-36(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	lw	a5,-32(s0)
.L277:
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
.data
	.align	2
.LC8:
	.string	"CREATE: no name\n"
	.text
	.align	2
	.globl	w_create
w_create:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	addi	a5,s0,-56
	mv	a0,a5
	call	read_next_name
	mv	a5,a0
	bne	a5,zero,.L282
# DELETED LUI: 	lui	a5,%hi(.LC8)
	la a5, .LC8
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L281
.L282:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,520(a5)
	addi	a5,s0,-56
	li	a3,0
	mv	a2,a4
	li	a1,0
	mv	a0,a5
	call	create_word
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,2
	sw	a4,52(a5)
.L281:
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
.data
	.align	2
.LC9:
	.string	"VOCABULARY: no name\n"
	.text
	.align	2
	.globl	w_vocabulary
w_vocabulary:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	addi	a5,s0,-56
	mv	a0,a5
	call	read_next_name
	mv	a5,a0
	bne	a5,zero,.L286
# DELETED LUI: 	lui	a5,%hi(.LC9)
	la a5, .LC9
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L285
.L286:
# DELETED LUI: 	lui	a5,%hi(vocab_count)
	la t6, vocab_count
	lw a4, 0(t6)
	addi	a5,s0,-56
	li	a3,0
	mv	a2,a4
	li	a1,0
	mv	a0,a5
	call	create_word
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,5
	sw	a4,52(a5)
# DELETED LUI: 	lui	a5,%hi(vocab_count)
	la t6, vocab_count
	lw a5, 0(t6)
	addi	a4,a5,1
# DELETED LUI: 	lui	a5,%hi(vocab_count)
	la t6, vocab_count
	sw a4, 0(t6)
.L285:
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.align	2
	.globl	w_does
w_does:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	beq	a5,zero,.L292
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a5,a5,-1
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,4
	sw	a4,52(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a3,524(a5)
# DELETED LUI: 	lui	a5,%hi(dict)
	la a2, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a2,a5
	sw	a3,44(a5)
# DELETED LUI: 	lui	a5,%hi(exit_flag)
	li	a4,1
	la t6, exit_flag
	sw a4, 0(t6)
	j	.L289
.L292:
	nop
.L289:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_compile
w_compile:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	cell_fetch
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
	lw	a0,-20(s0)
	call	comma
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC10:
	.string	"[COMPILE]: no name\n"
	.align	2
.LC11:
	.string	"? "
	.align	2
.LC12:
	.string	"\n"
	.text
	.align	2
	.globl	w_bracket_compile
w_bracket_compile:
	addi	sp,sp,-96
	sw	ra,92(sp)
	sw	s0,88(sp)
	addi	s0,sp,96
	addi	a5,s0,-84
	mv	a0,a5
	call	read_next_name
	mv	a5,a0
	bne	a5,zero,.L295
# DELETED LUI: 	lui	a5,%hi(.LC10)
	la a5, .LC10
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L294
.L295:
	addi	a5,s0,-84
	mv	a0,a5
	call	find_id
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	bge	a5,zero,.L297
# DELETED LUI: 	lui	a5,%hi(.LC11)
	la a5, .LC11
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	sw	a5,-52(s0)
	lw	a5,-52(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	addi	a5,s0,-84
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	sw	a5,-44(s0)
	lw	a5,-44(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
# DELETED LUI: 	lui	a5,%hi(.LC12)
	la a5, .LC12
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L294
.L297:
	lw	a0,-20(s0)
	call	comma
.L294:
	lw	ra,92(sp)
	lw	s0,88(sp)
	addi	sp,sp,96
	jr	ra
	.align	2
pack_d:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a5,-24(s0)
	slli	a4,a5,16
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	or	a5,a4,a5
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
push_d:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,16
	srli	a5,a5,16
	mv	a0,a5
	call	push
	lw	a5,-20(s0)
	srli	a5,a5,16
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_d_plus
w_d_plus:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	lw	a1,-28(s0)
	lw	a0,-32(s0)
	call	pack_d
	sw	a0,-36(s0)
	lw	a1,-20(s0)
	lw	a0,-24(s0)
	call	pack_d
	sw	a0,-40(s0)
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	push_d
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_d_lt
w_d_lt:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	lw	a1,-28(s0)
	lw	a0,-32(s0)
	call	pack_d
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a1,-20(s0)
	lw	a0,-24(s0)
	call	pack_d
	mv	a5,a0
	sw	a5,-40(s0)
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	slt	a5,a4,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_d_negate
w_d_negate:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a1,-20(s0)
	lw	a0,-24(s0)
	call	pack_d
	sw	a0,-28(s0)
	lw	a5,-28(s0)
	neg	a5,a5
	mv	a0,a5
	call	push_d
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	hold_ptr
.data
	.align	2
hold_ptr:
	.space 4
	.text
	.align	2
	.globl	w_less_sharp
w_less_sharp:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	li	a4,1232
	la t6, hold_ptr
	sw a4, 0(t6)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_hold
w_hold:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	mv	a5,a0
	andi	a5,a5,255
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a4, 0(t6)
	li	a5,1200
	ble	a4,a5,.L308
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	sw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	lw	a1,-20(s0)
	mv	a0,a5
	call	byte_store
.L308:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
sharp_one:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	lw	a1,-24(s0)
	lw	a0,-28(s0)
	call	pack_d
	sw	a0,-32(s0)
	call	current_base
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	lw	a4,-32(s0)
	remu	a5,a4,a5
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	lw	a4,-32(s0)
	divu	a5,a4,a5
	sw	a5,-44(s0)
	lw	a4,-40(s0)
	li	a5,9
	bgtu	a4,a5,.L310
	lw	a5,-40(s0)
	addi	a5,a5,48
	sw	a5,-20(s0)
	j	.L311
.L310:
	lw	a5,-40(s0)
	addi	a5,a5,55
	sw	a5,-20(s0)
.L311:
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a4, 0(t6)
	li	a5,1200
	ble	a4,a5,.L312
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	sw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	lw	a1,-20(s0)
	mv	a0,a5
	call	byte_store
.L312:
	lw	a0,-44(s0)
	call	push_d
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_sharp
w_sharp:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	sharp_one
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_sharp_s
w_sharp_s:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
.L317:
	call	sharp_one
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-2
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	sw	a5,-24(s0)
	lw	a1,-20(s0)
	lw	a0,-24(s0)
	call	pack_d
	mv	a5,a0
	beq	a5,zero,.L319
	j	.L317
.L319:
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_sharp_greater
w_sharp_greater:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	call	pop
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	li	a4,1232
	sub	a5,a4,a5
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	mv	a0,a5
	call	push
	lw	a0,-20(s0)
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_sign
w_sign:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	bge	a5,zero,.L323
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a4, 0(t6)
	li	a5,1200
	ble	a4,a5,.L323
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	sw a4, 0(t6)
# DELETED LUI: 	lui	a5,%hi(hold_ptr)
	la t6, hold_ptr
	lw a5, 0(t6)
	li	a1,45
	mv	a0,a5
	call	byte_store
.L323:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	block_dirty
.data
	.align	2
block_dirty:
	.space 128
	.globl	last_block
.data
	.align	2
last_block:
	.word	-1
	.globl	tib_save
.data
	.align	2
tib_save:
	.space 1024
	.globl	load_buf
	.align	2
load_buf:
	.space 1025
	.text
	.align	2
	.globl	block_addr
block_addr:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	blt	a5,zero,.L325
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L326
.L325:
	li	a5,-1
	j	.L327
.L326:
	lw	a5,-20(s0)
	addi	a5,a5,24
	slli	a5,a5,10
.L327:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC13:
	.string	"BLOCK err\n"
	.text
	.align	2
	.globl	w_block
w_block:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	block_addr
	sw	a0,-24(s0)
	lw	a5,-24(s0)
	bge	a5,zero,.L329
# DELETED LUI: 	lui	a5,%hi(.LC13)
	la a5, .LC13
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	li	a0,0
	call	push
	j	.L328
.L329:
# DELETED LUI: 	lui	a5,%hi(last_block)
	lw	a4,-20(s0)
	la t6, last_block
	sw a4, 0(t6)
	lw	a0,-24(s0)
	call	push
.L328:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC14:
	.string	"BUFFER err\n"
	.text
	.align	2
	.globl	w_buffer
w_buffer:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	block_addr
	sw	a0,-24(s0)
	lw	a5,-24(s0)
	bge	a5,zero,.L332
# DELETED LUI: 	lui	a5,%hi(.LC14)
	la a5, .LC14
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	li	a0,0
	call	push
	j	.L331
.L332:
# DELETED LUI: 	lui	a5,%hi(last_block)
	lw	a4,-20(s0)
	la t6, last_block
	sw a4, 0(t6)
	lw	a0,-24(s0)
	call	push
.L331:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_update
w_update:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(last_block)
	la t6, last_block
	lw a5, 0(t6)
	blt	a5,zero,.L336
# DELETED LUI: 	lui	a5,%hi(last_block)
	la t6, last_block
	lw a5, 0(t6)
# DELETED LUI: 	lui	a4,%hi(block_dirty)
	la a4, block_dirty
	slli	a5,a5,2
	add	a5,a4,a5
	li	a4,1
	sw	a4,0(a5)
.L336:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_empty_buffers
w_empty_buffers:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	j	.L338
.L339:
# DELETED LUI: 	lui	a5,%hi(block_dirty)
	la a4, block_dirty
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L338:
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L339
# DELETED LUI: 	lui	a5,%hi(last_block)
	li	a4,-1
	la t6, last_block
	sw a4, 0(t6)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	BLK_FILE
.data
	.align	2
BLK_FILE:
	.string	"forth.blk"
	.align	2
.LC15:
	.string	"SAVE-BUFFERS err\n"
	.text
	.align	2
	.globl	w_save_buffers
w_save_buffers:
	addi	sp,sp,-96
	sw	ra,92(sp)
	sw	s0,88(sp)
	addi	s0,sp,96
# DELETED LUI: 	lui	a5,%hi(BLK_FILE)
	la a5, BLK_FILE
	sw	a5,-32(s0)
	li	a5,1
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-44(s0)
	lw	a5,-40(s0)
	lw	a4,-44(s0)
 #APP
# 43 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	li a7, 1024
	ecall
	mv a5, a0
# 0 "" 2
 #NO_APP
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	bge	a5,zero,.L342
# DELETED LUI: 	lui	a5,%hi(.LC15)
	la a5, .LC15
	sw	a5,-52(s0)
	lw	a5,-52(s0)
	sw	a5,-56(s0)
	lw	a5,-56(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L340
.L342:
	sw	zero,-20(s0)
	j	.L344
.L346:
	lw	a5,-20(s0)
	addi	a5,a5,24
	slli	a5,a5,10
	addi	a4,a5,512
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	add	a5,a4,a5
	addi	a5,a5,8
	lw	a4,-28(s0)
	sw	a4,-60(s0)
	sw	a5,-64(s0)
	li	a5,1024
	sw	a5,-68(s0)
	lw	a5,-60(s0)
	sw	a5,-72(s0)
	lw	a5,-64(s0)
	sw	a5,-76(s0)
	lw	a5,-68(s0)
	sw	a5,-80(s0)
	lw	a5,-72(s0)
	lw	a4,-76(s0)
	lw	a3,-80(s0)
 #APP
# 66 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	mv a2, a3
	li a7, 64
	ecall
	mv a5, a0
# 0 "" 2
 #NO_APP
	sw	a5,-84(s0)
	nop
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L344:
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L346
	lw	a5,-28(s0)
	sw	a5,-88(s0)
	lw	a5,-88(s0)
	sw	a5,-92(s0)
	lw	a5,-92(s0)
 #APP
# 52 "rars_lib.h" 1
	mv a0, a5
	li a7, 57
	ecall
# 0 "" 2
 #NO_APP
	nop
	sw	zero,-24(s0)
	j	.L347
.L348:
# DELETED LUI: 	lui	a5,%hi(block_dirty)
	la a4, block_dirty
	lw	a5,-24(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L347:
	lw	a4,-24(s0)
	li	a5,31
	ble	a4,a5,.L348
.L340:
	lw	ra,92(sp)
	lw	s0,88(sp)
	addi	sp,sp,96
	jr	ra
	.align	2
	.globl	load_blocks_file
load_blocks_file:
	addi	sp,sp,-112
	sw	ra,108(sp)
	sw	s0,104(sp)
	addi	s0,sp,112
# DELETED LUI: 	lui	a5,%hi(BLK_FILE)
	la a5, BLK_FILE
	sw	a5,-32(s0)
	li	a5,9
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-44(s0)
	lw	a5,-40(s0)
	lw	a4,-44(s0)
 #APP
# 43 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	li a7, 1024
	ecall
	mv a5, a0
# 0 "" 2
 #NO_APP
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	blt	a5,zero,.L351
	lw	a5,-24(s0)
	sw	a5,-52(s0)
	lw	a5,-52(s0)
	sw	a5,-56(s0)
	lw	a5,-56(s0)
 #APP
# 52 "rars_lib.h" 1
	mv a0, a5
	li a7, 57
	ecall
# 0 "" 2
 #NO_APP
	nop
.L351:
# DELETED LUI: 	lui	a5,%hi(BLK_FILE)
	la a5, BLK_FILE
	sw	a5,-60(s0)
	sw	zero,-64(s0)
	lw	a5,-60(s0)
	sw	a5,-68(s0)
	lw	a5,-64(s0)
	sw	a5,-72(s0)
	lw	a5,-68(s0)
	lw	a4,-72(s0)
 #APP
# 43 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	li a7, 1024
	ecall
	mv a5, a0
# 0 "" 2
 #NO_APP
	sw	a5,-76(s0)
	lw	a5,-76(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	blt	a5,zero,.L360
	sw	zero,-20(s0)
	j	.L355
.L359:
	lw	a5,-20(s0)
	addi	a5,a5,24
	slli	a5,a5,10
	addi	a4,a5,512
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	add	a5,a4,a5
	addi	a5,a5,8
	lw	a4,-24(s0)
	sw	a4,-80(s0)
	sw	a5,-84(s0)
	li	a5,1024
	sw	a5,-88(s0)
	lw	a5,-80(s0)
	sw	a5,-92(s0)
	lw	a5,-84(s0)
	sw	a5,-96(s0)
	lw	a5,-88(s0)
	sw	a5,-100(s0)
	lw	a5,-92(s0)
	lw	a4,-96(s0)
	lw	a3,-100(s0)
 #APP
# 57 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	mv a2, a3
	li a7, 63
	ecall
	mv a5, a0
# 0 "" 2
 #NO_APP
	sw	a5,-104(s0)
	lw	a5,-104(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	ble	a5,zero,.L361
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L355:
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L359
	j	.L358
.L361:
	nop
.L358:
	lw	a5,-24(s0)
	sw	a5,-108(s0)
	lw	a5,-108(s0)
	sw	a5,-112(s0)
	lw	a5,-112(s0)
 #APP
# 52 "rars_lib.h" 1
	mv a0, a5
	li a7, 57
	ecall
# 0 "" 2
 #NO_APP
	j	.L349
.L360:
	nop
.L349:
	lw	ra,108(sp)
	lw	s0,104(sp)
	addi	sp,sp,112
	jr	ra
.data
	.align	2
.LC16:
	.string	"LIST err\n"
	.text
	.align	2
	.globl	w_list
w_list:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	call	pop
	sw	a0,-32(s0)
	lw	a0,-32(s0)
	call	block_addr
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	bge	a5,zero,.L363
# DELETED LUI: 	lui	a5,%hi(.LC16)
	la a5, .LC16
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	sw	a5,-44(s0)
	lw	a5,-44(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L362
.L363:
# DELETED LUI: 	lui	a5,%hi(last_block)
	lw	a4,-32(s0)
	la t6, last_block
	sw a4, 0(t6)
	lw	a1,-32(s0)
	li	a0,8
	call	cell_store
	sw	zero,-20(s0)
	j	.L365
.L369:
	sw	zero,-24(s0)
	j	.L366
.L368:
	lw	a5,-20(s0)
	slli	a4,a5,6
	lw	a5,-36(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	sw	a0,-28(s0)
	lw	a5,-28(s0)
	bne	a5,zero,.L367
	li	a5,32
	sw	a5,-28(s0)
.L367:
	lw	a5,-28(s0)
	andi	a5,a5,0xff
	sb	a5,-45(s0)
	lbu	a5,-45(s0)
	sw	a5,-52(s0)
	lw	a5,-52(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L366:
	lw	a4,-24(s0)
	li	a5,63
	ble	a4,a5,.L368
	li	a5,10
	sb	a5,-53(s0)
	lbu	a5,-53(s0)
	sw	a5,-60(s0)
	lw	a5,-60(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L365:
	lw	a4,-20(s0)
	li	a5,15
	ble	a4,a5,.L369
.L362:
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
.data
	.align	2
.LC17:
	.string	"LOAD err\n"
	.text
	.align	2
	.globl	w_load
w_load:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	call	pop
	sw	a0,-32(s0)
	lw	a0,-32(s0)
	call	block_addr
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	bge	a5,zero,.L371
# DELETED LUI: 	lui	a5,%hi(.LC17)
	la a5, .LC17
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	sw	a5,-52(s0)
	lw	a5,-52(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L370
.L371:
	li	a0,6
	call	cell_fetch
	sw	a0,-40(s0)
	li	a0,4
	call	cell_fetch
	sw	a0,-44(s0)
	sw	zero,-20(s0)
	j	.L373
.L374:
	lw	a5,-20(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	andi	a4,a5,0xff
# DELETED LUI: 	lui	a5,%hi(tib_save)
	la a3, tib_save
	lw	a5,-20(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L373:
	lw	a4,-20(s0)
	li	a5,1023
	ble	a4,a5,.L374
	sw	zero,-24(s0)
	j	.L375
.L376:
	lw	a4,-36(s0)
	lw	a5,-24(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	andi	a4,a5,0xff
# DELETED LUI: 	lui	a5,%hi(load_buf)
	la a3, load_buf
	lw	a5,-24(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L375:
	lw	a4,-24(s0)
	li	a5,1023
	ble	a4,a5,.L376
# DELETED LUI: 	lui	a5,%hi(load_buf)
	la a5, load_buf
	sb	zero,1024(a5)
	lw	a1,-32(s0)
	li	a0,6
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(load_buf)
	la a0, load_buf
	call	eval
	lw	a1,-40(s0)
	li	a0,6
	call	cell_store
	sw	zero,-28(s0)
	j	.L377
.L378:
	lw	a5,-28(s0)
	addi	a3,a5,16
# DELETED LUI: 	lui	a5,%hi(tib_save)
	la a4, tib_save
	lw	a5,-28(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	byte_store
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L377:
	lw	a4,-28(s0)
	li	a5,1023
	ble	a4,a5,.L378
	lw	a1,-44(s0)
	li	a0,4
	call	cell_store
.L370:
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.align	2
	.globl	w_convert
w_convert:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-28(s0)
	call	pop
	sw	a0,-32(s0)
	call	pop
	sw	a0,-36(s0)
	lw	a1,-32(s0)
	lw	a0,-36(s0)
	call	pack_d
	sw	a0,-20(s0)
	call	current_base
	sw	a0,-40(s0)
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L382:
	lw	a0,-24(s0)
	call	byte_fetch
	sw	a0,-44(s0)
	lw	a1,-40(s0)
	lw	a0,-44(s0)
	call	digit_value
	sw	a0,-48(s0)
	lw	a5,-48(s0)
	blt	a5,zero,.L384
	lw	a4,-40(s0)
	lw	a5,-20(s0)
	mul	a4,a4,a5
	lw	a5,-48(s0)
	add	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	j	.L382
.L384:
	nop
	lw	a0,-20(s0)
	call	push_d
	lw	a0,-24(s0)
	call	push
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
.data
	.align	2
.LC18:
	.string	"FORGET: no name\n"
	.align	2
.LC19:
	.string	"FORGET: not found\n"
	.text
	.align	2
	.globl	w_forget
w_forget:
	addi	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	addi	s0,sp,80
	addi	a5,s0,-68
	mv	a0,a5
	call	read_next_name
	mv	a5,a0
	bne	a5,zero,.L386
# DELETED LUI: 	lui	a5,%hi(.LC18)
	la a5, .LC18
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L385
.L386:
	addi	a5,s0,-68
	mv	a0,a5
	call	find_id
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	bge	a5,zero,.L388
# DELETED LUI: 	lui	a5,%hi(.LC19)
	la a5, .LC19
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L385
.L388:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,40(a5)
	li	a5,1231
	ble	a4,a5,.L389
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,52(a5)
	beq	a5,zero,.L389
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,52(a5)
	li	a5,3
	beq	a4,a5,.L389
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a4,40(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,520(a5)
.L389:
# DELETED LUI: 	lui	a5,%hi(dict_len)
	lw	a4,-20(s0)
	la t6, dict_len
	sw a4, 0(t6)
.L385:
	lw	ra,76(sp)
	lw	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.align	2
	.globl	w_dup
w_dup:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	ble	a5,zero,.L393
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a0,a5
	call	push
.L393:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_drop
w_drop:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_swap
w_swap:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a0,-20(s0)
	call	push
	lw	a0,-24(s0)
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_over
w_over:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,0(a5)
	li	a5,1
	ble	a4,a5,.L398
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	addi	a5,a5,-2
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,4(a5)
	mv	a0,a5
	call	push
.L398:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_rot
w_rot:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	call	pop
	sw	a0,-28(s0)
	lw	a0,-24(s0)
	call	push
	lw	a0,-20(s0)
	call	push
	lw	a0,-28(s0)
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_dot
w_dot:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	current_base
	mv	a5,a0
	mv	a1,a5
	lw	a0,-20(s0)
	call	print_in_base
	li	a5,32
	sb	a5,-21(s0)
	lbu	a5,-21(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_u_dot
w_u_dot:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	mv	a5,a0
	slli	a5,a5,16
	srli	a5,a5,16
	sw	a5,-20(s0)
	call	current_base
	mv	a5,a0
	mv	a1,a5
	lw	a0,-20(s0)
	call	print_in_base_unsigned
	li	a5,32
	sb	a5,-21(s0)
	lbu	a5,-21(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_cr
w_cr:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(.LC12)
	la a5, .LC12
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_emit
w_emit:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	sb	a5,-18(s0)
	lbu	a5,-18(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_key
w_key:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
 #APP
# 37 "rars_lib.h" 1
	li a7, 12
	ecall
	mv a5, a0
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_space
w_space:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,32
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_spaces
w_spaces:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-24(s0)
	sw	zero,-20(s0)
	j	.L408
.L409:
	li	a5,32
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L408:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L409
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_hex
w_hex:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,16
	li	a0,2
	call	cell_store
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_question
w_question:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	cell_fetch
	mv	a5,a0
	mv	a0,a5
	call	push
	call	w_dot
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_eq
w_eq:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	sw	s1,4(sp)
	addi	s0,sp,16
	call	pop
	mv	s1,a0
	call	pop
	mv	a5,a0
	sub	a5,s1,a5
	seqz	a5,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	lw	s1,4(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_gt
w_gt:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	sgt	a5,a4,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_lt
w_lt:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	slt	a5,a4,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_store
w_store:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a1,-24(s0)
	lw	a0,-20(s0)
	call	cell_store
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_fetch
w_fetch:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	cell_fetch
	mv	a5,a0
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_c_store
w_c_store:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a1,-24(s0)
	lw	a0,-20(s0)
	call	byte_store
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_c_fetch
w_c_fetch:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	byte_fetch
	mv	a5,a0
	mv	a0,a5
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_here
w_here:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_allot
w_allot:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a3,a0
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	add	a4,a3,a5
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,520(a5)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_comma_op
w_comma_op:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	mv	a0,a5
	call	comma
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_c_comma_op
w_c_comma_op:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	call	pop
	mv	a5,a0
	mv	a0,a5
	call	c_comma
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_state
w_state:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,0
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_base
w_base:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,2
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_in
w_in:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,4
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_blk
w_blk:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,6
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_scr
w_scr:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,8
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_pad
w_pad:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,1040
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_context
w_context:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,10
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_current
w_current:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,12
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_decimal
w_decimal:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,10
	li	a0,2
	call	cell_store
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_depth
w_depth:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,0(a5)
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_definitions
w_definitions:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a0,10
	call	cell_fetch
	mv	a5,a0
	mv	a1,a5
	li	a0,12
	call	cell_store
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.data
	.align	2
.LC20:
	.string	"LIT"
	.text
	.align	2
	.globl	w_literal
w_literal:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(.LC20)
	la a0, .LC20
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	lw	a0,-20(s0)
	call	comma
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_exit
w_exit:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(in_user_word)
	la t6, in_user_word
	lw a5, 0(t6)
	ble	a5,zero,.L437
# DELETED LUI: 	lui	a5,%hi(exit_flag)
	li	a4,1
	la t6, exit_flag
	sw a4, 0(t6)
.L437:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_bye
w_bye:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
 #APP
# 27 "rars_lib.h" 1
	li a7, 10
	ecall
# 0 "" 2
 #NO_APP
	nop
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_lit
w_lit:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	cell_fetch
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
	lw	a0,-20(s0)
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_branch0
w_branch0:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	ucell_fetch
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
	call	pop
	mv	a5,a0
	bne	a5,zero,.L442
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,524(a5)
.L442:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_branch
w_branch:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	ucell_fetch
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,524(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC21:
	.string	"Exec Err\n"
	.text
	.align	2
	.globl	w_execute
w_execute:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-24(s0)
	lw	a5,-24(s0)
	blt	a5,zero,.L445
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	lw	a4,-24(s0)
	bge	a4,a5,.L445
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-24(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,52(a5)
	bne	a5,zero,.L445
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-24(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,36(a5)
	jalr	a5
	j	.L444
.L445:
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a5,a5,-1
	sw	a5,-20(s0)
	j	.L447
.L449:
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,52(a5)
	beq	a5,zero,.L448
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	lw	a4,-24(s0)
	bne	a4,a5,.L448
	lw	a0,-20(s0)
	call	execute_dict
	j	.L444
.L448:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-20(s0)
.L447:
	lw	a5,-20(s0)
	bge	a5,zero,.L449
	lw	a5,-24(s0)
	blt	a5,zero,.L450
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	lw	a4,-24(s0)
	bge	a4,a5,.L450
	lw	a0,-24(s0)
	call	execute_dict
	j	.L444
.L450:
# DELETED LUI: 	lui	a5,%hi(.LC21)
	la a5, .LC21
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
.L444:
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_do_run
w_do_run:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
	lw	a0,-24(s0)
	call	rpush
	lw	a0,-20(s0)
	call	rpush
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_loop_run
w_loop_run:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	rpop
	sw	a0,-20(s0)
	call	rpop
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	bge	a4,a5,.L453
	lw	a0,-24(s0)
	call	rpush
	lw	a0,-20(s0)
	call	rpush
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	ucell_fetch
	mv	a3,a0
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	sw	a3,524(a5)
	j	.L455
.L453:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
.L455:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_plus_loop_run
w_plus_loop_run:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	pop
	sw	a0,-24(s0)
	call	rpop
	sw	a0,-28(s0)
	call	rpop
	sw	a0,-32(s0)
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	add	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-24(s0)
	blt	a5,zero,.L457
	lw	a4,-36(s0)
	lw	a5,-32(s0)
	slt	a5,a4,a5
	andi	a5,a5,0xff
	sw	a5,-20(s0)
	j	.L458
.L457:
	lw	a4,-36(s0)
	lw	a5,-32(s0)
	slt	a5,a4,a5
	seqz	a5,a5
	andi	a5,a5,0xff
	sw	a5,-20(s0)
.L458:
	lw	a5,-20(s0)
	beq	a5,zero,.L459
	lw	a0,-32(s0)
	call	rpush
	lw	a0,-36(s0)
	call	rpush
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	ucell_fetch
	mv	a3,a0
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	sw	a3,524(a5)
	j	.L461
.L459:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
.L461:
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.align	2
	.globl	w_i
w_i:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	ble	a5,zero,.L464
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	addi	a5,a5,64
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,8(a5)
	mv	a0,a5
	call	push
.L464:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_j
w_j:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,260(a5)
	li	a5,2
	ble	a4,a5,.L467
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	addi	a5,a5,-3
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	addi	a5,a5,64
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,8(a5)
	mv	a0,a5
	call	push
.L467:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_leave
w_leave:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a4,260(a5)
	li	a5,1
	ble	a4,a5,.L470
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	addi	a5,a5,-1
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	addi	a5,a5,64
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,8(a5)
	sw	a5,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a5, vm
	lw	a5,260(a5)
	addi	a5,a5,-2
# DELETED LUI: 	lui	a4,%hi(vm)
	la a4, vm
	addi	a5,a5,64
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,8(a5)
.L470:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_print_str
w_print_str:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	cell_fetch
	sw	a0,-24(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
	sw	zero,-20(s0)
	j	.L472
.L473:
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	andi	a5,a5,0xff
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,1
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L472:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	blt	a4,a5,.L473
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	andi	a5,a5,1
	beq	a5,zero,.L475
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,524(a5)
	addi	a4,a5,1
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,524(a5)
.L475:
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	creating_word
.data
	.align	2
creating_word:
	.space 4
	.globl	tick_pending
	.align	2
tick_pending:
	.space 4
	.text
	.align	2
	.globl	w_colon
w_colon:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(creating_word)
	li	a4,1
	la t6, creating_word
	sw a4, 0(t6)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.data
	.align	2
.LC22:
	.string	"EXIT"
	.text
	.align	2
	.globl	w_semicolon
w_semicolon:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(.LC22)
	la a0, .LC22
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	li	a1,0
	li	a0,0
	call	cell_store
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_lbracket
w_lbracket:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,0
	li	a0,0
	call	cell_store
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_rbracket
w_rbracket:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,1
	li	a0,0
	call	cell_store
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_immediate
w_immediate:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	ble	a5,zero,.L482
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,1
	sw	a4,48(a5)
.L482:
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_tick
w_tick:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(tick_pending)
	li	a4,1
	la t6, tick_pending
	sw a4, 0(t6)
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.data
	.align	2
.LC23:
	.string	"0BRANCH"
	.text
	.align	2
	.globl	w_if
w_if:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(.LC23)
	la a0, .LC23
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a0,a5
	call	push
	li	a0,0
	call	comma
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_then
w_then:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a1,a5
	lw	a0,-20(s0)
	call	cell_store
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC24:
	.string	"BRANCH"
	.text
	.align	2
	.globl	w_else
w_else:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(.LC24)
	la a0, .LC24
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	sw	a5,-20(s0)
	li	a0,0
	call	comma
	call	pop
	sw	a0,-24(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a1,a5
	lw	a0,-24(s0)
	call	cell_store
	lw	a0,-20(s0)
	call	push
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_begin
w_begin:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_until
w_until:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(.LC23)
	la a0, .LC23
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	call	pop
	mv	a5,a0
	mv	a0,a5
	call	comma
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.data
	.align	2
.LC25:
	.string	"(DO)"
	.text
	.align	2
	.globl	w_do
w_do:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(.LC25)
	la a0, .LC25
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a0,a5
	call	push
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.data
	.align	2
.LC26:
	.string	"(LOOP)"
	.text
	.align	2
	.globl	w_loop
w_loop:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(.LC26)
	la a0, .LC26
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	comma
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
.data
	.align	2
.LC27:
	.string	"(+LOOP)"
	.text
	.align	2
	.globl	w_plus_loop
w_plus_loop:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
# DELETED LUI: 	lui	a5,%hi(.LC27)
	la a0, .LC27
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	call	pop
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	comma
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_while
w_while:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(.LC23)
	la a0, .LC23
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a0,a5
	call	push
	li	a0,0
	call	comma
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.align	2
	.globl	w_repeat
w_repeat:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	pop
	sw	a0,-20(s0)
	call	pop
	sw	a0,-24(s0)
# DELETED LUI: 	lui	a5,%hi(.LC24)
	la a0, .LC24
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	lw	a0,-24(s0)
	call	comma
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	mv	a1,a5
	lw	a0,-20(s0)
	call	cell_store
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.align	2
	.globl	w_recurse
w_recurse:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a5,a5,-1
	mv	a0,a5
	call	comma
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.globl	mode_var
.data
	.align	2
mode_var:
	.space 4
	.globl	token_buf
.data
	.align	2
token_buf:
	.space 64
.data
	.align	2
.LC28:
	.string	"(.\")"
	.align	2
.LC29:
	.string	"Tick err\n"
	.align	2
.LC30:
	.string	"VARIABLE"
	.align	2
.LC31:
	.string	"CONSTANT"
	.text
	.align	2
	.globl	eval
eval:
	addi	sp,sp,-160
	sw	ra,156(sp)
	sw	s0,152(sp)
	addi	s0,sp,160
	sw	a0,-148(s0)
	sw	zero,-20(s0)
	j	.L496
.L498:
	lw	a5,-20(s0)
	lw	a4,-148(s0)
	add	a5,a4,a5
	lbu	a4,0(a5)
	li	a5,10
	beq	a4,a5,.L497
	lw	a5,-20(s0)
	lw	a4,-148(s0)
	add	a5,a4,a5
	lbu	a4,0(a5)
	li	a5,13
	beq	a4,a5,.L497
	lw	a5,-20(s0)
	addi	a3,a5,16
	lw	a5,-20(s0)
	lw	a4,-148(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	byte_store
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L496:
	lw	a4,-20(s0)
	li	a5,1022
	bgt	a4,a5,.L497
	lw	a5,-20(s0)
	lw	a4,-148(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L498
.L497:
	lw	a5,-20(s0)
	addi	a5,a5,16
	li	a1,0
	mv	a0,a5
	call	byte_store
	li	a1,0
	li	a0,4
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	la t6, abort_flag
	sw zero, 0(t6)
.L544:
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	la t6, abort_flag
	lw a5, 0(t6)
	beq	a5,zero,.L499
# DELETED LUI: 	lui	a5,%hi(abort_flag)
	la t6, abort_flag
	sw zero, 0(t6)
	j	.L495
.L499:
	li	a0,4
	call	cell_fetch
	sw	a0,-24(s0)
.L504:
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	sw	a0,-52(s0)
	lw	a5,-52(s0)
	bne	a5,zero,.L501
	lw	a1,-24(s0)
	li	a0,4
	call	cell_store
	j	.L495
.L501:
	lw	a4,-52(s0)
	li	a5,32
	bgt	a4,a5,.L546
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	j	.L504
.L546:
	nop
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	sw	a0,-56(s0)
	lw	a4,-56(s0)
	li	a5,40
	bne	a4,a5,.L505
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L509:
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	sw	a0,-96(s0)
	lw	a5,-96(s0)
	beq	a5,zero,.L547
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-96(s0)
	li	a5,41
	beq	a4,a5,.L548
	j	.L509
.L547:
	nop
	j	.L507
.L548:
	nop
.L507:
	lw	a1,-24(s0)
	li	a0,4
	call	cell_store
	j	.L510
.L505:
	lw	a4,-56(s0)
	li	a5,46
	bne	a4,a5,.L511
	lw	a5,-24(s0)
	addi	a5,a5,17
	mv	a0,a5
	call	byte_fetch
	mv	a4,a0
	li	a5,34
	bne	a4,a5,.L511
	lw	a5,-24(s0)
	addi	a5,a5,2
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	mv	a4,a0
	li	a5,32
	bne	a4,a5,.L512
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L512:
	lw	a5,-24(s0)
	sw	a5,-60(s0)
	sw	zero,-28(s0)
.L514:
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	sw	a0,-64(s0)
	lw	a5,-64(s0)
	beq	a5,zero,.L513
	lw	a4,-64(s0)
	li	a5,34
	beq	a4,a5,.L513
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
	j	.L514
.L513:
	li	a0,0
	call	cell_fetch
	mv	a5,a0
	addi	a5,a5,-1
	seqz	a5,a5
	andi	a5,a5,0xff
	sw	a5,-68(s0)
	lw	a5,-68(s0)
	beq	a5,zero,.L515
# DELETED LUI: 	lui	a5,%hi(.LC28)
	la a0, .LC28
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	lw	a0,-28(s0)
	call	comma
	sw	zero,-32(s0)
	j	.L516
.L517:
	lw	a5,-60(s0)
	addi	a4,a5,16
	lw	a5,-32(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	mv	a0,a5
	call	c_comma
	lw	a5,-32(s0)
	addi	a5,a5,1
	sw	a5,-32(s0)
.L516:
	lw	a4,-32(s0)
	lw	a5,-28(s0)
	blt	a4,a5,.L517
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	andi	a5,a5,1
	beq	a5,zero,.L518
	li	a0,0
	call	c_comma
	j	.L518
.L515:
	sw	zero,-36(s0)
	j	.L519
.L520:
	lw	a5,-60(s0)
	addi	a4,a5,16
	lw	a5,-36(s0)
	add	a5,a4,a5
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	andi	a5,a5,0xff
	sb	a5,-97(s0)
	lbu	a5,-97(s0)
	sw	a5,-104(s0)
	lw	a5,-104(s0)
 #APP
# 32 "rars_lib.h" 1
	mv a0, a5
	li a7, 11
	ecall
# 0 "" 2
 #NO_APP
	nop
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L519:
	lw	a4,-36(s0)
	lw	a5,-28(s0)
	blt	a4,a5,.L520
.L518:
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	mv	a4,a0
	li	a5,34
	bne	a4,a5,.L521
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L521:
	lw	a1,-24(s0)
	li	a0,4
	call	cell_store
	j	.L510
.L511:
	sw	zero,-40(s0)
	sw	zero,-44(s0)
.L525:
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	sw	a0,-72(s0)
	lw	a5,-72(s0)
	beq	a5,zero,.L522
	lw	a4,-72(s0)
	li	a5,32
	ble	a4,a5,.L522
	lw	a4,-40(s0)
	li	a5,30
	bgt	a4,a5,.L523
	lw	a5,-40(s0)
	addi	a4,a5,1
	sw	a4,-40(s0)
	lw	a4,-72(s0)
	andi	a4,a4,0xff
# DELETED LUI: 	lui	a3,%hi(token_buf)
	la a3, token_buf
	add	a5,a3,a5
	sb	a4,0(a5)
.L523:
	lw	a4,-44(s0)
	li	a5,254
	bgt	a4,a5,.L524
	lw	a5,-44(s0)
	addi	a5,a5,1
	sw	a5,-44(s0)
.L524:
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
	j	.L525
.L522:
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a4, token_buf
	lw	a5,-40(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	byte_fetch
	mv	a5,a0
	beq	a5,zero,.L526
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L526:
	lw	a1,-24(s0)
	li	a0,4
	call	cell_store
	li	a0,0
	call	cell_fetch
	mv	a5,a0
	addi	a5,a5,-1
	seqz	a5,a5
	andi	a5,a5,0xff
	sw	a5,-76(s0)
# DELETED LUI: 	lui	a5,%hi(tick_pending)
	la t6, tick_pending
	lw a5, 0(t6)
	beq	a5,zero,.L527
	lw	a1,-44(s0)
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	find_id_lv
	sw	a0,-92(s0)
	lw	a4,-92(s0)
	li	a5,-1
	beq	a4,a5,.L528
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-92(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,52(a5)
	beq	a5,zero,.L529
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-92(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,40(a5)
	sw	a5,-48(s0)
	j	.L530
.L529:
	lw	a5,-92(s0)
	sw	a5,-48(s0)
.L530:
	lw	a5,-76(s0)
	beq	a5,zero,.L531
# DELETED LUI: 	lui	a5,%hi(.LC20)
	la a0, .LC20
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	lw	a0,-48(s0)
	call	comma
	j	.L532
.L531:
	lw	a0,-48(s0)
	call	push
	j	.L532
.L528:
# DELETED LUI: 	lui	a5,%hi(.LC29)
	la a5, .LC29
	sw	a5,-108(s0)
	lw	a5,-108(s0)
	sw	a5,-112(s0)
	lw	a5,-112(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
.L532:
# DELETED LUI: 	lui	a5,%hi(tick_pending)
	la t6, tick_pending
	sw zero, 0(t6)
	j	.L544
.L527:
# DELETED LUI: 	lui	a5,%hi(mode_var)
	la t6, mode_var
	lw a5, 0(t6)
	ble	a5,zero,.L533
# DELETED LUI: 	lui	a5,%hi(mode_var)
	la t6, mode_var
	lw a4, 0(t6)
	li	a5,1
	bne	a4,a5,.L534
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	li	a4,0
	mv	a3,a5
	li	a2,0
	lw	a1,-44(s0)
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	create_word_lv
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,2
	sw	a4,52(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	li	a1,0
	mv	a0,a5
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,520(a5)
.L534:
# DELETED LUI: 	lui	a5,%hi(mode_var)
	la t6, mode_var
	lw a4, 0(t6)
	li	a5,2
	bne	a4,a5,.L535
	call	pop
	sw	a0,-88(s0)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	li	a4,0
	mv	a3,a5
	li	a2,0
	lw	a1,-44(s0)
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	create_word_lv
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,3
	sw	a4,52(a5)
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	lw	a1,-88(s0)
	mv	a0,a5
	call	cell_store
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	addi	a4,a5,2
# DELETED LUI: 	lui	a5,%hi(vm)
	la a3, vm
	li	a5,65536
	add	a5,a3,a5
	sw	a4,520(a5)
.L535:
# DELETED LUI: 	lui	a5,%hi(mode_var)
	la t6, mode_var
	sw zero, 0(t6)
	j	.L544
.L533:
# DELETED LUI: 	lui	a5,%hi(creating_word)
	la t6, creating_word
	lw a5, 0(t6)
	beq	a5,zero,.L536
# DELETED LUI: 	lui	a5,%hi(vm)
	la a4, vm
	li	a5,65536
	add	a5,a4,a5
	lw	a5,520(a5)
	li	a4,0
	mv	a3,a5
	li	a2,0
	lw	a1,-44(s0)
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	create_word_lv
# DELETED LUI: 	lui	a5,%hi(creating_word)
	la t6, creating_word
	sw zero, 0(t6)
	li	a1,1
	li	a0,0
	call	cell_store
	j	.L544
.L536:
	lw	a1,-44(s0)
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	find_id_lv
	sw	a0,-80(s0)
# DELETED LUI: 	lui	a5,%hi(.LC30)
	la a1, .LC30
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	my_strcmp
	mv	a5,a0
	bne	a5,zero,.L537
# DELETED LUI: 	lui	a5,%hi(mode_var)
	li	a4,1
	la t6, mode_var
	sw a4, 0(t6)
	j	.L544
.L537:
# DELETED LUI: 	lui	a5,%hi(.LC31)
	la a1, .LC31
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	my_strcmp
	mv	a5,a0
	bne	a5,zero,.L538
# DELETED LUI: 	lui	a5,%hi(mode_var)
	li	a4,2
	la t6, mode_var
	sw a4, 0(t6)
	j	.L544
.L538:
	lw	a4,-80(s0)
	li	a5,-1
	beq	a4,a5,.L539
	lw	a5,-76(s0)
	beq	a5,zero,.L540
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	lw	a4,-80(s0)
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,48(a5)
	bne	a5,zero,.L540
	lw	a0,-80(s0)
	call	comma
	j	.L510
.L540:
	lw	a0,-80(s0)
	call	execute_dict
	j	.L544
.L539:
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	is_number
	mv	a5,a0
	beq	a5,zero,.L542
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a0, token_buf
	call	my_atoi
	sw	a0,-84(s0)
	lw	a5,-76(s0)
	beq	a5,zero,.L543
# DELETED LUI: 	lui	a5,%hi(.LC20)
	la a0, .LC20
	call	find_id
	mv	a5,a0
	mv	a0,a5
	call	comma
	lw	a0,-84(s0)
	call	comma
	j	.L544
.L543:
	lw	a0,-84(s0)
	call	push
	j	.L544
.L542:
# DELETED LUI: 	lui	a5,%hi(.LC11)
	la a5, .LC11
	sw	a5,-132(s0)
	lw	a5,-132(s0)
	sw	a5,-136(s0)
	lw	a5,-136(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
# DELETED LUI: 	lui	a5,%hi(token_buf)
	la a5, token_buf
	sw	a5,-124(s0)
	lw	a5,-124(s0)
	sw	a5,-128(s0)
	lw	a5,-128(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
# DELETED LUI: 	lui	a5,%hi(.LC12)
	la a5, .LC12
	sw	a5,-116(s0)
	lw	a5,-116(s0)
	sw	a5,-120(s0)
	lw	a5,-120(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
.L510:
	j	.L544
.L495:
	lw	ra,156(sp)
	lw	s0,152(sp)
	addi	sp,sp,160
	jr	ra
	.globl	input_buffer
.data
	.align	2
input_buffer:
	.space 512
.data
	.align	2
.LC32:
	.string	"+"
	.align	2
.LC33:
	.string	"-"
	.align	2
.LC34:
	.string	"*"
	.align	2
.LC35:
	.string	"/"
	.align	2
.LC36:
	.string	"MOD"
	.align	2
.LC37:
	.string	"/MOD"
	.align	2
.LC38:
	.string	"*/"
	.align	2
.LC39:
	.string	"*/MOD"
	.align	2
.LC40:
	.string	"1+"
	.align	2
.LC41:
	.string	"1-"
	.align	2
.LC42:
	.string	"2+"
	.align	2
.LC43:
	.string	"2-"
	.align	2
.LC44:
	.string	"ABS"
	.align	2
.LC45:
	.string	"NEGATE"
	.align	2
.LC46:
	.string	"MIN"
	.align	2
.LC47:
	.string	"MAX"
	.align	2
.LC48:
	.string	"0="
	.align	2
.LC49:
	.string	"NOT"
	.align	2
.LC50:
	.string	"0<"
	.align	2
.LC51:
	.string	"0>"
	.align	2
.LC52:
	.string	"AND"
	.align	2
.LC53:
	.string	"OR"
	.align	2
.LC54:
	.string	"XOR"
	.align	2
.LC55:
	.string	"U<"
	.align	2
.LC56:
	.string	"U*"
	.align	2
.LC57:
	.string	"U/MOD"
	.align	2
.LC58:
	.string	">R"
	.align	2
.LC59:
	.string	"R>"
	.align	2
.LC60:
	.string	"R@"
	.align	2
.LC61:
	.string	"?DUP"
	.align	2
.LC62:
	.string	"PICK"
	.align	2
.LC63:
	.string	"ROLL"
	.align	2
.LC64:
	.string	"+!"
	.align	2
.LC65:
	.string	"CMOVE"
	.align	2
.LC66:
	.string	"MOVE"
	.align	2
.LC67:
	.string	"FILL"
	.align	2
.LC68:
	.string	"COUNT"
	.align	2
.LC69:
	.string	"TYPE"
	.align	2
.LC70:
	.string	"-TRAILING"
	.align	2
.LC71:
	.string	"WORD"
	.align	2
.LC72:
	.string	"FIND"
	.align	2
.LC73:
	.string	"EXPECT"
	.align	2
.LC74:
	.string	"QUERY"
	.align	2
.LC75:
	.string	"ABORT"
	.align	2
.LC76:
	.string	"QUIT"
	.align	2
.LC77:
	.string	"BL"
	.align	2
.LC78:
	.string	"CREATE"
	.align	2
.LC79:
	.string	"DOES>"
	.align	2
.LC80:
	.string	"COMPILE"
	.align	2
.LC81:
	.string	"[COMPILE]"
	.align	2
.LC82:
	.string	"FORGET"
	.align	2
.LC83:
	.string	"D+"
	.align	2
.LC84:
	.string	"D<"
	.align	2
.LC85:
	.string	"DNEGATE"
	.align	2
.LC86:
	.string	"<#"
	.align	2
.LC87:
	.string	"#"
	.align	2
.LC88:
	.string	"#S"
	.align	2
.LC89:
	.string	"#>"
	.align	2
.LC90:
	.string	"HOLD"
	.align	2
.LC91:
	.string	"SIGN"
	.align	2
.LC92:
	.string	"CONVERT"
	.align	2
.LC93:
	.string	"CONTEXT"
	.align	2
.LC94:
	.string	"CURRENT"
	.align	2
.LC95:
	.string	"VOCABULARY"
	.align	2
.LC96:
	.string	"DEFINITIONS"
	.align	2
.LC97:
	.string	"FORTH"
	.align	2
.LC98:
	.string	"BLOCK"
	.align	2
.LC99:
	.string	"BUFFER"
	.align	2
.LC100:
	.string	"UPDATE"
	.align	2
.LC101:
	.string	"EMPTY-BUFFERS"
	.align	2
.LC102:
	.string	"SAVE-BUFFERS"
	.align	2
.LC103:
	.string	"LIST"
	.align	2
.LC104:
	.string	"LOAD"
	.align	2
.LC105:
	.string	"79-STANDARD"
	.align	2
.LC106:
	.string	"DUP"
	.align	2
.LC107:
	.string	"DROP"
	.align	2
.LC108:
	.string	"SWAP"
	.align	2
.LC109:
	.string	"OVER"
	.align	2
.LC110:
	.string	"ROT"
	.align	2
.LC111:
	.string	"."
	.align	2
.LC112:
	.string	"U."
	.align	2
.LC113:
	.string	"CR"
	.align	2
.LC114:
	.string	"EMIT"
	.align	2
.LC115:
	.string	"KEY"
	.align	2
.LC116:
	.string	"SPACE"
	.align	2
.LC117:
	.string	"SPACES"
	.align	2
.LC118:
	.string	"HEX"
	.align	2
.LC119:
	.string	"?"
	.align	2
.LC120:
	.string	"="
	.align	2
.LC121:
	.string	">"
	.align	2
.LC122:
	.string	"<"
	.align	2
.LC123:
	.string	"!"
	.align	2
.LC124:
	.string	"@"
	.align	2
.LC125:
	.string	"C!"
	.align	2
.LC126:
	.string	"C@"
	.align	2
.LC127:
	.string	"HERE"
	.align	2
.LC128:
	.string	"ALLOT"
	.align	2
.LC129:
	.string	","
	.align	2
.LC130:
	.string	"C,"
	.align	2
.LC131:
	.string	"LITERAL"
	.align	2
.LC132:
	.string	"STATE"
	.align	2
.LC133:
	.string	"BASE"
	.align	2
.LC134:
	.string	">IN"
	.align	2
.LC135:
	.string	"BLK"
	.align	2
.LC136:
	.string	"SCR"
	.align	2
.LC137:
	.string	"PAD"
	.align	2
.LC138:
	.string	"DECIMAL"
	.align	2
.LC139:
	.string	"DEPTH"
	.align	2
.LC140:
	.string	"BYE"
	.align	2
.LC141:
	.string	"EXECUTE"
	.align	2
.LC142:
	.string	":"
	.align	2
.LC143:
	.string	";"
	.align	2
.LC144:
	.string	"IF"
	.align	2
.LC145:
	.string	"THEN"
	.align	2
.LC146:
	.string	"ELSE"
	.align	2
.LC147:
	.string	"BEGIN"
	.align	2
.LC148:
	.string	"UNTIL"
	.align	2
.LC149:
	.string	"WHILE"
	.align	2
.LC150:
	.string	"REPEAT"
	.align	2
.LC151:
	.string	"DO"
	.align	2
.LC152:
	.string	"LOOP"
	.align	2
.LC153:
	.string	"+LOOP"
	.align	2
.LC154:
	.string	"I"
	.align	2
.LC155:
	.string	"J"
	.align	2
.LC156:
	.string	"LEAVE"
	.align	2
.LC157:
	.string	"RECURSE"
	.align	2
.LC158:
	.string	"'"
	.align	2
.LC159:
	.string	"IMMEDIATE"
	.align	2
.LC160:
	.string	"["
	.align	2
.LC161:
	.string	"]"
	.align	2
.LC162:
	.string	"ok> "
	.text
	.align	2
	.globl	main
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	call	forth_init
	call	load_blocks_file
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_add)
	la a1, w_add
# DELETED LUI: 	lui	a5,%hi(.LC32)
	la a0, .LC32
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_sub)
	la a1, w_sub
# DELETED LUI: 	lui	a5,%hi(.LC33)
	la a0, .LC33
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_mul)
	la a1, w_mul
# DELETED LUI: 	lui	a5,%hi(.LC34)
	la a0, .LC34
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_div)
	la a1, w_div
# DELETED LUI: 	lui	a5,%hi(.LC35)
	la a0, .LC35
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_mod)
	la a1, w_mod
# DELETED LUI: 	lui	a5,%hi(.LC36)
	la a0, .LC36
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_div_mod)
	la a1, w_div_mod
# DELETED LUI: 	lui	a5,%hi(.LC37)
	la a0, .LC37
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_mul_div)
	la a1, w_mul_div
# DELETED LUI: 	lui	a5,%hi(.LC38)
	la a0, .LC38
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_mul_div_mod)
	la a1, w_mul_div_mod
# DELETED LUI: 	lui	a5,%hi(.LC39)
	la a0, .LC39
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_one_plus)
	la a1, w_one_plus
# DELETED LUI: 	lui	a5,%hi(.LC40)
	la a0, .LC40
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_one_minus)
	la a1, w_one_minus
# DELETED LUI: 	lui	a5,%hi(.LC41)
	la a0, .LC41
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_two_plus)
	la a1, w_two_plus
# DELETED LUI: 	lui	a5,%hi(.LC42)
	la a0, .LC42
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_two_minus)
	la a1, w_two_minus
# DELETED LUI: 	lui	a5,%hi(.LC43)
	la a0, .LC43
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_abs)
	la a1, w_abs
# DELETED LUI: 	lui	a5,%hi(.LC44)
	la a0, .LC44
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_negate)
	la a1, w_negate
# DELETED LUI: 	lui	a5,%hi(.LC45)
	la a0, .LC45
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_min)
	la a1, w_min
# DELETED LUI: 	lui	a5,%hi(.LC46)
	la a0, .LC46
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_max)
	la a1, w_max
# DELETED LUI: 	lui	a5,%hi(.LC47)
	la a0, .LC47
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_zero_eq)
	la a1, w_zero_eq
# DELETED LUI: 	lui	a5,%hi(.LC48)
	la a0, .LC48
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_zero_eq)
	la a1, w_zero_eq
# DELETED LUI: 	lui	a5,%hi(.LC49)
	la a0, .LC49
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_zero_lt)
	la a1, w_zero_lt
# DELETED LUI: 	lui	a5,%hi(.LC50)
	la a0, .LC50
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_zero_gt)
	la a1, w_zero_gt
# DELETED LUI: 	lui	a5,%hi(.LC51)
	la a0, .LC51
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_and)
	la a1, w_and
# DELETED LUI: 	lui	a5,%hi(.LC52)
	la a0, .LC52
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_or)
	la a1, w_or
# DELETED LUI: 	lui	a5,%hi(.LC53)
	la a0, .LC53
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_xor)
	la a1, w_xor
# DELETED LUI: 	lui	a5,%hi(.LC54)
	la a0, .LC54
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_u_lt)
	la a1, w_u_lt
# DELETED LUI: 	lui	a5,%hi(.LC55)
	la a0, .LC55
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_u_mul)
	la a1, w_u_mul
# DELETED LUI: 	lui	a5,%hi(.LC56)
	la a0, .LC56
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_u_div_mod)
	la a1, w_u_div_mod
# DELETED LUI: 	lui	a5,%hi(.LC57)
	la a0, .LC57
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_to_r)
	la a1, w_to_r
# DELETED LUI: 	lui	a5,%hi(.LC58)
	la a0, .LC58
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_r_from)
	la a1, w_r_from
# DELETED LUI: 	lui	a5,%hi(.LC59)
	la a0, .LC59
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_r_fetch)
	la a1, w_r_fetch
# DELETED LUI: 	lui	a5,%hi(.LC60)
	la a0, .LC60
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_q_dup)
	la a1, w_q_dup
# DELETED LUI: 	lui	a5,%hi(.LC61)
	la a0, .LC61
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_pick)
	la a1, w_pick
# DELETED LUI: 	lui	a5,%hi(.LC62)
	la a0, .LC62
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_roll)
	la a1, w_roll
# DELETED LUI: 	lui	a5,%hi(.LC63)
	la a0, .LC63
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_plus_store)
	la a1, w_plus_store
# DELETED LUI: 	lui	a5,%hi(.LC64)
	la a0, .LC64
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_cmove)
	la a1, w_cmove
# DELETED LUI: 	lui	a5,%hi(.LC65)
	la a0, .LC65
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_move)
	la a1, w_move
# DELETED LUI: 	lui	a5,%hi(.LC66)
	la a0, .LC66
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_fill)
	la a1, w_fill
# DELETED LUI: 	lui	a5,%hi(.LC67)
	la a0, .LC67
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_count)
	la a1, w_count
# DELETED LUI: 	lui	a5,%hi(.LC68)
	la a0, .LC68
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_type)
	la a1, w_type
# DELETED LUI: 	lui	a5,%hi(.LC69)
	la a0, .LC69
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_dash_trailing)
	la a1, w_dash_trailing
# DELETED LUI: 	lui	a5,%hi(.LC70)
	la a0, .LC70
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_word)
	la a1, w_word
# DELETED LUI: 	lui	a5,%hi(.LC71)
	la a0, .LC71
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_find)
	la a1, w_find
# DELETED LUI: 	lui	a5,%hi(.LC72)
	la a0, .LC72
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_expect)
	la a1, w_expect
# DELETED LUI: 	lui	a5,%hi(.LC73)
	la a0, .LC73
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_query)
	la a1, w_query
# DELETED LUI: 	lui	a5,%hi(.LC74)
	la a0, .LC74
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_abort)
	la a1, w_abort
# DELETED LUI: 	lui	a5,%hi(.LC75)
	la a0, .LC75
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_quit_word)
	la a1, w_quit_word
# DELETED LUI: 	lui	a5,%hi(.LC76)
	la a0, .LC76
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_bl)
	la a1, w_bl
# DELETED LUI: 	lui	a5,%hi(.LC77)
	la a0, .LC77
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_create)
	la a1, w_create
# DELETED LUI: 	lui	a5,%hi(.LC78)
	la a0, .LC78
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_does)
	la a1, w_does
# DELETED LUI: 	lui	a5,%hi(.LC79)
	la a0, .LC79
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_compile)
	la a1, w_compile
# DELETED LUI: 	lui	a5,%hi(.LC80)
	la a0, .LC80
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_bracket_compile)
	la a1, w_bracket_compile
# DELETED LUI: 	lui	a5,%hi(.LC81)
	la a0, .LC81
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_forget)
	la a1, w_forget
# DELETED LUI: 	lui	a5,%hi(.LC82)
	la a0, .LC82
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_d_plus)
	la a1, w_d_plus
# DELETED LUI: 	lui	a5,%hi(.LC83)
	la a0, .LC83
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_d_lt)
	la a1, w_d_lt
# DELETED LUI: 	lui	a5,%hi(.LC84)
	la a0, .LC84
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_d_negate)
	la a1, w_d_negate
# DELETED LUI: 	lui	a5,%hi(.LC85)
	la a0, .LC85
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_less_sharp)
	la a1, w_less_sharp
# DELETED LUI: 	lui	a5,%hi(.LC86)
	la a0, .LC86
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_sharp)
	la a1, w_sharp
# DELETED LUI: 	lui	a5,%hi(.LC87)
	la a0, .LC87
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_sharp_s)
	la a1, w_sharp_s
# DELETED LUI: 	lui	a5,%hi(.LC88)
	la a0, .LC88
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_sharp_greater)
	la a1, w_sharp_greater
# DELETED LUI: 	lui	a5,%hi(.LC89)
	la a0, .LC89
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_hold)
	la a1, w_hold
# DELETED LUI: 	lui	a5,%hi(.LC90)
	la a0, .LC90
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_sign)
	la a1, w_sign
# DELETED LUI: 	lui	a5,%hi(.LC91)
	la a0, .LC91
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_convert)
	la a1, w_convert
# DELETED LUI: 	lui	a5,%hi(.LC92)
	la a0, .LC92
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_context)
	la a1, w_context
# DELETED LUI: 	lui	a5,%hi(.LC93)
	la a0, .LC93
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_current)
	la a1, w_current
# DELETED LUI: 	lui	a5,%hi(.LC94)
	la a0, .LC94
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_vocabulary)
	la a1, w_vocabulary
# DELETED LUI: 	lui	a5,%hi(.LC95)
	la a0, .LC95
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_definitions)
	la a1, w_definitions
# DELETED LUI: 	lui	a5,%hi(.LC96)
	la a0, .LC96
	call	create_word
	li	a3,0
	li	a2,0
	li	a1,0
# DELETED LUI: 	lui	a5,%hi(.LC97)
	la a0, .LC97
	call	create_word
# DELETED LUI: 	lui	a5,%hi(dict_len)
	la t6, dict_len
	lw a5, 0(t6)
	addi	a4,a5,-1
# DELETED LUI: 	lui	a5,%hi(dict)
	la a3, dict
	mv	a5,a4
	slli	a5,a5,4
	sub	a5,a5,a4
	slli	a5,a5,2
	add	a5,a3,a5
	li	a4,5
	sw	a4,52(a5)
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_block)
	la a1, w_block
# DELETED LUI: 	lui	a5,%hi(.LC98)
	la a0, .LC98
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_buffer)
	la a1, w_buffer
# DELETED LUI: 	lui	a5,%hi(.LC99)
	la a0, .LC99
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_update)
	la a1, w_update
# DELETED LUI: 	lui	a5,%hi(.LC100)
	la a0, .LC100
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_empty_buffers)
	la a1, w_empty_buffers
# DELETED LUI: 	lui	a5,%hi(.LC101)
	la a0, .LC101
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_save_buffers)
	la a1, w_save_buffers
# DELETED LUI: 	lui	a5,%hi(.LC102)
	la a0, .LC102
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_list)
	la a1, w_list
# DELETED LUI: 	lui	a5,%hi(.LC103)
	la a0, .LC103
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_load)
	la a1, w_load
# DELETED LUI: 	lui	a5,%hi(.LC104)
	la a0, .LC104
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_79_standard)
	la a1, w_79_standard
# DELETED LUI: 	lui	a5,%hi(.LC105)
	la a0, .LC105
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_dup)
	la a1, w_dup
# DELETED LUI: 	lui	a5,%hi(.LC106)
	la a0, .LC106
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_drop)
	la a1, w_drop
# DELETED LUI: 	lui	a5,%hi(.LC107)
	la a0, .LC107
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_swap)
	la a1, w_swap
# DELETED LUI: 	lui	a5,%hi(.LC108)
	la a0, .LC108
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_over)
	la a1, w_over
# DELETED LUI: 	lui	a5,%hi(.LC109)
	la a0, .LC109
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_rot)
	la a1, w_rot
# DELETED LUI: 	lui	a5,%hi(.LC110)
	la a0, .LC110
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_dot)
	la a1, w_dot
# DELETED LUI: 	lui	a5,%hi(.LC111)
	la a0, .LC111
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_u_dot)
	la a1, w_u_dot
# DELETED LUI: 	lui	a5,%hi(.LC112)
	la a0, .LC112
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_cr)
	la a1, w_cr
# DELETED LUI: 	lui	a5,%hi(.LC113)
	la a0, .LC113
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_emit)
	la a1, w_emit
# DELETED LUI: 	lui	a5,%hi(.LC114)
	la a0, .LC114
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_key)
	la a1, w_key
# DELETED LUI: 	lui	a5,%hi(.LC115)
	la a0, .LC115
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_space)
	la a1, w_space
# DELETED LUI: 	lui	a5,%hi(.LC116)
	la a0, .LC116
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_spaces)
	la a1, w_spaces
# DELETED LUI: 	lui	a5,%hi(.LC117)
	la a0, .LC117
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_hex)
	la a1, w_hex
# DELETED LUI: 	lui	a5,%hi(.LC118)
	la a0, .LC118
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_question)
	la a1, w_question
# DELETED LUI: 	lui	a5,%hi(.LC119)
	la a0, .LC119
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_eq)
	la a1, w_eq
# DELETED LUI: 	lui	a5,%hi(.LC120)
	la a0, .LC120
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_gt)
	la a1, w_gt
# DELETED LUI: 	lui	a5,%hi(.LC121)
	la a0, .LC121
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_lt)
	la a1, w_lt
# DELETED LUI: 	lui	a5,%hi(.LC122)
	la a0, .LC122
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_store)
	la a1, w_store
# DELETED LUI: 	lui	a5,%hi(.LC123)
	la a0, .LC123
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_fetch)
	la a1, w_fetch
# DELETED LUI: 	lui	a5,%hi(.LC124)
	la a0, .LC124
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_c_store)
	la a1, w_c_store
# DELETED LUI: 	lui	a5,%hi(.LC125)
	la a0, .LC125
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_c_fetch)
	la a1, w_c_fetch
# DELETED LUI: 	lui	a5,%hi(.LC126)
	la a0, .LC126
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_here)
	la a1, w_here
# DELETED LUI: 	lui	a5,%hi(.LC127)
	la a0, .LC127
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_allot)
	la a1, w_allot
# DELETED LUI: 	lui	a5,%hi(.LC128)
	la a0, .LC128
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_comma_op)
	la a1, w_comma_op
# DELETED LUI: 	lui	a5,%hi(.LC129)
	la a0, .LC129
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_c_comma_op)
	la a1, w_c_comma_op
# DELETED LUI: 	lui	a5,%hi(.LC130)
	la a0, .LC130
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_literal)
	la a1, w_literal
# DELETED LUI: 	lui	a5,%hi(.LC131)
	la a0, .LC131
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_state)
	la a1, w_state
# DELETED LUI: 	lui	a5,%hi(.LC132)
	la a0, .LC132
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_base)
	la a1, w_base
# DELETED LUI: 	lui	a5,%hi(.LC133)
	la a0, .LC133
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_in)
	la a1, w_in
# DELETED LUI: 	lui	a5,%hi(.LC134)
	la a0, .LC134
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_blk)
	la a1, w_blk
# DELETED LUI: 	lui	a5,%hi(.LC135)
	la a0, .LC135
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_scr)
	la a1, w_scr
# DELETED LUI: 	lui	a5,%hi(.LC136)
	la a0, .LC136
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_pad)
	la a1, w_pad
# DELETED LUI: 	lui	a5,%hi(.LC137)
	la a0, .LC137
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_decimal)
	la a1, w_decimal
# DELETED LUI: 	lui	a5,%hi(.LC138)
	la a0, .LC138
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_depth)
	la a1, w_depth
# DELETED LUI: 	lui	a5,%hi(.LC139)
	la a0, .LC139
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_exit)
	la a1, w_exit
# DELETED LUI: 	lui	a5,%hi(.LC22)
	la a0, .LC22
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_bye)
	la a1, w_bye
# DELETED LUI: 	lui	a5,%hi(.LC140)
	la a0, .LC140
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_lit)
	la a1, w_lit
# DELETED LUI: 	lui	a5,%hi(.LC20)
	la a0, .LC20
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_execute)
	la a1, w_execute
# DELETED LUI: 	lui	a5,%hi(.LC141)
	la a0, .LC141
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_branch0)
	la a1, w_branch0
# DELETED LUI: 	lui	a5,%hi(.LC23)
	la a0, .LC23
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_branch)
	la a1, w_branch
# DELETED LUI: 	lui	a5,%hi(.LC24)
	la a0, .LC24
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_do_run)
	la a1, w_do_run
# DELETED LUI: 	lui	a5,%hi(.LC25)
	la a0, .LC25
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_loop_run)
	la a1, w_loop_run
# DELETED LUI: 	lui	a5,%hi(.LC26)
	la a0, .LC26
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_plus_loop_run)
	la a1, w_plus_loop_run
# DELETED LUI: 	lui	a5,%hi(.LC27)
	la a0, .LC27
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_print_str)
	la a1, w_print_str
# DELETED LUI: 	lui	a5,%hi(.LC28)
	la a0, .LC28
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_colon)
	la a1, w_colon
# DELETED LUI: 	lui	a5,%hi(.LC142)
	la a0, .LC142
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_semicolon)
	la a1, w_semicolon
# DELETED LUI: 	lui	a5,%hi(.LC143)
	la a0, .LC143
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_if)
	la a1, w_if
# DELETED LUI: 	lui	a5,%hi(.LC144)
	la a0, .LC144
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_then)
	la a1, w_then
# DELETED LUI: 	lui	a5,%hi(.LC145)
	la a0, .LC145
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_else)
	la a1, w_else
# DELETED LUI: 	lui	a5,%hi(.LC146)
	la a0, .LC146
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_begin)
	la a1, w_begin
# DELETED LUI: 	lui	a5,%hi(.LC147)
	la a0, .LC147
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_until)
	la a1, w_until
# DELETED LUI: 	lui	a5,%hi(.LC148)
	la a0, .LC148
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_while)
	la a1, w_while
# DELETED LUI: 	lui	a5,%hi(.LC149)
	la a0, .LC149
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_repeat)
	la a1, w_repeat
# DELETED LUI: 	lui	a5,%hi(.LC150)
	la a0, .LC150
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_do)
	la a1, w_do
# DELETED LUI: 	lui	a5,%hi(.LC151)
	la a0, .LC151
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_loop)
	la a1, w_loop
# DELETED LUI: 	lui	a5,%hi(.LC152)
	la a0, .LC152
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_plus_loop)
	la a1, w_plus_loop
# DELETED LUI: 	lui	a5,%hi(.LC153)
	la a0, .LC153
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_i)
	la a1, w_i
# DELETED LUI: 	lui	a5,%hi(.LC154)
	la a0, .LC154
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_j)
	la a1, w_j
# DELETED LUI: 	lui	a5,%hi(.LC155)
	la a0, .LC155
	call	create_word
	li	a3,0
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_leave)
	la a1, w_leave
# DELETED LUI: 	lui	a5,%hi(.LC156)
	la a0, .LC156
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_recurse)
	la a1, w_recurse
# DELETED LUI: 	lui	a5,%hi(.LC157)
	la a0, .LC157
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_tick)
	la a1, w_tick
# DELETED LUI: 	lui	a5,%hi(.LC158)
	la a0, .LC158
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_immediate)
	la a1, w_immediate
# DELETED LUI: 	lui	a5,%hi(.LC159)
	la a0, .LC159
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_lbracket)
	la a1, w_lbracket
# DELETED LUI: 	lui	a5,%hi(.LC160)
	la a0, .LC160
	call	create_word
	li	a3,1
	li	a2,-1
# DELETED LUI: 	lui	a5,%hi(w_rbracket)
	la a1, w_rbracket
# DELETED LUI: 	lui	a5,%hi(.LC161)
	la a0, .LC161
	call	create_word
# DELETED LUI: 	lui	a5,%hi(.LC162)
	la a5, .LC162
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
.L550:
# DELETED LUI: 	lui	a5,%hi(input_buffer)
	la a5, input_buffer
	sw	a5,-36(s0)
	li	a5,511
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-44(s0)
	lw	a5,-40(s0)
	sw	a5,-48(s0)
	lw	a5,-44(s0)
	lw	a4,-48(s0)
 #APP
# 23 "rars_lib.h" 1
	mv a0, a5
	mv a1, a4
	li a7, 8
	ecall
# 0 "" 2
 #NO_APP
	nop
# DELETED LUI: 	lui	a5,%hi(input_buffer)
	la a0, input_buffer
	call	eval
# DELETED LUI: 	lui	a5,%hi(.LC162)
	la a5, .LC162
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sw	a5,-32(s0)
	lw	a5,-32(s0)
 #APP
# 12 "rars_lib.h" 1
	mv a0, a5
	li a7, 4
	ecall
# 0 "" 2
 #NO_APP
	nop
	j	.L550
.data
