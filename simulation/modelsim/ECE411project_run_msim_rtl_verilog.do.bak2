transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/writeback_module.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/mp3.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/memory_module.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/latch_wb.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/latch_if_id.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/latch_id_ex.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/latch_ex_mem.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/instruction_fetch.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/instruction_decode.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/execution_module.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/cpu_datapath.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/cpu_control.sv}
vlog -sv -work work +incdir+/home/thomasn2/ece411/ECE411project {/home/thomasn2/ece411/ECE411project/cpu.sv}

