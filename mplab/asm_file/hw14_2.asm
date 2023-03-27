#include <p16Lf1826.inc>

a 		equ 0x25  
c 		equ 0x24  
answer  equ 0x23
count   equ 0x22

		org 0x00     
		movlw 5     	 ;// w <- 5
		movwf a       	 ;// a <- w (a = 5)
		movlw 3      	 ;// w <- 3
		movwf c     	 ;// c <- w (c = 3)
		movf  c,0        ;// w <- c
		movwf count      ;// count <- w (count = c)
		clrf answer 	 ;// answer = 0
        movf a,0 	     ;// w <- a (w = 5)
loop	addwf answer,1   ;// answer <- w + answer (ans = a + ans) 
		decfsz count,1   ;// count--
		goto loop
		movf answer,0    ;// w <- answer
		movwf PORTB      ;// port_b <- w (port_b = ans)
		end           
