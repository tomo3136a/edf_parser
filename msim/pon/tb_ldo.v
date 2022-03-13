
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module tb_ldo;

reg signed [15:0] pin;
reg en;
wire signed [15:0] bias, pout;

c_ldo i_ldo (pout, pin, bias, en);

assign bias = pin;
initial	// Test stimulus
  begin
    pin = 0;
    en = 0;
    #10_000;
    pin = 0;
    en = 1'b1;
    #10_000;

    en = 1'b0;
    #10_000;

    en = 1'b1;
    #10_000;

    pin = 10_00;
    #10_000;

    pin = 3_00;
    #10_000;

    pin = 1_00;
    #10_000;

    pin = 0_00;
    #10_000;

  end

endmodule
