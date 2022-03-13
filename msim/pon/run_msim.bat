vlib work
vmap work work
vlog -work work c_dcdc.v c_ldo.v c_psw.v c_plim.v c_delay.v m_poff.v m_top.v m_cpu.sv
if not @%ERRORLEVEL%@==@0@ goto stop
vlog -work work tb_top.sv
if not @%ERRORLEVEL%@==@0@ goto stop
vsim -c tb_top -L work -do "do vsim.do; run 1sec; quit"
if not @%ERRORLEVEL%@==@0@ goto stop
call vsim -do "do wave.do" vsim.wlf
exit
:stop
pause
