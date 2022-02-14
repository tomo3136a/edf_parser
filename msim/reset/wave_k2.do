onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_reset_k/soft_rst_n
add wave -noupdate /tb_reset_k/sw_rst_n
add wave -noupdate /tb_reset_k/t_rstin
add wave -noupdate /tb_reset_k/rstin_n
add wave -noupdate /tb_reset_k/rstout_n
add wave -noupdate /tb_reset_k/s_wdi
add wave -noupdate /tb_reset_k/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6584939947 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ns} {61711565585 ns}
