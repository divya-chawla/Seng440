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
	.file	"audioComp.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"\012 Please input a valid .wav file \000"
	.align	2
.LC1:
	.ascii	"\012 Input Wave Filename:\011%s\012\000"
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
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #112
	str	r0, [fp, #-112]
	str	r1, [fp, #-116]
	ldr	r3, [fp, #-112]
	cmp	r3, #1
	bgt	.L2
	ldr	r0, .L5
	bl	puts
	mov	r0, #1
	bl	exit
.L2:
	ldr	r3, [fp, #-116]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L5+4
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-116]
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
	ldr	r3, [fp, #-116]
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
	sub	r3, fp, #108
	mov	r0, r3
	ldr	r1, .L5+24
	mov	r2, #5
	bl	memcpy
	ldr	r3, [fp, #-116]
	add	r3, r3, #4
	ldr	r2, [r3, #0]
	sub	r3, fp, #108
	mov	r0, r3
	mov	r1, r2
	bl	strcat
	sub	r3, fp, #108
	mov	r0, r3
	ldr	r1, .L5+28
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	readWaveFile
	bl	readWaveFileDataSamples
	bl	compression
	ldr	r0, [fp, #-8]
	bl	decompression
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L18
	ldr	r3, [r3, #20]
	cmp	r3, #1
	bne	.L12
	ldr	r0, .L18+4
	bl	puts
	ldr	r3, .L18
	ldr	r3, [r3, #48]
	mov	r1, r3, asl #3
	ldr	r3, .L18
	ldr	r2, [r3, #24]
	ldr	r3, .L18
	ldr	r3, [r3, #40]
	mul	r3, r2, r3
	mov	r0, r1
	mov	r1, r3
	bl	__aeabi_uidiv
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+8
	str	r2, [r3, #0]
	ldr	r3, .L18+8
	ldr	r3, [r3, #0]
	ldr	r0, .L18+12
	mov	r1, r3
	bl	printf
	ldr	r3, .L18
	ldr	r2, [r3, #24]
	ldr	r3, .L18
	ldr	r3, [r3, #40]
	mul	r3, r2, r3
	mov	r3, r3, lsr #3
	mov	r2, r3
	ldr	r3, .L18+16
	str	r2, [r3, #0]
	ldr	r3, .L18+16
	ldr	r3, [r3, #0]
	ldr	r0, .L18+20
	mov	r1, r3
	bl	printf
	ldr	r3, .L18+8
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, .L18+16
	ldr	r3, [r3, #0]
	mov	r0, r2
	mov	r1, r3
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+24
	str	r2, [r3, #0]
	ldr	r3, .L18+24
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L13
	ldr	r0, .L18+28
	bl	puts
	b	.L17
.L13:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L15
.L16:
	ldr	r3, .L18+16
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, .L18+32
	ldr	r3, [r3, #0]
	ldr	r0, .L18+36
	mov	r1, r2
	mov	r2, #1
	bl	fread
	ldr	r3, .L18+24
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	add	r1, r2, r3
	ldr	r3, .L18+36
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, .L18+36
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	str	r3, [r1, #0]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L15:
	ldr	r3, .L18+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	cmp	r3, r2
	blt	.L16
	ldr	r0, .L18+40
	bl	puts
	b	.L17
.L12:
	ldr	r0, .L18+44
	bl	puts
	mov	r0, #1
	bl	exit
.L17:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L19:
	.align	2
.L18:
	.word	header
	.word	.LC22
	.word	num_samples
	.word	.LC23
	.word	size_of_each_sample
	.word	.LC24
	.word	sample_data
	.word	.LC25
	.word	fp
	.word	buffer2
	.word	.LC26
	.word	.LC27
	.size	readWaveFileDataSamples, .-readWaveFileDataSamples
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.section	.rodata
	.align	2
.LC28:
	.ascii	"Audio Compression using Mu Law: %f seconds \012\012"
	.ascii	"\000"
	.text
	.align	2
	.global	compression
	.type	compression, %function
compression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	bl	clock
	mov	r2, r0
	ldr	r3, .L22
	str	r2, [r3, #0]
	bl	compressDataSamples
	bl	clock
	mov	r2, r0
	ldr	r3, .L22+4
	str	r2, [r3, #0]
	ldr	r3, .L22+4
	ldr	r2, [r3, #0]
	ldr	r3, .L22
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
	ldr	r2, .L22+8
	stmia	r2, {r3-r4}
	ldr	r3, .L22+8
	ldmia	r3, {r3-r4}
	ldr	r0, .L22+12
	mov	r2, r3
	mov	r3, r4
	bl	printf
	sub	sp, fp, #20
	ldmfd	sp!, {r4, r5, r6, r7, fp, lr}
	bx	lr
.L23:
	.align	2
.L22:
	.word	start
	.word	stop
	.word	compressionDuration
	.word	.LC28
	.size	compression, .-compression
	.section	.rodata
	.align	2
.LC29:
	.ascii	"Audio Decompression using Mu Law: %f seconds\012\012"
	.ascii	"\000"
	.text
	.align	2
	.global	decompression
	.type	decompression, %function
decompression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #12
	str	r0, [fp, #-24]
	bl	clock
	mov	r2, r0
	ldr	r3, .L26
	str	r2, [r3, #0]
	bl	decompressDataSamples
	bl	clock
	mov	r2, r0
	ldr	r3, .L26+4
	str	r2, [r3, #0]
	ldr	r3, .L26+4
	ldr	r2, [r3, #0]
	ldr	r3, .L26
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
	ldr	r2, .L26+8
	stmia	r2, {r3-r4}
	ldr	r0, [fp, #-24]
	bl	saveFile
	ldr	r3, .L26+8
	ldmia	r3, {r3-r4}
	ldr	r0, .L26+12
	mov	r2, r3
	mov	r3, r4
	bl	printf
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L27:
	.align	2
.L26:
	.word	start
	.word	stop
	.word	decompressionDuration
	.word	.LC29
	.size	decompression, .-decompression
	.section	.rodata
	.align	2
.LC30:
	.ascii	"Compressing Data Samples.... \000"
	.align	2
.LC31:
	.ascii	"Could not allocate enough memory to store compresse"
	.ascii	"d data samples\000"
	.align	2
.LC32:
	.ascii	"COMPLETED Compressing data samples \012\000"
	.text
	.align	2
	.global	compressDataSamples
	.type	compressDataSamples, %function
compressDataSamples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	ldr	r0, .L34
	bl	puts
	ldr	r3, .L34+4
	ldr	r3, [r3, #0]
	mov	r0, r3
	mov	r1, #1
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L34+8
	str	r2, [r3, #0]
	ldr	r3, .L34+8
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L29
	ldr	r0, .L34+12
	bl	puts
	b	.L33
.L29:
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L31
.L32:
	ldr	r3, .L34+16
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	mov	r3, r3, asr #2
	str	r3, [fp, #-16]
	ldr	r0, [fp, #-16]
	bl	signum
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-12]	@ movhi
	ldr	r0, [fp, #-16]
	bl	getMagnitude
	mov	r3, r0
	add	r3, r3, #33
	strh	r3, [fp, #-10]	@ movhi
	ldrh	r3, [fp, #-10]
	ldrsh	r2, [fp, #-12]
	mov	r0, r3
	mov	r1, r2
	bl	codeword_compression
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mvn	r3, r3
	str	r3, [fp, #-8]
	ldr	r3, .L34+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	add	r2, r2, r3
	ldr	r3, [fp, #-8]
	and	r3, r3, #255
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L31:
	ldr	r3, .L34+4
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	cmp	r3, r2
	blt	.L32
	ldr	r0, .L34+20
	bl	puts
.L33:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L35:
	.align	2
.L34:
	.word	.LC30
	.word	num_samples
	.word	compressed_sample_data
	.word	.LC31
	.word	sample_data
	.word	.LC32
	.size	compressDataSamples, .-compressDataSamples
	.section	.rodata
	.align	2
.LC33:
	.ascii	"Decompressing Data Samples....\000"
	.align	2
.LC34:
	.ascii	"COMPLETED decompressing data sample \012\000"
	.text
	.align	2
	.global	decompressDataSamples
	.type	decompressDataSamples, %function
decompressDataSamples:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	ldr	r0, .L42
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L37
.L40:
	ldr	r3, .L42+4
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mvn	r3, r3
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	and	r3, r3, #128
	mov	r3, r3, asr #7
	strh	r3, [fp, #-12]	@ movhi
	ldr	r3, [fp, #-20]
	and	r3, r3, #255
	mov	r0, r3
	bl	codeword_decompression
	mov	r3, r0
	sub	r3, r3, #33
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-12]
	cmp	r3, #0
	beq	.L38
	ldrh	r3, [fp, #-10]
	str	r3, [fp, #-24]
	b	.L39
.L38:
	ldrh	r3, [fp, #-10]
	rsb	r3, r3, #0
	str	r3, [fp, #-24]
.L39:
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-8]
	ldr	r3, .L42+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #2
	add	r2, r2, r3
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	str	r3, [r2, #0]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L37:
	ldr	r3, .L42+12
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	cmp	r3, r2
	blt	.L40
	ldr	r0, .L42+16
	bl	puts
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L43:
	.align	2
.L42:
	.word	.LC33
	.word	compressed_sample_data
	.word	sample_data
	.word	num_samples
	.word	.LC34
	.size	decompressDataSamples, .-decompressDataSamples
	.align	2
	.global	signum
	.type	signum, %function
signum:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bge	.L45
	mov	r2, #0
	str	r2, [fp, #-12]
	b	.L46
.L45:
	mov	r3, #1
	str	r3, [fp, #-12]
.L46:
	ldr	r2, [fp, #-12]
	mov	r3, r2, asl #16
	mov	r3, r3, asr #16
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	signum, .-signum
	.align	2
	.global	getMagnitude
	.type	getMagnitude, %function
getMagnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bge	.L49
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #0
	str	r3, [fp, #-8]
.L49:
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	getMagnitude, .-getMagnitude
	.align	2
	.global	codeword_compression
	.type	codeword_compression, %function
codeword_compression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-22]	@ movhi
	strh	r2, [fp, #-24]	@ movhi
	ldrh	r3, [fp, #-22]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L52
	mov	r3, #7
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L52:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #2048
	cmp	r3, #0
	beq	.L54
	mov	r3, #6
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #7
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L54:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #1024
	cmp	r3, #0
	beq	.L55
	mov	r3, #5
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #6
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L55:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #512
	cmp	r3, #0
	beq	.L56
	mov	r3, #4
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #5
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L56:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #256
	cmp	r3, #0
	beq	.L57
	mov	r3, #3
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #4
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L57:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L58
	mov	r3, #2
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L58:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L59
	mov	r3, #1
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
	b	.L53
.L59:
	mov	r3, #0
	str	r3, [fp, #-16]
	ldrh	r3, [fp, #-22]
	mov	r3, r3, lsr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #15
	str	r3, [fp, #-12]
.L53:
	ldrsh	r3, [fp, #-24]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	orr	r2, r2, r3
	ldr	r3, [fp, #-12]
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
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
	bne	.L62
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #12
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L62:
	ldr	r3, [fp, #-24]
	cmp	r3, #6
	bne	.L64
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #6
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #7
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #11
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L64:
	ldr	r3, [fp, #-24]
	cmp	r3, #5
	bne	.L65
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #5
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #6
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #10
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L65:
	ldr	r3, [fp, #-24]
	cmp	r3, #4
	bne	.L66
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #4
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #5
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #9
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L66:
	ldr	r3, [fp, #-24]
	cmp	r3, #3
	bne	.L67
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #3
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #4
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #8
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L67:
	ldr	r3, [fp, #-24]
	cmp	r3, #2
	bne	.L68
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #2
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #3
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #7
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L68:
	ldr	r3, [fp, #-24]
	cmp	r3, #1
	bne	.L69
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #2
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #6
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	b	.L63
.L69:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L63
	ldr	r3, [fp, #-20]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-12]
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #5
	orr	r3, r2, r3
	str	r3, [fp, #-8]
.L63:
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L72
.L73:
	ldr	r3, .L75
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	and	r3, r3, #255
	ldr	r2, .L75+4
	strb	r3, [r2, #0]
	ldr	r3, .L75
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	and	r3, r3, #65280
	mov	r3, r3, asr #8
	and	r3, r3, #255
	ldr	r2, .L75+4
	strb	r3, [r2, #1]
	ldr	r3, .L75+8
	ldr	r3, [r3, #0]
	ldr	r0, .L75+4
	mov	r1, r3
	mov	r2, #1
	ldr	r3, [fp, #-16]
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L72:
	ldr	r3, .L75+12
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	cmp	r3, r2
	blt	.L73
	ldr	r0, [fp, #-16]
	bl	fclose
	ldr	r0, .L75+16
	bl	puts
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L76:
	.align	2
.L75:
	.word	sample_data
	.word	buffer2
	.word	size_of_each_sample
	.word	num_samples
	.word	.LC35
	.size	saveFile, .-saveFile
	.comm	fp,4,4
	.comm	header,52,4
	.comm	buffer4,4,1
	.comm	buffer2,2,1
	.comm	start,4,4
	.comm	stop,4,4
	.comm	compressionDuration,8,8
	.comm	decompressionDuration,8,8
	.comm	num_samples,4,4
	.comm	size_of_each_sample,4,4
	.comm	sample_data,4,4
	.comm	compressed_sample_data,4,4
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
