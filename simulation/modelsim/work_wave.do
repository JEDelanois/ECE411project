onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave /mp3_tb*
add wave -noupdate -radix hexadecimal /mp3_tb/clk
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/IF_Logic/pcmux_sel
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/IF_Logic/pc_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/IF_Logic/pcmux_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/IF_Logic/pc_plus2_out
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/ID_Logic/IR
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[7]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[6]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[5]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[4]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[3]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[2]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[1]} -radix hexadecimal} {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[7]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[6]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[5]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[4]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[3]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[2]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[1]} {-height 16 -radix hexadecimal} {/mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data[0]} {-height 16 -radix hexadecimal}} /mp3_tb/dut/LC3b_CPU/ID_Logic/LC3b_RegFile/data
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/ALU/aluop
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/ALU/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/ALU/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/ALU/f
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/sel
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/a
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/b
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/c
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/d
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/e
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/f
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/g
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/h
add wave -noupdate -radix hexadecimal /mp3_tb/dut/LC3b_CPU/EX_module/alumuux/z
add wave -noupdate -radix hexadecimal /mp3_tb/mem_read1
add wave -noupdate -radix hexadecimal /mp3_tb/mem_read2
add wave -noupdate -radix hexadecimal /mp3_tb/mem_write2
add wave -noupdate -radix hexadecimal /mp3_tb/mem_addr1
add wave -noupdate -radix hexadecimal /mp3_tb/mem_addr2
add wave -noupdate -radix hexadecimal /mp3_tb/mem_rdata1
add wave -noupdate -radix hexadecimal /mp3_tb/mem_rdata2
add wave -noupdate -radix hexadecimal /mp3_tb/mem_wdata2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {174922 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 352
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
configure wave -timelineunits ps
update
WaveRestoreZoom {81196 ps} {332777 ps}
restart -f
