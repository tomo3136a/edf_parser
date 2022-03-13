onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 74 -max 499.99999999999994 /tb_ldo/i_ldo/pout
add wave -noupdate -format Analog-Step -height 74 -max 3200.0 /tb_ldo/i_ldo/pin
add wave -noupdate /tb_ldo/i_ldo/bias
add wave -noupdate /tb_ldo/i_ldo/en
add wave -noupdate /tb_ldo/i_ldo/pin_1
add wave -noupdate /tb_ldo/i_ldo/pin_2
add wave -noupdate /tb_ldo/i_ldo/s_clk
add wave -noupdate -format Analog-Step -height 74 -max 100.0 /tb_ldo/i_ldo/s_cnt
add wave -noupdate -format Analog-Step -height 74 -max 7999.9999999999991 /tb_ldo/i_ldo/ss_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2195 us} 0} {{Cursor 2} {1195 us} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 us} {32 ms}
