
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module comp_delay (q, d);
output q;
input d;

reg clk;
integer cnt;
reg q;
parameter td = 3000;    //3sec
localparam td1 = td*10;

initial begin // Clock generator
  clk = 0;
  cnt = 0;
  q = 0;
  forever #50 clk = !clk;
end

always @ (posedge clk) begin
  if (d == 1'b1)
    cnt <= 0;
  else if (cnt < td1)
    cnt <= cnt + 1;
end

always @ (posedge clk) begin
  if (d == 1'b1)
    q <= 1'b1;
  else if (cnt >= td1)
    q <= d;
end

endmodule
