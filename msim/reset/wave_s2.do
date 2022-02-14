onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_reset/soft_rst_n
add wave -noupdate /tb_reset/sw_rst_n
add wave -noupdate /tb_reset/s_rst2_n
add wave -noupdate /tb_reset/s_wdi
add wave -noupdate /tb_reset/wdt_rst_n
add wave -noupdate /tb_reset/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ns} {63 sec}
