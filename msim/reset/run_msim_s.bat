vlib work
vmap work work
vlog -work work comp_wdt.v comp_dff.v comp_delay.v comp_rst.v comp_reset.v
vlog -work work tb_reset.v
vsim -c tb_reset -L work -do "do wave_s.do; run 60sec; quit"
call vsim -do "do wave_s2.do" vsim.wlf
