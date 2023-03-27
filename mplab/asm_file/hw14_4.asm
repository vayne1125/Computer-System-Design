#include <p16Lf1826.inc>

a 		equ 0x25  
c 		equ 0x24  
answer  equ 0x23       
temp    equ 0x21
mod     equ 0x20

		org 0x00     
		movlw .36     	 ;// w <- 36
		movwf a       	 ;// a <- w (a = 36)
		movlw .21      	 ;// w <- 21
		movwf c     	 ;// c <- w (c = 21)

;// mod = a%c
loop	movf c,0         ;// w <- c (w = c)
	    subwf a,1        ;// a <- a - w (a = a - c)
		btfss a,7
		goto loop  		
		movf a,0         ;// w <- a
		clrf temp        ;// temp <- 0
		subwf temp,1     ;// temp = temp - w (temp -= a) (temp = 0-a)
		movf c,0         ;// w <- c (w = c)
		movwf mod        ;// mod <- w (mod = c)
		movf temp,0      ;// w <- temp
		subwf mod,1      ;// mod <- mod - w (mod = mod - temp) (mod = c - temp)
		movf c,0         ;// w <- c
		movwf a          ;// a <- w (a = c)
		movf mod,0       ;// w <- mod
		movwf c          ;// c <- w (c = mod)
		btfss c,7        
		goto test0       ;// >=0 會跳去檢驗是否為0
        goto loweq0      ;// <0  則跳出迴圈

;//檢驗是否為0
test0   movf c,0         ;// w <- c
		movwf temp       ;// temp <- w (temp = c)
		decf temp        ;// temp--
		btfss temp,7     ;// >=0 就回loop
		goto loop        
		goto loweq0      ;// <0  則跳出迴圈

;//<=0則
loweq0  movf a,0         ;// w <- a
		movwf answer     ;// ans <- w
		movwf PORTB      ;// port_b <- w (port_b = a)	
		end           
