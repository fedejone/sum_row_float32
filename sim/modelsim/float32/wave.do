onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Addition_float32_tb/clk
add wave -noupdate /Addition_float32_tb/rst_n
add wave -noupdate -radix hexadecimal /Addition_float32_tb/data
add wave -noupdate -radix hexadecimal /Addition_float32_tb/result
add wave -noupdate /Addition_float32_tb/uut_paralel_sum_float32/clk_i
add wave -noupdate /Addition_float32_tb/uut_paralel_sum_float32/rst_n
add wave -noupdate -radix hexadecimal /Addition_float32_tb/uut_paralel_sum_float32/data_i
add wave -noupdate -radix hexadecimal /Addition_float32_tb/uut_paralel_sum_float32/data_o
add wave -noupdate -radix hexadecimal /Addition_float32_tb/uut_paralel_sum_float32/data_reg
add wave -noupdate /Addition_float32_tb/uut_paralel_sum_float32/difference_data
add wave -noupdate -radix binary /Addition_float32_tb/uut_paralel_sum_float32/data_sum
add wave -noupdate /Addition_float32_tb/uut_paralel_sum_float32/sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 426
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
WaveRestoreZoom {0 ps} {83716 ps}
