.orig x3000

main	jsr init
		jsr find_max
		
halt

a .blkw 3 ;array with 20 elements
size .fill #3
max .blkw 1

init

lea r3, a
ld r4,size

loop brz end_loop
		str r4, r3, #0
		add r3,r3, #1
		add r4,r4, #-1
		br loop 
		end_loop

ret

find_max

lea r3,a 
lea r5, max
ld r4,size
ldr r1, r3, #0
add r3,r3, #1
add r4,r4, #-1

loop1 brz end_loop1
		ldr r0, r3, #0
		add r6,r0, #0
		not r0, r0
		add r0,r0, #1
		add r0, r0, r1
		brzp	continue
				add r1, r6, #0
				str r1, r5, #0
		continue
		add r3, r3, #1
		add r4,r4, #-1
		br loop1
		end_loop1

ret
.end
