#include <p16Lf1826.inc>

temp    equ 0x25
temp1   equ 0x24
        org   0x00  ;reset vector
        movlw 03  ;w=3
        movwf temp  ;ram[25]=3
        movlw 01  ;w=1;
  movwf temp1  ;ram[24]=1

loop    incf temp1, 1   ;ram[24]++
  decfsz temp, 1  ;if(ram[25]!=0)ram[25]--
  goto loop  ;goto前兩行程式位址
  movf temp1,0 ;w=ram[24]
  bcf temp1, 2 ;ram[24]=0;
  bsf temp, 3  ;ram[25]=8;
  btfsc temp, 3
  btfss temp, 3
  movf temp1, 0
  movf temp, 0
  goto $   ;stop
  end