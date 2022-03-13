onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 34 -max 4200.0 /tb_top/i_top/pin
add wave -noupdate -divider p-off
add wave -noupdate /tb_top/i_top/shdn_in
add wave -noupdate /tb_top/i_top/psw_n
add wave -noupdate /tb_top/i_top/poff_trg
add wave -noupdate /tb_top/i_top/poff_n
add wave -noupdate /tb_top/i_top/shdn_n
add wave -noupdate -divider p-limit
add wave -noupdate -format Analog-Step -height 34 -max 4000.0 /tb_top/i_top/pin_1
add wave -noupdate /tb_top/i_top/flt_plim_n
add wave -noupdate /tb_top/i_top/uv_n
add wave -noupdate /tb_top/i_top/en_plim
add wave -noupdate -divider {dc/dc (1)}
add wave -noupdate /tb_top/i_top/en_p14r5
add wave -noupdate -format Analog-Step -height 34 -max 1500.0 /tb_top/i_top/p14r5
add wave -noupdate -format Analog-Step -height 34 -max 1200.0 /tb_top/i_top/p12
add wave -noupdate -format Analog-Step -height 34 -max 800.0 /tb_top/i_top/p8a
add wave -noupdate -format Analog-Step -height 34 -max 550.0 /tb_top/i_top/p5r5
add wave -noupdate -format Analog-Step -height 34 -max 500.0 /tb_top/i_top/p3r8
add wave -noupdate -format Analog-Step -height 34 -max 500.0 /tb_top/i_top/p3r3
add wave -noupdate /tb_top/i_top/ov
add wave -noupdate -divider {dc/dc (2)}
add wave -noupdate -format Analog-Step -height 34 -max 250.0 /tb_top/i_top/p1r2
add wave -noupdate -format Analog-Step -height 34 -max 250.0 /tb_top/i_top/p1r8
add wave -noupdate -format Analog-Step -height 34 -max 250.0 /tb_top/i_top/p2r5
add wave -noupdate -divider ldo
add wave -noupdate -format Analog-Step -height 34 -max 500.0 /tb_top/i_top/p3r3d
add wave -noupdate -format Analog-Step -height 34 -max 500.0 /tb_top/i_top/p1r8d
add wave -noupdate -format Analog-Step -height 34 -max 500.0 /tb_top/i_top/p3r3a
add wave -noupdate /tb_top/i_top/pg_p1r2
add wave -noupdate /tb_top/i_top/pg_p1r8
add wave -noupdate /tb_top/i_top/pg_p2r5
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_top/i_cpu/st_cpu
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53135 us} 0} {{Cursor 2} {53175 us} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {0 us} {1050624 us}
