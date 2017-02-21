;DESCRIPTION
; This assembly program performs primality testing based on Fermat's little theorem
; which states that for any given prime p and for every number a in [2,p-2] 
; the following is true: a^(p-1) = 1 mod p
; Note that there are some numbers (Carmichael Numbers) that trick the test.
; Complexity Analysis:
; Arithmetic complexity is O(p) and can be improved to O(log(p)) if exponentiation by squaring is used
; Bit complexity is O(p log p log a) since multiplication of two numbers k and m take O(log k log m) 

.orig x3000

;load numbers a,p
ld r0,a
and r1,r0, #-1 ;this is an intelligent way to copy elements by performing bitwise AND with xFFFF (or -1)
ld r2, p
add r3,r2,#-2

; perform exponentiation a^(p-1) % p the dummy way r0 *= r1 % p
loop brz end_loop	
		jsr mult
		jsr modulo ;call modulo subroutine to derease size
		add r3, r3, #-1
br loop

end_loop
jsr modulo

;if result is 1 then it's probably a prime and the output is 'y'
;otherwise it outputs 'n'
lea r5,result
add r0, r0, #-1
brnp not_zero
add r0,r0, #1

str r0,r5,#0
ld r0,yes
br output

not_zero
and r0, r0, #0
str r0, r5, #0
ld r0,no

output

OUT

end
halt

result .blkw 1 ; boolean value to store result
yes .fill #121
no .fill #110
a .fill #2 ; a can be any number in the range [2,p-2]
p .fill #23 ;candidate (probable) prime

mult ;multiply r0 * r1

add r1,r1, #-1
and r5,r1, #-1

loop0	add r0, r0, r0
		add r1,r1,#-1
brp loop0
and r1,r5,#-1
ret

modulo ; r0 % r2

not r2,r2
add r2,r2,#1

loop1	add r0,r0,r2
brzp loop1

not r2,r2
add r2,r2,#1
add r0,r0,r2
ret

.end
