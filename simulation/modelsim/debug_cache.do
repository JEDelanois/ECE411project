delete wave *
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -label clk -noupdate -height 15 /mp3_tb_phys/dut/clk
add wave -label CPU_instr_read -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_read
add wave -label pmem_read -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/pmem_read
add wave -label CPU_instr_resp -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_resp
add wave -label pmem_resp -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/pmem_resp
add wave -label CPU_instr_addr -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_addr
add wave -label pmem_addr -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/pmem_addr
add wave -label CPU_instr_rdata -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/CPU_instr_rdata
add wave -label pmem_rdata -noupdate -height 15 /mp3_tb_phys/dut/Cache_Module/pmem_rdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {324793 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 342
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
WaveRestoreZoom {0 ps} {436564 ps}
restart -f
run 2000ns
radix -hexadecimal
