transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Chia-Yu\ Wang/Desktop/Computer-System-Design/design {C:/Users/Chia-Yu Wang/Desktop/Computer-System-Design/design/t_1017_3.sv}
vlog -sv -work work +incdir+C:/Users/Chia-Yu\ Wang/Desktop/Computer-System-Design/design {C:/Users/Chia-Yu Wang/Desktop/Computer-System-Design/design/mcu.sv}

