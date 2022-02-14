
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module comp_rst (rst_n, mr_n, sence);
output rst_n;
input mr_n, sence;

reg clk;
integer cnt;
reg rst_n;
parameter tp = 300;     //300ms
parameter tp1 = 10*tp;

initial begin // Clock generator
  clk = 0;
  cnt = 0;
  rst_n = 1'b0;
  forever #50 clk = !clk;
end

always @ (posedge clk) begin // wdt counter
  if (mr_n == 1'b0)
    cnt <= 0;
  else if (sence == 1'b0)
    cnt <= 0;
  else if (cnt < tp1)
    cnt <= cnt + 1;
end

always @ (posedge clk) begin
  if (cnt < tp1)
    rst_n <= 1'b0;
  else
    rst_n <= 1'bz;
end

endmodule
