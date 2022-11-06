; starting space
; inst mem Map MSB->LSB:
;   [1110] - sprite  Jump space
;   [0000] - sprite
;   [0000] - sprite instruction 
;  
;   [1111 0000 0000] - sprite instruction space
;
; Data mem map:
;    [0xD: 0x0] - pinwheel 1 inst ptr, low
;    [0xD: 0x1] - pinwheel 1 inst ptr, high
;    [0xD: 0x2] - pinwheel 2 inst ptr, low
;    [0xD: 0x3] - pinwheel 2 inst ptr, high 
;
; Reg Map:
;   ro: resevered
;	r1: obj ptr, low
;   r9: scratch 

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
mov r1, 0 ; zero low obj ptr 
mov r2, 0 ; zero high obj ptr

mov r0, 0
mov [0xD:0x0], r0 ; zero pinwheel 1 low instr ptr
mov [0xD:0x1], r0 ; high ptr
mov [0xD:0x2], r0 ; zero pinwheel 2 low instr ptr
mov [0xD:0x3], r0 ; high ptr

main:
mov r0, [0xD:0x0] ; load Pinwheel 1 ptr
mov r1, r0
mov pch, 0xD ; load sprite space jump
mov pcm, 0x0 ;
mov jsr, r1 ; JUMP!
mov r0, r1  ; save Pinwheel 1 ptr
mov [0xD:0x0], r0 
mov r0,0x9 ; slow clock a bit
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

org 0xD00 ; sprite 1 Jumps
goto s1_frame1
goto s1_frame2
goto s1_frame3
goto s1_frame4
goto s1_frame5
goto s1_frame6
goto s1_frame7
goto s1_frame8
org 0xD10 ; check my jumps
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