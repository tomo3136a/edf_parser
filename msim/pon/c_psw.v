
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
// module c_psw
//  pout  power-outport   [0.01V]
//  pin   power-input     [0.01V]
//  bias  bias-input      [0.01V]
//  en    enable control(1:enable, 0:disable)
//
// parameter:
//  pin_min power-in minimum voltage  [0.01V]
//  ton     power-on delay time       [10ms]
//  tss     power-on soft-start time  [10ms]
//  toff    power-off time            [10ms]

`timescale 1us / 1us
module c_psw (pout, pin, bias, en);
output pout;
input pin, bias, en;

reg signed [15:0] pout;
wire signed [15:0] pin, pin_1, bias, vout_1, vref, thr, doff;
wire pen_1, pen_2, pen_3;
reg s_clk;
integer s1_cnt;

parameter pin_min = 1_00;     //input minimum
parameter bias_min = pin_min; //bias minimum
parameter ton = 1_00;         //on delay
parameter tss = 1_00;         //soft-start
parameter toff = ton;         //off-delay
parameter scale = 16;         //scale

assign pen_1 = en & (bias > bias_min);
assign #(ton) pen_2 = pen_1;
assign pen_3 = pen_1 & pen_2;
assign pin_1 = (pen_3) ? pin : 0;

assign vref = scale*pin_1;    //scaled output value
assign thr = vref/tss;        //through rate
assign doff = vref/toff;      //power-off
assign vout_1 = vref;

initial begin // Clock generator 10us
  s_clk = 0;
  forever #5 s_clk = !s_clk;
end

initial s1_cnt = 0;
always @ (posedge s_clk) begin  // inner counter
  if (pin_1 > 0)
    s1_cnt <= ((s1_cnt + thr) < vout_1) ? (s1_cnt + thr) : vout_1;
  else
    s1_cnt <= (s1_cnt > doff) ? (s1_cnt - doff) : 0;
end

initial pout = 0;
always @ (posedge s_clk) begin
  pout <= (s1_cnt < scale*pin_1) ? (s1_cnt/scale) : pin_1;
end

endmodule
