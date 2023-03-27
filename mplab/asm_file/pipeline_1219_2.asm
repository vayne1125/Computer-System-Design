#include <p16LF1826.inc>

temp  equ 0x25

  org 0x00

  movlw .1
  movlw .2
  movlw .3
  movlw .4
  movlw .5
  call  first
  movlw .6
  movlw .7
  goto  $
first  movlw .8
  movlw .9
  return

  end