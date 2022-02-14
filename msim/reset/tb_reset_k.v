
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module tb_reset_k;

reg wdi, z_soft_rst_n, z_sw_rst_n;
wire wdt_rst_n, rst_n, rstout_n;
wire s_wdi, soft_rst_n, sw_rst_n;
reg t_rstin, rstin_n;

//pullup (s_wdi);
pullup (soft_rst_n), (sw_rst_n), (rst_n);

comp_reset_k i_reset_k (wdt_rst_n, rst_n, rstout_n, s_wdi, soft_rst_n, sw_rst_n, rstin_n);

//defparam i_reset_k.i_reset.i_wdt.tp   = 200;    //140ms-280ms
//defparam i_reset_k.i_reset.i_wdt.td   = 1_600;  //1.6s
//defparam i_reset_k.i_reset.i_delay.td = 10_000; //10s OK
//defparam i_reset_k.i_reset.i_delay.td = 0;      //no delay OK
//defparam i_reset_k.i_reset.i_rst.tp   = 400;    //400ms(>i_reset.i_wdt.tp) OK
//defparam i_reset_k.i_reset.i_rst.tp   = 100;    //100ms(<=i_reset.i_wdt.tp) NG

assign s_wdi = wdi;
assign soft_rst_n = z_soft_rst_n;
assign sw_rst_n = z_sw_rst_n;

initial	// Test stimulus
  begin
    wdi = 1'bz;
    z_soft_rst_n = 1'bz;
    z_sw_rst_n = 1'bz;
    t_rstin = 1'b0;
    rstin_n = 1'b1;
    #100;

    @ (posedge rst_n);
    #100_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #500_000 z_soft_rst_n = 1'b0;

    @ (posedge rst_n);
    #100_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #500_000 z_sw_rst_n = 1'b0;
    #1_000_000 z_sw_rst_n = 1'bz;

    @ (posedge rst_n);
    #100_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #500_000 t_rstin = 1'b1;
    #100_000 t_rstin = 1'b0;
    #400_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #500_000 t_rstin = 1'b1;
    #100_000 t_rstin = 1'b0;
    #400_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;

    @ (posedge rst_n);
    #100_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;
    #1_000_000 wdi = 1'b1;
    #1_000_000 wdi = 1'b0;

    @ (posedge rst_n);
    #100_000 wdi = 1'b0;

  end

always @ (negedge rst_n)
begin
  wdi = 1'bz;
  z_soft_rst_n = 1'bz;
end

initial begin
  rstin_n = 1'b1;
  @ (posedge t_rstin)
  rstin_n = 1'b0;
  #2_000_000 rstin_n = 1'b1;

  @ (posedge t_rstin)
  rstin_n = 1'b0;
  #5_000_000 rstin_n = 1'b1;
end

//initial
//    $monitor($stime,, wdt_mr_n,, wdi,,, wdt_rst_n);

endmodule
