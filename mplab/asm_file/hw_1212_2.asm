#include <p16Lf1826.inc>

min      equ 0x21
sec      equ 0x22
minCnt   equ 0x23
secCnt   equ 0x24

		org 0x00  

start	clrf min         ;// ran[min] = 0
		clrf sec         ;// ran[sec] = 0
		movlw .60        ;// w <= 60   
		movwf minCnt     ;// ram[minCnt] = 60

loopMin movlw .59        ;// w <= 59
		movwf secCnt     ;// ram[secCnt] <= w -> ram[24] = 59
		movlw 1          ;// w <= 1           -> w = 1

loopSec addwf sec,1      ;// ram[sec] += w    -> ram[22] = 1
		decfsz secCnt,1  ;// ram[secCnt]-- if = 0 skip   -> ram[24] = 58 
		bra loopSec      ;// 做59次 59,58,57....1 0不會做這行 
		
		clrf sec
   		decfsz minCnt,1  ;// ram[minCnt]-- if = 0 skip   -> ram[23] = 59
		bra addmin       ;// 去做ram[min]++
		bra start        ;// 如果是第60次就初始化

addmin addwf min,1       ;// ram[min] += w
	   bra loopMin	     	
	   return
	   end

;int min = 0;
;int sec = 0;
;for(int i=60;i>0;i--){
;	sec++;
;	for(int j=59;j>0;j--){
;		sec++; //0 1 2 ~ 59
;	}
;	sec = 0;
;	min++;
;}
		