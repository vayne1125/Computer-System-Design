#include <p16Lf1826.inc>

hr      equ 0x21
min      equ 0x22
hrCnt   equ 0x23
minCnt   equ 0x24

		org 0x00  

start	clrf hr          ;// ran[hr] = 0
		clrf min         ;// ran[min] = 0
		movlw .24        ;// w <= 24   
		movwf hrCnt      ;// ram[hrCnt] = 24

loopHr movlw .59         ;// w <= 59
		movwf minCnt     ;// ram[minCnt] <= w -> ram[24] = 59
		movlw 1          ;// w <= 1           -> w = 1

loopMin addwf min,1      ;// ram[min] += w    -> ram[22] = 1
		decfsz minCnt,1  ;// ram[minCnt]-- if = 0 skip   -> ram[24] = 58 
		bra loopMin      ;// 做59次 59,58,57....1 0不會做這行 
		
		clrf min
   		decfsz hrCnt,1   ;// ram[hrCnt]-- if = 0 skip   -> ram[23] = 59
		bra addhr        ;// 去做ram[hr]++
		bra start        ;// 如果是第60次就初始化

addhr  addwf hr,1       ;// ram[hr] += w
	   bra loopHr	     	
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
		