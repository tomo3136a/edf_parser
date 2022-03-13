onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 24 -max 3200.0 /tb_dcdc/i_dcdc/pin
add wave -noupdate -format Analog-Step -height 24 -max 3200.0 /tb_dcdc/i_dcdc/bias
add wave -noupdate -format Analog-Step -height 24 -max 750.0 /tb_dcdc/i_dcdc/pout
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Analog-Step -height 24 -max 3200.0 /tb_dcdc/i_dcdc/pin_1
add wave -noupdate -format Analog-Step -height 24 -max 200.0 -min -200.0 /tb_dcdc/i_dcdc/offset_pout
add wave -noupdate -format Analog-Step -height 24 -max 750.0 /tb_dcdc/i_dcdc/s_cnt
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_dcdc/i_dcdc/pg
add wave -noupdate /tb_dcdc/i_dcdc/ov
add wave -noupdate /tb_dcdc/i_dcdc/en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84358 us} 0}
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
configure wave -timelineunits sec
update
WaveRestoreZoom {0 us} {246096 us}
