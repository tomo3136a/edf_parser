onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 34 -max 4200.0 /tb_top/pin
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_top/i_top/uv_n
add wave -noupdate /tb_top/i_top/flt_plim_n
add wave -noupdate /tb_top/i_top/en_plim
add wave -noupdate /tb_top/i_top/shdn_in
add wave -noupdate /tb_top/i_top/psw_n
add wave -noupdate /tb_top/i_top/shdn_n
add wave -noupdate /tb_top/i_top/poff_trg
add wave -noupdate /tb_top/i_top/poff_n
add wave -noupdate /tb_top/i_top/ov
add wave -noupdate -format Analog-Step -height 34 -max 4200.0 /tb_top/i_top/p42
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Analog-Step -height 34 -max 1450.0 /tb_top/i_top/p14r5
add wave -noupdate -format Analog-Step -height 34 -max 550.0 /tb_top/i_top/p12
add wave -noupdate -format Analog-Step -height 34 -max 550.0 /tb_top/i_top/p8a
add wave -noupdate -format Analog-Step -height 34 -max 550.0 /tb_top/i_top/p5r5
add wave -noupdate -format Analog-Step -height 34 -max 550.0 /tb_top/i_top/p3r8
add wave -noupdate -format Analog-Step -height 34 -max 550.0 /tb_top/i_top/p3r3
add wave -noupdate /tb_top/i_top/p1r2
add wave -noupdate /tb_top/i_top/p1r8
add wave -noupdate /tb_top/i_top/p2r5
add wave -noupdate /tb_top/i_top/p3r3d
add wave -noupdate /tb_top/i_top/p1r8d
add wave -noupdate /tb_top/i_top/p3r3a
add wave -noupdate /tb_top/i_top/pg_p42
add wave -noupdate /tb_top/i_top/pg_p14r5
add wave -noupdate /tb_top/i_top/pg_p12
add wave -noupdate /tb_top/i_top/pg_p5r5
add wave -noupdate /tb_top/i_top/pg_p3r3
add wave -noupdate /tb_top/i_top/pg_p1r8
add wave -noupdate /tb_top/i_top/pg_p2r5
add wave -noupdate /tb_top/i_top/ov_p42
add wave -noupdate /tb_top/i_top/ov_p14r5
add wave -noupdate /tb_top/i_top/ov_p12
add wave -noupdate /tb_top/i_top/ov_p5r5
add wave -noupdate /tb_top/i_top/ov_p3r3
add wave -noupdate /tb_top/i_top/ov_p1r8
add wave -noupdate /tb_top/i_top/ov_p2r5
add wave -noupdate /tb_top/i_top/pg_p3r8
add wave -noupdate /tb_top/i_top/ov_p3r8
add wave -noupdate /tb_top/i_top/pg_p1r2
add wave -noupdate /tb_top/i_top/ov_p1r2
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_top/i_top/i_poff/shdn_in
add wave -noupdate /tb_top/i_top/i_poff/psw_n
add wave -noupdate /tb_top/i_top/i_poff/shdn_1
add wave -noupdate /tb_top/i_top/i_poff/poff_trg
add wave -noupdate /tb_top/i_top/i_poff/shdn_2
add wave -noupdate /tb_top/i_top/i_poff/shdn_3
add wave -noupdate /tb_top/i_top/i_poff/poff_n
add wave -noupdate /tb_top/i_top/i_poff/ov
add wave -noupdate /tb_top/i_top/i_poff/uv_n
add wave -noupdate /tb_top/i_top/i_poff/shdn_n
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Analog-Step -height 24 -max 4200.0 /tb_top/i_top/i_plim/pin
add wave -noupdate -format Analog-Step -height 24 -max 4000.0 /tb_top/i_top/i_plim/pout
add wave -noupdate /tb_top/i_top/i_plim/shdn_n
add wave -noupdate /tb_top/i_top/i_plim/uv_n
add wave -noupdate /tb_top/i_top/i_plim/flt_ov
add wave -noupdate -format Analog-Step -height 24 -max 5400.0 /tb_top/i_top/i_plim/s_cnt
add wave -noupdate /tb_top/i_top/i_plim/flt_n
add wave -noupdate /tb_top/i_top/i_plim/en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {148592 us} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
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
WaveRestoreZoom {0 us} {505912 us}
