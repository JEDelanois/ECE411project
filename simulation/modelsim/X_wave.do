onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb_phys/dut/clk
add wave -noupdate -expand /mp3_tb_phys/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {325000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 465
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
WaveRestoreZoom {1883276 ps} {2073266 ps}
