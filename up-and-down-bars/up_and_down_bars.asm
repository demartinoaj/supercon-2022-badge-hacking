; pre-init extra space
goto init
or r0, r0 ; No op
or r0, r0

; init
org 0x200 ; give me some space
init: 
mov r0,2  ; show to page 2 and 3 which is empty for display
mov [0xF0], r0
mov r0,4 ; slow clock a bit
mov [0xF1], r0
mov r0, 0xF ; draw inital bars
mov [2:0], r0
mov [3:15], r0

mov r1, 2 ; bar 1 page
mov r2, 14 ; bar 1 starting addr
mov r3, 3 ; bar page
mov r4, 1 ; bar 2 starting addr

main:
mov r0, [r1:r2] ; grab bar 1
inc r2
mov [r1:r2], r0 ; copy it down

mov r0, [r3:r4] ; grab bar 2
dec r4
mov [r3:r4], r0; copy it down

sub r2, r1 ; sub 2 lol, goes to next row
add r4, r1;
goto main