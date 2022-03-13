
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module m_cpu (pin);
input pin;

wire [15:0] pin;

typedef enum logic [1:0] {
  S_OFF, S_BOOT, S_INIT, S_MAIN
} t_cpu;

t_cpu st_cpu;

parameter ton = 1_00;         //on delay [1ms]
parameter t_boot = 10_00;     //boot time [10ms]
parameter t_init = 10_00;     //init time [10ms]

wire en;

assign #(ton) en = (pin > 3_00);

initial begin
  st_cpu = S_OFF;

  @(posedge en) st_cpu = S_BOOT;
  #(t_boot) st_cpu = S_INIT;
  #(t_init) st_cpu = S_MAIN;
end

endmodule
