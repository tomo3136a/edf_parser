
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module comp_reset(wdt_rst_n, rst_n, wdi, soft_rst_n, sw_rst_n, rst2_n);
output wdt_rst_n, rst_n;
input wdi, soft_rst_n, sw_rst_n, rst2_n;

reg wdt_mr_n, dff_pre_n, dff_d;
wire wdt_rst_n, dff_q, dff_q_n;
wire delay_q, rst_mr_n;
wire rst1_n, rst2_n;
wire soft_rst_n, sw_rst_n;
wor rst_n;

comp_wdt i_wdt (wdt_rst_n, wdt_mr_n, wdi);
comp_dff i_dff (dff_q, dff_q_n, wdt_rst_n, rst_n, dff_pre_n, dff_d);
comp_delay i_delay (delay_q, dff_q_n);
comp_rst i_rst (rst1_n, rst_mr_n, sw_rst_n);

assign rst_mr_n = delay_q & soft_rst_n;
assign rst_n = rst1_n;
assign rst_n = rst2_n;

initial	// Test stimulus
  begin
    wdt_mr_n = 1'b1;
    dff_d = 1'b1;
    dff_pre_n = 1'b1;
  end

endmodule
