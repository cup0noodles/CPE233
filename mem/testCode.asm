main:
	lui 	x5, 0xAA055
	addi 	x8, x5, 0x765
	slli	x10, x8, 3
	slt	x12, x5, x8
	xor	x13, x8, x10
	beq	x0, x0, main