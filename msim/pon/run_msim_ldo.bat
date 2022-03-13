vlib work
vmap work work
vlog -work work c_ldo.v
if not @%ERRORLEVEL%@==@0@ goto stop
vlog -work work tb_ldo.v
if not @%ERRORLEVEL%@==@0@ goto stop
vsim -c tb_ldo -L work -do "do vsim.do; run 1sec; quit"
if not @%ERRORLEVEL%@==@0@ goto stop
call vsim -do "do wave_ldo.do" vsim.wlf
exit
:stop
pause
