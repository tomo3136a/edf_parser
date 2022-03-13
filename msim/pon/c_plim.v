
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module c_plim (pout, uv_n, flt_n, en, pin, bias, shdn_n);
output pout, uv_n, flt_n, en;
input pin, bias, shdn_n;

reg signed [15:0] pout;
reg uv_n, flt_n, en;
wire signed [15:0] pin, pin_1, pin_2, pin_3, bias;
wire pen_1, pen_2, pen_3, flt_ov, shdn_n;
reg s_clk;
integer s1_cnt, pin_max;

parameter ver = 2;            //version (1 or 2)
parameter pin_min = 3_00;     //input-minimum 3.0
parameter pin_uv = 10_00;     //input-under 10.0
parameter pin_ov = 40_00;     //input-over 40.0
parameter bias_min = pin_min; //bias-minimum
parameter t_wrn = 2_00;       //warning timer 2ms
parameter t_flt = 2_00;       //fault timer 2ms
parameter t_dwn = 50_00;      //cool down timer 50ms
parameter tsd = 1_00;         //start-delay 1ms
parameter tss = 1_00;         //soft-start 10mV/10us
parameter thr = 100_00/tss;   //throughrate 1V/10us

localparam t_off = t_wrn + t_flt;  //power-off timer
localparam t_rel = t_off + t_dwn;  //release timer
localparam t_clr = t_rel + t_wrn;  //clear timer

assign pen_1 = shdn_n & (bias > bias_min);
assign #(tsd) pen_2 = pen_1;
assign pen_3 = pen_1 & pen_2;
assign pin_1 = (pen_3) ? pin : 0;

assign flt_ov = (pin_1 > pin_ov);
assign pin_2 = (pin_1 < pin_max) ? pin_1 : pin_max;
assign pin_3 = (flt_ov) ? pin_ov : pin_2;

initial begin // Clock generator
  s_clk = 0;
  forever #5 s_clk = !s_clk;
end

initial s1_cnt = 0;
always @ (posedge s_clk) begin  // sequence counter
  if (s1_cnt < t_wrn)
    s1_cnt <= (flt_ov) ? (s1_cnt + 1'b1) : 0;
  else if (s1_cnt < t_off)
    s1_cnt <= s1_cnt + 1'b1;
  else if (s1_cnt < t_rel)
    s1_cnt <= s1_cnt + 1'b1;
  else if (s1_cnt < t_clr)
    s1_cnt <= (flt_ov) ? (s1_cnt + 1'b1) : 0;
  else
    s1_cnt <= t_off;
end

initial uv_n = 0;
always @ (posedge s_clk) begin
  if ((ver == 1) && (pen_1 === 0))
    uv_n <= 0;
  else
    uv_n <= (pin > pin_uv) ? 1'bz : 1'b0;
end

initial flt_n = 0;
always @ (posedge s_clk) begin
  flt_n <= (s1_cnt < t_wrn) ? 1'bz : 1'b0;
end

initial en = 0;
always @ (posedge s_clk) begin
  if (pout < 50)
    en <= 1'b0;
  else if ((en !== 1'b0) || (pout > 200))
    if (pout > pin - 70)
      en <= 1'bz;
end

initial pin_max = 0;
always @ (posedge s_clk) begin
  if (pen_3)
    pin_max <= (pin_max < 100_00) ? (pin_max + thr) : pin_max;
  else
    pin_max <= (pin_max > thr) ? (pin_max - thr) : 0;
end

initial pout = 0;
always @ (posedge s_clk) begin
  pout <= (pin_3 < pin_max) ? pin_3 : pin_max;
  if ((t_off < s1_cnt) && (s1_cnt < t_rel))
    pout <= 0;
end

endmodule
