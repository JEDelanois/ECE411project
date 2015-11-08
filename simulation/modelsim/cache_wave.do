delete wave *
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -label clk -noupdate -height 15 /mp3_tb_phys/clk
add wave -label pcmux_sel -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pcmux_sel
add wave -label pc_out -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pc_out
add wave -label pcmux_out -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pcmux_out
add wave -label pc_plus_2_out -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/IF_Logic/pc_plus2_out
add wave -label  ID_Logic/IR -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/ID_Logic/IR
add wave -label ID_Regfile -noupdate -height 15 -subitemconfig {{/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[7]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[6]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[5]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[4]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[3]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[2]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[1]} {-height 15} {/mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[0]} {-height 15}} /mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data
add wave -label EX_aluop -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/aluop
add wave -label ALU_a -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/a
add wave -label ALU_b -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/b
add wave -label ALU_f -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/ALU/f
add wave -label alumux_a -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/a
add wave -label alumux_b -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/b
add wave -label alumux_c -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/c
add wave -label alumux_d -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/d
add wave -label alumux_e -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/e
add wave -label alumux_f -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/f
add wave -label alumux_g -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/g
add wave -label alumux_h -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/h
add wave -label alumux_sel -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/sel
add wave -label alumux_z -noupdate -height 15 /mp3_tb_phys/dut/LC3b_CPU/EX_module/alumuux/z
add wave -label instr_read -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_read
add wave -label instr_resp -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_resp
add wave -label CPU_data_read -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_read
add wave -label CPU_data_resp -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_resp
add wave -label CPU_data_write -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_write
add wave -label CPU_instr_addr -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_addr
add wave -label CPU_data_addr -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_addr
add wave -label CPU_instr_rdata -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_rdata
add wave -label CPU_data_rdata -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_rdata
add wave -label CPU_data_wdata -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_wdata
add wave -label CPU_data_byte_enable -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_data_byte_enable
add wave -position end  sim:/mp3_tb_phys/dut/Cache_Module/Instruction_Cache_L1/cache_data/way_one/data/data
add wave -position end  sim:/mp3_tb_phys/dut/Cache_Module/Instruction_Cache_L1/cache_data/way_two/data/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {145546 ps}
restart -f
run 60000ns
radix -hexadecimal
