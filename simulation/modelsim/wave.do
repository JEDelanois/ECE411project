delete wave *
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp3_tb_phys/clk
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pcmux_sel
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pcmux_out
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pc_plus2_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/IR_reg_in
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/IR/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/branch_predict_status_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/ID_EX_Latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/ID_EX_Latch/branch_predict_status_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_MEM_Latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/EX_MEM_Latch/branch_predict_status_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/MEM_WB_latch/IR_out
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/MEM_WB_latch/branch_predict_status_out
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[7]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[6]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[5]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[4]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[3]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[2]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[1]} -radix hexadecimal} {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[7]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[6]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[5]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[4]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[3]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[2]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[1]} {-height 16 -radix hexadecimal} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[0]} {-height 16 -radix hexadecimal}} /mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/inject_NOP
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/flow_control/stall_fetch
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/flow_control/stall_cache2_miss
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/mem_indirect_stall
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/flow_IFID
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/load_pc
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/force_pc_load
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/branch_enable
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/flow_control/flow_IFID
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/flow_control/flow_IDEX
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/flow_control/flow_EXMEM
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/flow_control/flow_MEMWB
add wave -noupdate -radix hexadecimal /mp3_tb_phys/dut/LC3b_CPU/flow_control/mem_indirect_stall
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/branch_enable
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/bubbler/gen_bubble
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/WB_Module/squash_instruction
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/load_latch
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/squash_IF_ID
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/IF_ID_Latch/IR/load
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/curr_pc
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/loaded_pc
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/loaded_predict_pc
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/loaded_predict
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/load_line
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/btb_way_one/orig_pc/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/btb_way_one/predict_pc/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/btb_way_one/valid/data
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/btb_pc_load
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/predicted_pc
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/orig_pc_out1
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/predict_pc_out1
add wave -noupdate /mp3_tb_phys/dut/LC3b_CPU/btb/index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {335000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 422
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
WaveRestoreZoom {19746730 ps} {20013330 ps}
radix hexadecimal
restart -f