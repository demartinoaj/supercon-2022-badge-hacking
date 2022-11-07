; starting space
; inst mem Map MSB->LSB:
;   [1110] - sprite  Jump space
;   [0000] - sprite
;   [0000] - sprite instruction 
;  
;   [1111 0000 0000] - sprite instruction space
;
; Reg Map:
;   ro: resevered
;	r1: sprite 1 ptr
;   r2: sprite 2 ptr
;   r5: tic counter
;   r7: scratch
;   r8: scratch
;   r9: scratch
mov [0xF1], r0
goto init
or r0, r0 ; No op
or r0, r0
;mov r0,4 ; slow clock a bit
;mov [0xF1], r0

; init
org 0x40 ; give me some space
init: 
mov r0,2  ; show page 2 and 3 which is empty for display
mov [0xF0], r0

mov pch, 0xD ; load sprite space jump

; intialize registers and data mem
mov r1, 0 ; zero sprite 1 ptr
mov r2, 0 ; zero sprite 2 ptr
mov r5, 0 ; zero tic cntr
mov r7, 1
mov r6, 2 ; page reg

mov r0, 0
mov [0xD:0x0], r0 ; zero pinwheel 1 low instr ptr
mov [0xD:0x1], r0 ; high ptr
mov [0xD:0x2], r0 ; zero pinwheel 2 low instr ptr
mov [0xD:0x3], r0 ; high ptr

main:
inc r5; new tic

;Modulo 2 I know this is way easier but let me use my modulo code damnnit
mov r9, r5; mov counter into r9
mov r0, 2
mov r8, r0; load modulo
mov r0, 0
mov r7, r0; load modulo
sub r9, r8
skip nc, 0; four lines for underflow
;sub r9, r7; sub zero for flags
skip z, 1 ; check zero flag
jr -4
gosub load_sprite_1

; modulo 3
mov r9, r5; mov counter into r9
mov r0, 3
mov r8, r0; load modulo
mov r0, 0
mov r7, r0; load modulo
sub r9, r8
skip nc, 0; four lines for underflow
;sub r9, r7; sub zero for flags
skip z, 1 ; check zero flag
jr -4
gosub load_sprite_2

; Tic
mov r0,0x8 ; slow clock a bit
mov [0xF1], r0
or r0, r0 ; No op
or r0, r0 ; No op
or r0, r0 ; No op
or r0, r0 ; No op
or r0, r0 ; No op
or r0, r0 ; No op
mov r0,0x0 ; speed clock
mov [0xF1], r0
goto main

load_sprite_1:
mov pch, 0xD ; load sprite space jump
mov pcm, 0x0 ;
mov jsr, r1 ; JUMP!
ret r0, 0

load_sprite_2:
mov pch, 0xD ; load sprite space jump
mov pcm, 0x1 ; 
mov jsr, r2 ; JUMP!
mov r0, r2  ; save Pinwheel 1 ptr
ret r0, 0

org 0xD00 ; sprite 1 Jumps
goto s1_frame1
goto s1_frame2
goto s1_frame3
goto s1_frame4
goto s1_frame5
goto s1_frame6
goto s1_frame7
goto s1_frame8

org 0xD10
goto s2_frame1
goto s2_frame2
goto s2_frame3
goto s2_frame4
goto s2_frame5
goto s2_frame6
goto s2_frame7
goto s2_frame8

org 0xD20 ; check my jumps
or r0, r0 ; No op


org 0xF00 ; sprite 1
s1_frame1:
mov r0, 0x0
mov [3:4], r0; undo leftovers
mov [3:5], r0; undo leftovers
mov [3:6], r0; undo leftovers
mov r0, 0xF
mov [3:3], r0
inc r1
inc r1
ret r0, 0

s1_frame2:
mov r0, 0x1 ; Undo / bit 1
mov [3:3], r0
mov r0, 0x2; bit 2
mov [3:2], r0
mov r0, 0x4 ; bit 3
mov [3:1], r0
mov r0, 0x8 ; bit 4
mov [3:0], r0
inc r1
inc r1
ret r0, 0

s1_frame3:
mov r0, 0x1; undo/bit 2
mov [3:2], r0
mov [3:1], r0; undo/bit 3
mov [3:0], r0; undo/bit 4
inc r1
inc r1
ret r0, 0

s1_frame4:
mov r0, 0x0 ; Undo bits 2-4
mov [3:2], r0
mov [3:1], r0
mov [3:0], r0
mov r0, 0x2; bit 2
mov [2:0], r0
mov r0, 0x4 ; bit 3
mov [2:1], r0
mov r0, 0x8 ; bit 4
mov [2:2], r0
inc r1
inc r1
ret r0, 0

s1_frame5:
mov r0, 0x0 ; Undo bits 2, 3, 4
mov [2:0], r0
mov [2:1], r0
mov [2:2], r0
mov r0, 0xE ; load val
mov [2:3], r0
inc r1
inc r1
ret r0, 0

s1_frame6:
mov r0, 0x0 ; Undo bits 2, 3, 4
mov [2:3], r0
mov r0, 0x2; bit 2
mov [2:6], r0
mov r0, 0x4 ; bit 3
mov [2:5], r0
mov r0, 0x8 ; bit 4
mov [2:4], r0
inc r1
inc r1
ret r0, 0

s1_frame7:
mov r0, 0x0
mov [2:4], r0; undo bit 2
mov [2:5], r0; undo bit 3
mov [2:6], r0; undo bit 4
mov r0, 0x1
mov [3:4], r0; bit 2
mov [3:5], r0; bit 3
mov [3:6], r0; bit 4
inc r1
inc r1
ret r0, 0

s1_frame8:
mov r0, 0x0; undo bit 2
mov [3:4], r0
mov [3:5], r0; undo bit 3
mov [3:6], r0; undo bit 4
mov r0, 0x8; bit 2
mov [3:6], r0
mov r0, 0x4 ; bit 3
mov [3:5], r0
mov r0, 0x2 ; bit 4
mov [3:4], r0
mov r0, 0
and r1, r0
ret r0, 0



s2_frame1:
mov r0, 0x0
mov [2:13], r0; undo leftovers
mov [2:14], r0; undo leftovers
mov [2:15], r0; undo leftovers
mov r0, 0xF
mov [2:12], r0
inc r2
inc r2
ret r0, 0

s2_frame2:
mov r0, 0x8 ; Undo / bit 1
mov [2:12], r0
mov r0, 0x4; bit 2
mov [2:11], r0
mov r0, 0x2 ; bit 3
mov [2:10], r0
mov r0, 0x1 ; bit 4
mov [2:9], r0
inc r2
inc r2
ret r0, 0

s2_frame3:
mov r0, 0x8; undo/bit 2
mov [2:11], r0
mov [2:10], r0; undo/bit 3
mov [2:9], r0; undo/bit 4
inc r2
inc r2
ret r0, 0

s2_frame4:
mov r0, 0x0 ; Undo bits 2-4
mov [2:11], r0
mov [2:10], r0
mov [2:9], r0
mov r0, 0x4; bit 2
mov [3:9], r0
mov r0, 0x2 ; bit 3
mov [3:10], r0
mov r0, 0x1 ; bit 4
mov [3:11], r0
inc r2
inc r2
ret r0, 0

s2_frame5:
mov r0, 0x0 ; Undo bits 2, 3, 4
mov [3:11], r0
mov [3:10], r0
mov [3:9], r0
mov r0, 0x7 ; load val
mov [3:12], r0
inc r2
inc r2
ret r0, 0

s2_frame6:
mov r0, 0x0 ; Undo bits 2, 3, 4
mov [3:12], r0
mov r0, 0x1; bit 2
mov [3:13], r0
mov r0, 0x2 ; bit 3
mov [3:14], r0
mov r0, 0x4 ; bit 4
mov [3:15], r0
inc r2
inc r2
ret r0, 0

s2_frame7:
mov r0, 0x0
mov [3:13], r0; undo bit 2
mov [3:14], r0; undo bit 3
mov [3:15], r0; undo bit 4
mov r0, 0x8
mov [2:13], r0; bit 2
mov [2:14], r0; bit 3
mov [2:15], r0; bit 4
inc r2
inc r2
ret r0, 0

s2_frame8:
mov r0, 0x0; undo bit 2
mov [2:13], r0
mov [2:14], r0; undo bit 3
mov [2:15], r0; undo bit 4
mov r0, 0x4; bit 2
mov [2:13], r0
mov r0, 0x2 ; bit 3
mov [2:14], r0
mov r0, 0x1 ; bit 4
mov [2:15], r0
mov r0, 0
and r2, r0
ret r0, 0