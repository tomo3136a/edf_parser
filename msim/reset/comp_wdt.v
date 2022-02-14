
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module comp_wdt (rst_n, mr_n, wdi);
output rst_n;
input mr_n, wdi;

reg clk;
reg wdi_z;
integer cnt;
reg rst_n = 1'b0;
parameter tp = 200;     //140ms-280ms
parameter td = 1600;    //1.6s
localparam tp1 = tp*10;
localparam td1 = td*10;

initial begin // Clock generator
  clk = 0;
  wdi_z = 0;
  cnt = 0;
  forever #50 clk = !clk;
end

always @ (posedge clk) begin // wdi latch
  if (wdi == 1'bz)
    wdi_z <= 1'bz;
  else
    wdi_z <= wdi;
end

always @ (posedge clk) begin // wdt counter
  if (mr_n == 1'b0)
    cnt <= 0;
  else if (cnt < tp1)
    cnt <= cnt + 1;
  else if (wdi === 1'bz)
    cnt <= tp1;
  else if (wdi != wdi_z)
    cnt <= tp1;
  else if (cnt >= (tp1+td1))
    cnt <= 0;
  else
    cnt <= cnt + 1;
end

always @ (posedge clk) begin
  if (cnt < tp1)
    rst_n <= 1'b0;
  else
    rst_n <= 1'b1;
end

endmodule
