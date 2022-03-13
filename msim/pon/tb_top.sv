
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module tb_top;

reg signed [15:0] pin;
reg psw_n, en_p14r5;

wire signed [15:0] p42, p14r5, p12, p8a;
wire signed [15:0] p5r5, p3r8, p3r3;
wire signed [15:0] p1r2, p1r8, p2r5;
wire signed [15:0] p3r3d, p1r8d, p3r3a;

task rise(
  input signed [15:0] pe,
  input [15:0] tw);
integer i;
reg signed [15:0] ps;
begin
  ps = pin;
  if (ps < pe)
    for (i=0;i<=tw;i=i+1) #1 pin <= ps + ((pe - ps) * i) / tw;
  else
    for (i=tw;i>=0;i=i-1) #1 pin <= pe + ((ps - pe) * i) / tw;
end
endtask

m_top i_top (
  p42, p14r5, p12, p8a, p5r5, p3r8, p3r3, 
  p1r2, p1r8, p2r5, p3r3d, p1r8d, p3r3a, 
  pin, psw_n, en_p14r5);

m_cpu i_cpu (p3r3d);

assign bias = pin;
initial	// Test stimulus
  begin
    pin = 0;
    psw_n = 1'b0;
    en_p14r5 = 1'b0;
    #40_000;

    rise(32_00, 10_00);
    #40_000;
    en_p14r5 = 1'b1;
    #40_000;

    rise(0, 10_00);
    #40_000;

    rise(32_00, 10_00);
    #40_000;

    rise(42_00, 10_00);
    #40_000;
    #40_000;

    rise(32_00, 10_00);
    #40_000;

    rise(0, 10_00);
    #40_000;

    rise(32_00, 10_00);
    #40_000;

    rise(10_00, 10_00);
    #40_000;

    rise(32_00, 10_00);
    #40_000;

    psw_n = 1'b1;
    #40_000;

    psw_n = 1'b0;
    #40_000;

  end

endmodule
