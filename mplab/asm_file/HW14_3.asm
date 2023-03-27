#include <p16Lf1826.inc>

a 		equ 0x25  
c 		equ 0x24  
answer  equ 0x23        ;//題目中count變數就是answer
count   equ 0x22
temp    equ 0x21
mod     equ 0x20
		org 0x00     
		clrf count       ;// count <- 0
		movlw .21     	 ;// w <- 21
		movwf a       	 ;// a <- w (a = 21)
		movlw 3      	 ;// w <- 3
		movwf c     	 ;// c <- w (c = 3)
		clrf temp        ;// temp <- 0
loop	movf c,0         ;// w <- c (w = c)
	    subwf a,1        ;// a <- a - w (a = a - c)
		movlw 1          ;// w <- 1 (w = 1)
		addwf count,1    ;// count <- w + count (count++)
		btfss a,7
		goto loop  		

		subwf count,1    ;// count--
		movf count,0     ;// w <- count
		movwf answer     ;// answer <- w 
		movwf PORTB      ;// port_b <- w (port_b = count = answer)
		movf a,0         ;// w <- a
		subwf temp,1     ;// temp = temp - w (temp -= a) (temp = 0-a)
		movf c,0         ;// w <- c (w = c)
		movwf mod        ;// mod <- w (mod = c)
		movf temp,0      ;// w <- temp
		subwf mod,1      ;// mod <- mod - w (mod = mod - temp) (mod = c - temp)
		movf mod,0       ;// w <- mod
		movwf PORTB      ;// port_b <- w (port_b = mod) 		
		end           
