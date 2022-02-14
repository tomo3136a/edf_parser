
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1ns / 1ns
module comp_dff (q, q_n, clk, clr_n, pre_n, d);
output q, q_n;
input clk, pre_n, clr_n, d;

reg q = 0;

assign q_n = ~q;

always @ (posedge clk or negedge clr_n or negedge pre_n) begin
  if (clr_n == 1'b0)
    q <= 1'b0;
  else if (pre_n == 1'b0)
    q <= 1'b1;
  else
    q <= d;
end

endmodule
