vlib work
vmap work work
vlog -work work comp_wdt.v comp_dff.v comp_delay.v comp_rst.v comp_reset.v comp_reset_k.v
vlog -work work tb_reset_k.v
vsim -c tb_reset_k -L work -do "do wave_k.do; run 60sec; quit"
call vsim -do "do wave_k2.do" vsim.wlf
