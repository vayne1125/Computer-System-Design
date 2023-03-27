#include <p16Lf1826.inc>

temp    equ 0x25
temp1   equ 0x24

		org 0x00  
start   movlw .60        ;// w <= 60
		movwf temp1      ;// ram[temp1] <= w  -> ram[24] = 60
		clrf temp        ;// ram[temp] <= 0   -> ram[25] = 0
		clrw			 ;// w <= 0           -> w = 0
loop1	movwf PORTB      ;// portb <= w       -> portb = 0	
	    movlw 1          ;// w <= 1           -> w = 1
		addwf temp,1     ;// ram[temp] += w   -> ram[25] = 1 
		movf temp,0      ;// w <= ram[temp]   -> w = 1             
		decfsz temp1,1   ;// ram[temp1]-- if = 0 skip   -> ram[24] = 59 
		bra loop1        ;// 做60次 60,59,58,57....1 0不會做這行
		bra start        ;// 重來
		return
		end
		