
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module c_dcdc (pout, pg, pin, bias, en, offset_pout);
output pout, pg;
input pin, bias, en, offset_pout;

reg signed [15:0] pout;
wire pg;
wire signed [15:0] pin, pin_1, bias, offset_pout, vout_1;
wire pen_1, pen_2, pen_3;
reg s_clk;
integer s1_cnt;

parameter vout = 5_00;        //output value
parameter pin_min = 3_00;     //input minimum
parameter bias_min = pin_min; //bias minimum
parameter ton = 1_00;         //on delay [10us]
parameter tss = 1_00;         //soft start [10us]
parameter toff = ton;         //off delay [10us]
parameter scale = 16;         //scale
localparam vref = scale*vout; //scaled output value
parameter thr = vref/tss;     //through rate
localparam doff = vref/toff;  //power-off

localparam pout_ov = vout * 1.2;
localparam pg_ov = vout * 1.08;
localparam pg_uv = vout * 0.92;

assign pen_1 = en & (bias > bias_min);
assign #(ton) pen_2 = pen_1;
assign pen_3 = pen_1 & pen_2;
assign pin_1 = (pen_3) ? pin : 0;
assign vout_1 = vref + scale*offset_pout;

initial begin // Clock generator 10us
  s_clk = 0;
  forever #5 s_clk = !s_clk;
end

initial s1_cnt = 0;
always @ (posedge s_clk) begin  // sequencs counter
  if (pin_1 > 0)
    s1_cnt <= ((s1_cnt + thr) < vout_1) ? (s1_cnt + thr) : vout_1;
  else
    s1_cnt <= (s1_cnt > doff) ? (s1_cnt - doff) : 0;
end

initial pout = 0;
always @ (posedge s_clk) begin
  pout <= s1_cnt / scale;
end

assign pg = ((pg_uv < pout) && (pout < pg_ov)) ? 1'bz : 1'b0;

endmodule
