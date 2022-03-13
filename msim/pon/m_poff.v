
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module m_poff(shdn_n, poff_trg, shdn_in, psw_n, poff_n, ov, uv_n);
output shdn_n, poff_trg;
input shdn_in, psw_n, poff_n, ov, uv_n;

wire shdn_n, poff_trg;
wire shdn_in, psw_n, poff_n, ov, uv_n;
wire shdn_1, shdn_2, shdn_3;

//pullup (poff_trg, uv_n);
//pulldown (poff_n, ov);
defparam i_delay.td   = 20;    //200ms

c_delay i_delay (shdn_2, shdn_1);

assign shdn_1 = (~shdn_in) & (~psw_n);
assign shdn_3 = shdn_1 | (poff_n & shdn_2);
assign shdn_n = shdn_3 & (~ov) & uv_n;
assign poff_trg = (shdn_1) ? 1'b0 : 1'bz;

endmodule
