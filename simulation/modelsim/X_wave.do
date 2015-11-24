onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb_phys/dut/clk
add wave -noupdate -label regFile -expand /mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/gen_bubble
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/squash_ID
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/branch_counter_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/ID_EX_ir
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/gen_bubble
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/squash_ID
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/branch_enable
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/branch_enable_latch/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/ID_EX_Latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_MEM_Latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/MEM_WB_latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/PC_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/ID_EX_Latch/PC_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_MEM_Latch/PC_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/MEM_WB_latch/PC_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/aluop
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/a
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/b
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/f
add wave -noupdate -label startDIVMUltclk /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/clk
add wave -noupdate -label sr1in /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1
add wave -noupdate -label sr2in /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2
add wave -noupdate -label miniALUop /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/aluop
add wave -noupdate -label flow /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/flow
add wave -noupdate -label solution_out /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solution
add wave -noupdate -label stall_X /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/stall_X
add wave -noupdate -label calc_done /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/calc_done
add wave -noupdate -label sr1_load /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1_load
add wave -noupdate -label sr2_load /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2_load
add wave -noupdate -label sol_load /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sol_load
add wave -noupdate -label state_in /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/statereg/in
add wave -noupdate -label state_load /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/statereg/load
add wave -noupdate -label state_out /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/statereg/data
add wave -noupdate -label bmux_sel /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux_sel
add wave -noupdate -label sr1reg_out /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1reg_out
add wave -noupdate -label sr2reg_out /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2reg_out
add wave -noupdate -label solreg_out /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solreg_out
add wave -noupdate -label sr1mux_sel /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1mux/sel
add wave -noupdate -label sr1mux_a /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1mux/a
add wave -noupdate -label sr1mux_b /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1mux/b
add wave -noupdate -label sr1mux_c /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1mux/c
add wave -noupdate -label sr1mux_d /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1mux/d
add wave -noupdate -label sr1mux_f /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr1mux/f
add wave -noupdate -label sr2mux_sel /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2mux/sel
add wave -noupdate -label sr2mux_a /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2mux/a
add wave -noupdate -label sr2mux_b /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2mux/b
add wave -noupdate -label sr2mux_c /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2mux/c
add wave -noupdate -label sr2mux_d /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2mux/d
add wave -noupdate -label sr2mux_f /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/sr2mux/f
add wave -noupdate -label bmux_sel /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux/sel
add wave -noupdate -label bmux_a /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux/a
add wave -noupdate -label bmux_b /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux/b
add wave -noupdate -label bmux_c /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux/c
add wave -noupdate -label bmux_d /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux/d
add wave -noupdate -label bmux_f /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/bmux/f
add wave -noupdate -label solmux_sel /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solmux/sel
add wave -noupdate -label solmux_a /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solmux/a
add wave -noupdate -label solmux_b /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solmux/b
add wave -noupdate -label solmux_c /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solmux/c
add wave -noupdate -label solmux_d /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solmux/d
add wave -noupdate -label solmux_f /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/solmux/f
add wave -noupdate -label miniALU_alupo /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/mini_alu/aluop
add wave -noupdate -label miniALU_a /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/mini_alu/a
add wave -noupdate -label miniALU_b /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/mini_alu/b
add wave -noupdate -label miniALU_f /mp3_tb_phys/dut/LC3b_CPU/EX_module/divmultuinit/mini_alu/f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {663320 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 157
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {67542 ps} {687938 ps}
