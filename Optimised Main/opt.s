	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"opt.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Please input a valid .wav file \000"
	.align	2
.LC1:
	.ascii	"\012 Input Wave Filename: %s\012\000"
	.align	2
.LC2:
	.ascii	"rb\000"
	.align	2
.LC3:
	.ascii	"Error opening .wav file: %s\000"
	.align	2
.LC4:
	.ascii	"Creating new WAV file ...\012\000"
	.align	2
.LC5:
	.ascii	"new_\000"
	.align	2
.LC6:
	.ascii	"wb\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #64
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	ldr	r3, [fp, #-64]
	cmp	r3, #1
	bgt	.L2
	ldr	r0, .L5
	bl	puts
	mov	r0, #1
	bl	exit
.L2:
	ldr	r3, [fp, #-68]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L5+4
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-68]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	mov	r0, r3
	ldr	r1, .L5+8
	bl	fopen
	mov	r2, r0
	ldr	r3, .L5+12
	str	r2, [r3, #0]
	ldr	r3, .L5+12
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L3
	ldr	r3, [fp, #-68]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L5+16
	mov	r1, r3
	bl	printf
	mov	r0, #1
	bl	exit
.L3:
	ldr	r0, .L5+20
	bl	puts
	sub	r3, fp, #58
	mov	r0, r3
	ldr	r1, .L5+24
	mov	r2, #5
	bl	memcpy
	ldr	r3, [fp, #-68]
	add	r3, r3, #4
	ldr	r2, [r3, #0]
	sub	r3, fp, #58
	mov	r0, r3
	mov	r1, r2
	bl	strcat
	sub	r3, fp, #58
	mov	r0, r3
	ldr	r1, .L5+28
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	readWaveFile
	ldr	r0, [fp, #-8]
	bl	readWaveFileDataSamples
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L6:
	.align	2
.L5:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	fp
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	main, .-main
	.section	.rodata
	.align	2
.LC7:
	.ascii	"Reading Wave File Headers.... \000"
	.align	2
.LC8:
	.ascii	"(1-4): %s \012\000"
	.align	2
.LC9:
	.ascii	"(5-8) Overall size: bytes:%u, Kb:%u \012\000"
	.align	2
.LC10:
	.ascii	"(9-12) Wave marker: %s\012\000"
	.align	2
.LC11:
	.ascii	"(13-16) Fmt marker: %s\012\000"
	.align	2
.LC12:
	.ascii	"(17-20) Length of Fmt header: %u \012\000"
	.align	2
.LC13:
	.ascii	"(21-22) Format type: %u \012\000"
	.align	2
.LC14:
	.ascii	"(23-24) Channels: %u \012\000"
	.align	2
.LC15:
	.ascii	"(25-28) Sample rate: %u\012\000"
	.align	2
.LC16:
	.ascii	"(29-32) Byte Rate: %u , Bit Rate:%u\012\000"
	.align	2
.LC17:
	.ascii	"(33-34) Block Alignment: %u \012\000"
	.align	2
.LC18:
	.ascii	"(35-36) Bits per sample: %u \012\000"
	.align	2
.LC19:
	.ascii	"(37-40) Data Marker: %s \012\000"
	.align	2
.LC20:
	.ascii	"(41-44) Size of data chunk: %u \012\000"
	.align	2
.LC21:
	.ascii	"COMPLETED Reading Wave File Headers \012\000"
	.text
	.align	2
	.global	readWaveFile
	.type	readWaveFile, %function
readWaveFile:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-8]
	ldr	r0, .L9
	bl	puts
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+8
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+12
	ldr	r1, .L9+8
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+16
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+20
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+24
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+28
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #4]
	ldr	r3, .L9+8
	ldr	r2, [r3, #4]
	ldr	r3, .L9+8
	ldr	r3, [r3, #4]
	mov	r3, r3, lsr #10
	ldr	r0, .L9+32
	mov	r1, r2
	mov	r2, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+36
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+36
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+40
	ldr	r1, .L9+36
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+44
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+44
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+48
	ldr	r1, .L9+44
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+16
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+20
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+24
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+28
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #16]
	ldr	r3, .L9+8
	ldr	r3, [r3, #16]
	ldr	r0, .L9+52
	mov	r1, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+56
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+56
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #20]
	ldr	r3, .L9+8
	ldr	r3, [r3, #20]
	ldr	r0, .L9+60
	mov	r1, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+56
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+56
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #24]
	ldr	r3, .L9+8
	ldr	r3, [r3, #24]
	ldr	r0, .L9+64
	mov	r1, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+16
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+20
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+24
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+28
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #28]
	ldr	r3, .L9+8
	ldr	r3, [r3, #28]
	ldr	r0, .L9+68
	mov	r1, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+16
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+20
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+24
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+28
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #32]
	ldr	r3, .L9+8
	ldr	r2, [r3, #32]
	ldr	r3, .L9+8
	ldr	r3, [r3, #32]
	mov	r3, r3, asl #3
	ldr	r0, .L9+72
	mov	r1, r2
	mov	r2, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+56
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+56
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #36]
	ldr	r3, .L9+8
	ldr	r3, [r3, #36]
	ldr	r0, .L9+76
	mov	r1, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+56
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+56
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+56
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #40]
	ldr	r3, .L9+8
	ldr	r3, [r3, #40]
	ldr	r0, .L9+80
	mov	r1, r3
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+84
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+84
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+88
	ldr	r1, .L9+84
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3, #0]
	ldr	r0, .L9+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L9+16
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+20
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+24
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r0, .L9+28
	mov	r1, #1
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, .L9+16
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, .L9+16
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	mov	r2, r3
	ldr	r3, .L9+8
	str	r2, [r3, #48]
	ldr	r3, .L9+8
	ldr	r3, [r3, #48]
	ldr	r0, .L9+92
	mov	r1, r3
	bl	printf
	ldr	r0, .L9+96
	bl	puts
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L10:
	.align	2
.L9:
	.word	.LC7
	.word	fp
	.word	header
	.word	.LC8
	.word	buffer4
	.word	buffer4+1
	.word	buffer4+2
	.word	buffer4+3
	.word	.LC9
	.word	header+8
	.word	.LC10
	.word	header+12
	.word	.LC11
	.word	.LC12
	.word	buffer2
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	header+44
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.size	readWaveFile, .-readWaveFile
	.section	.rodata
	.align	2
.LC22:
	.ascii	"Reading PCM data...\000"
	.global	__aeabi_uidiv
	.align	2
.LC23:
	.ascii	"Number of samples:%lu \012\000"
	.align	2
.LC24:
	.ascii	"Size of each sample:%ld bytes\012\000"
	.align	2
.LC25:
	.ascii	"Could not allocate enough memory to read data sampl"
	.ascii	"es\000"
	.align	2
.LC26:
	.ascii	"COMPLETED Reading PCM data \012\000"
	.align	2
.LC27:
	.ascii	"Cannot proceed! Only PCM data allowed!\000"
	.text
	.align	2
	.global	readWaveFileDataSamples
	.type	readWaveFileDataSamples, %function
readWaveFileDataSamples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	ldr	r3, .L17
	ldr	r3, [r3, #20]
	cmp	r3, #1
	bne	.L12
	ldr	r0, .L17+4
	bl	puts
	ldr	r3, .L17
	ldr	r3, [r3, #48]
	mov	r1, r3, asl #3
	ldr	r3, .L17
	ldr	r2, [r3, #24]
	ldr	r3, .L17
	ldr	r3, [r3, #40]
	mul	r3, r2, r3
	mov	r0, r1
	mov	r1, r3
	bl	__aeabi_uidiv
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r0, .L17+8
	ldr	r1, [fp, #-12]
	bl	printf
	ldr	r3, .L17
	ldr	r2, [r3, #24]
	ldr	r3, .L17
	ldr	r3, [r3, #40]
	mul	r3, r2, r3
	mov	r3, r3, lsr #3
	str	r3, [fp, #-8]
	ldr	r0, .L17+12
	ldr	r1, [fp, #-8]
	bl	printf
	ldr	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	mov	r0, r3
	mov	r1, r2
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L17+16
	str	r2, [r3, #0]
	ldr	r3, .L17+16
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L13
	ldr	r0, .L17+20
	bl	puts
	mov	r0, #1
	bl	exit
.L13:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L14
.L15:
	ldr	r2, [fp, #-8]
	ldr	r3, .L17+24
	ldr	r3, [r3, #0]
	ldr	r0, .L17+28
	mov	r1, r2
	mov	r2, #1
	bl	fread
	ldr	r3, .L17+16
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #2
	add	r1, r2, r3
	ldr	r3, .L17+28
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L17+28
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	str	r3, [r1, #0]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L14:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-12]
	cmp	r2, r3
	blt	.L15
	ldr	r0, .L17+32
	bl	puts
	ldr	r0, [fp, #-12]
	bl	compression
	ldr	r0, [fp, #-24]
	ldr	r1, [fp, #-12]
	ldr	r2, [fp, #-8]
	bl	decompression
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L12:
	ldr	r0, .L17+36
	bl	puts
	mov	r0, #1
	bl	exit
.L18:
	.align	2
.L17:
	.word	header
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	sample_data
	.word	.LC25
	.word	fp
	.word	buffer2
	.word	.LC26
	.word	.LC27
	.size	readWaveFileDataSamples, .-readWaveFileDataSamples
	.section	.rodata
	.align	2
.LC28:
	.ascii	"Compressing Data Samples.... \000"
	.align	2
.LC29:
	.ascii	"Could not allocate enough memory to store compresse"
	.ascii	"d data samples\000"
	.align	2
.LC30:
	.ascii	"COMPLETED Compressing data samples \012\000"
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.align	2
.LC31:
	.ascii	"Audio Compression using Mu Law: %f seconds \012\012"
	.ascii	"\000"
	.text
	.align	2
	.global	compression
	.type	compression, %function
compression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #28
	str	r0, [fp, #-40]
	bl	clock
	mov	r2, r0
	ldr	r3, .L25
	str	r2, [r3, #0]
	ldr	r0, .L25+4
	bl	puts
	ldr	r3, [fp, #-40]
	mov	r0, r3
	mov	r1, #1
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L25+8
	str	r2, [r3, #0]
	ldr	r3, .L25+8
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L20
	ldr	r0, .L25+12
	bl	puts
	b	.L24
.L20:
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L22
.L23:
	ldr	r3, .L25+16
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	mov	r3, r3, asl #2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	mov	r3, r3, asr #2
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-28]
	mvn	r3, r3
	mov	r3, r3, lsr #31
	strh	r3, [fp, #-24]	@ movhi
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	rsblt	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #33
	strh	r3, [fp, #-22]	@ movhi
	ldr	r3, .L25+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	add	r4, r2, r3
	ldrh	r3, [fp, #-22]
	ldrsh	r2, [fp, #-24]
	mov	r0, r3
	mov	r1, r2
	bl	codeword_compression
	mov	r3, r0
	and	r3, r3, #255
	mvn	r3, r3
	and	r3, r3, #255
	strb	r3, [r4, #0]
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L22:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-40]
	cmp	r2, r3
	blt	.L23
	ldr	r0, .L25+20
	bl	puts
	bl	clock
	mov	r2, r0
	ldr	r3, .L25+24
	str	r2, [r3, #0]
	ldr	r3, .L25+24
	ldr	r2, [r3, #0]
	ldr	r3, .L25
	ldr	r3, [r3, #0]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r5, #0
	mov	r6, #1090519040
	add	r6, r6, #3047424
	add	r6, r6, #1152
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L25+28
	mov	r2, r3
	mov	r3, r4
	bl	printf
.L24:
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L26:
	.align	2
.L25:
	.word	start
	.word	.LC28
	.word	compressed_sample_data
	.word	.LC29
	.word	sample_data
	.word	.LC30
	.word	stop
	.word	.LC31
	.size	compression, .-compression
	.section	.rodata
	.align	2
.LC32:
	.ascii	"Decompressing Data Samples....\000"
	.align	2
.LC33:
	.ascii	"COMPLETED decompressing data sample \012\000"
	.align	2
.LC34:
	.ascii	"Audio Decompression using Mu Law: %f seconds\012\012"
	.ascii	"\000"
	.text
	.align	2
	.global	decompression
	.type	decompression, %function
decompression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	str	r2, [fp, #-48]
	bl	clock
	mov	r3, r0
	ldr	r2, .L33
	str	r3, [r2, #0]
	ldr	r0, .L33+4
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L28
.L31:
	ldr	r3, .L33+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mvn	r3, r3
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	and	r3, r3, #128
	mov	r3, r3, asr #7
	strh	r3, [fp, #-26]	@ movhi
	ldr	r3, [fp, #-36]
	and	r3, r3, #255
	mov	r0, r3
	bl	codeword_decompression
	mov	r3, r0
	sub	r3, r3, #33
	strh	r3, [fp, #-24]	@ movhi
	ldrsh	r3, [fp, #-26]
	cmp	r3, #0
	beq	.L29
	ldrh	r3, [fp, #-24]
	str	r3, [fp, #-52]
	b	.L30
.L29:
	ldrh	r3, [fp, #-24]
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-52]
.L30:
	ldr	r3, [fp, #-52]
	strh	r3, [fp, #-22]	@ movhi
	ldr	r3, .L33+12
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-32]
	mov	r3, r3, asl #2
	add	r2, r2, r3
	ldrsh	r3, [fp, #-22]
	mov	r3, r3, asl #2
	str	r3, [r2, #0]
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L28:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-44]
	cmp	r2, r3
	blt	.L31
	ldr	r0, .L33+16
	bl	puts
	bl	clock
	mov	r2, r0
	ldr	r3, .L33+20
	str	r2, [r3, #0]
	ldr	r0, [fp, #-40]
	ldr	r1, [fp, #-44]
	ldr	r2, [fp, #-48]
	bl	saveFile
	ldr	r3, .L33+20
	ldr	r2, [r3, #0]
	ldr	r3, .L33
	ldr	r3, [r3, #0]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r5, #0
	mov	r6, #1090519040
	add	r6, r6, #3047424
	add	r6, r6, #1152
	mov	r0, r3
	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L33+24
	mov	r2, r3
	mov	r3, r4
	bl	printf
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L34:
	.align	2
.L33:
	.word	start
	.word	.LC32
	.word	compressed_sample_data
	.word	sample_data
	.word	.LC33
	.word	stop
	.word	.LC34
	.size	decompression, .-decompression
	.align	2
	.global	codeword_compression
	.type	codeword_compression, %function
codeword_compression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-14]	@ movhi
	strh	r2, [fp, #-16]	@ movhi
	ldrh	r3, [fp, #-14]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L36
	mov	r3, #0
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L36:
	ldrh	r3, [fp, #-14]
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L38
	mov	r3, #1
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L38:
	ldrh	r3, [fp, #-14]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L39
	mov	r3, #2
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L39:
	ldrh	r3, [fp, #-14]
	and	r3, r3, #256
	cmp	r3, #0
	beq	.L40
	mov	r3, #3
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #4
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L40:
	ldrh	r3, [fp, #-14]
	and	r3, r3, #512
	cmp	r3, #0
	beq	.L41
	mov	r3, #4
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #5
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L41:
	ldrh	r3, [fp, #-14]
	and	r3, r3, #1024
	cmp	r3, #0
	beq	.L42
	mov	r3, #5
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #6
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L42:
	ldrh	r3, [fp, #-14]
	and	r3, r3, #2048
	cmp	r3, #0
	beq	.L43
	mov	r3, #6
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #7
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
	b	.L37
.L43:
	mov	r3, #7
	str	r3, [fp, #-12]
	ldrh	r3, [fp, #-14]
	mov	r3, r3, lsr #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-8]
.L37:
	ldrsh	r3, [fp, #-16]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-12]
	mov	r3, r3, asl #4
	orr	r2, r2, r3
	ldr	r3, [fp, #-8]
	orr	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	codeword_compression, .-codeword_compression
	.align	2
	.global	codeword_decompression
	.type	codeword_decompression, %function
codeword_decompression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #36
	mov	r3, r0
	strb	r3, [fp, #-29]
	ldrb	r3, [fp, #-29]	@ zero_extendqisi2
	and	r3, r3, #112
	mov	r3, r3, asr #4
	str	r3, [fp, #-24]
	ldrb	r3, [fp, #-29]	@ zero_extendqisi2
	and	r3, r3, #15
	str	r3, [fp, #-20]
	mov	r3, #1
	str	r3, [fp, #-16]
	mov	r3, #1
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-24]
	cmp	r3, #7
	ldrls	pc, [pc, r3, asl #2]
	b	.L46
.L55:
	.word	.L47
	.word	.L48
	.word	.L49
	.word	.L50
	.word	.L51
	.word	.L52
	.word	.L53
	.word	.L54
.L47:
	ldr	r3, [fp, #-20]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-12]
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #5
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L48:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #2
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #6
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L49:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #2
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #7
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L50:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #3
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #4
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L51:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #4
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #5
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #9
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L52:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #5
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #6
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #10
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L53:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #6
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #7
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #11
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L46
.L54:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #12
	orr	r3, r2, r3
	str	r3, [fp, #-8]
.L46:
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	codeword_decompression, .-codeword_decompression
	.section	.rodata
	.align	2
.LC35:
	.ascii	"COMPLETED saving mu law file \012\000"
	.text
	.align	2
	.global	saveFile
	.type	saveFile, %function
saveFile:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L58
.L59:
	ldr	r3, .L61
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	ldr	r2, .L61+4
	strb	r3, [r2, #0]
	ldr	r3, .L61
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	and	r3, r3, #65280
	mov	r3, r3, asr #8
	and	r3, r3, #255
	ldr	r2, .L61+4
	strb	r3, [r2, #1]
	ldr	r3, [fp, #-24]
	ldr	r0, .L61+4
	mov	r1, r3
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L58:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	blt	.L59
	ldr	r0, [fp, #-16]
	bl	fclose
	ldr	r0, .L61+8
	bl	puts
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L62:
	.align	2
.L61:
	.word	sample_data
	.word	buffer2
	.word	.LC35
	.size	saveFile, .-saveFile
	.comm	fp,4,4
	.comm	header,52,4
	.comm	buffer4,4,1
	.comm	buffer2,2,1
	.comm	start,4,4
	.comm	stop,4,4
	.comm	sample_data,4,4
	.comm	compressed_sample_data,4,4
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
