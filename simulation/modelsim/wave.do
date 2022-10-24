onerror {resume}
quietly WaveActivateNextPane {} 0

#add wave -noupdate -divider {TOP LEVEL INPUTS}

#add wave -noupdate -format Logic /testbench/clk
#add wave -noupdate -format Logic /testbench/rst



add wave -noupdate -divider {adder}

add wave -noupdate -format logic	/testbench/CPU1/reset
add wave -noupdate -format logic    /testbench/CPU1/clk
add wave -noupdate -format Literal -radix Unsigned   	/testbench/CPU1/ps
add wave -noupdate -format Literal -radix Unsigned   	/testbench/CPU1/pc_next
add wave -noupdate -format logic   	/testbench/CPU1/load_pc
add wave -noupdate -format Literal -radix Unsigned   	/testbench/CPU1/pc_q
add wave -noupdate -format logic   	/testbench/CPU1/load_mar
add wave -noupdate -format Literal -radix Unsigned   	/testbench/CPU1/mar_q
add wave -noupdate -format logic   	/testbench/CPU1/load_IR
add wave -noupdate -format Literal -radix Hexadecimal   	/testbench/CPU1/IR

#add wave -noupdate -format Literal -radix Binary 	    /testbench/counter_81/seven_seg  
#add wave -noupdate -format Literal -radix Unsigned 	/testbench/adder1/a
#add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
#add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s
#add wave -noupdate -format logic				 		/testbench/b\[6\]
#add wave -noupdate -format logic				 		/testbench/b\[5\]
