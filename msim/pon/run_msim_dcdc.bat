vlib work
vmap work work
vlog -work work c_dcdc.v
if not @%ERRORLEVEL%@==@0@ goto stop
vlog -work work tb_dcdc.v
if not @%ERRORLEVEL%@==@0@ goto stop
vsim -c tb_dcdc -L work -do "do vsim.do; run 60sec; quit"
if not @%ERRORLEVEL%@==@0@ goto stop
call vsim -do "do wave_dcdc.do" vsim.wlf
exit
:stop
pause
