#include <p16Lf1826.inc>

		org 0x00     
loop 	movlw 0       ; // w 	  <- 0
		movwf PORTB   ; // port_b <- w
		movlw 0       ; // w      <- 0
		movwf PORTB   ; // port_b <- w
		movlw 9       ; // w 	  <- 9
		movwf PORTB   ; // port_b <- w
		movlw 5       ; // w      <- 5
		movwf PORTB   ; // port_b <- w
		movlw 7       ; // w      <- 7
		movwf PORTB   ; // port_b <- w
		movlw 1       ; // w 	  <- 1
		movwf PORTB   ; // port_b <- w
		movlw 1       ; // w      <- 1
		movwf PORTB   ; // port_b <- w
		movlw 6       ; // w      <- 6
		movwf PORTB   ; // port_b <- w
		goto loop     ; //回到loop的地方
		end           
