
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module comp_reset_k(wdt_rst_n, rst_n, rstout_n, wdi, soft_rst_n, sw_rst_n, rstin_n);
output wdt_rst_n, rst_n, rstout_n;
input wdi, soft_rst_n, sw_rst_n, rstin_n;

wire dff_q, dff_q_n, rst1_n;

comp_delay i_delay (rstout_n, rstin_n);
comp_dff i_dff (dff_q, dff_q_n, rstin_n, rst1_n, 1'b1, rstout_n);
comp_rst i_rst (rst1_n, dff_q_n, 1'b1);
comp_reset i_reset (wdt_rst_n, rst_n, wdi, soft_rst_n, sw_rst_n, rst1_n);

endmodule
