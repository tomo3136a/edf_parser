
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module tb_dcdc;

reg signed [15:0] pin, offset_pout;
reg en;
wire signed [15:0] bias, pout;
wire pg, ov;

c_dcdc i_dcdc (pout, pg, ov, pin, bias, en, offset_pout);

assign bias = pin;
initial	// Test stimulus
  begin
    pin = 0;
    en = 0;
    offset_pout = 0;
    #10_0;
    pin = 0;
    #10_0;
    en = 1'b1;

    pin = 32_00;
    #1000_0;
    pin = 32_00;
    #10_0;

    pin = 0_00;
    #1000_0;
    pin = 0_00;
    #10_0;

    pin = 32_00;
    #1000_0;
    pin = 32_00;
    #10_0;

    pin = 24_00;
    #1000_0;
    pin = 24_00;
    #10_0;

    pin = 16_00;
    #1000_0;
    pin = 16_00;
    #10_0;

    pin = 8_00;
    #1000_0;
    pin = 8_00;
    #10_0;

    pin = 4_00;
    #1000_0;
    pin = 4_00;
    #10_0;

    pin = 2_00;
    #1000_0;
    pin = 2_00;
    #10_0;

    pin = 1_00;
    #1000_0;
    pin = 1_00;
    #10_0;

    pin = 32_00;
    #1000_0;

    offset_pout = 0_00;
    #10_0;
    offset_pout = 1_00;
    #1000_0;
    offset_pout = 1_00;
    #10_0;
    offset_pout = 2_00;
    #1000_0;
    offset_pout = 2_00;
    #10_0;
    offset_pout = 1_00;
    #1000_0;
    offset_pout = 1_00;
    #10_0;
    offset_pout = 0_00;
    #1000_0;
    offset_pout = 0_00;
    #10_0;
    offset_pout = -1_00;
    #1000_0;
    offset_pout = -1_00;
    #10_0;
    offset_pout = -2_00;
    #1000_0;
    offset_pout = -2_00;
    #10_0;
    offset_pout = -1_00;
    #1000_0;
    offset_pout = -1_00;
    #10_0;
    offset_pout = 0_00;
    #1000_0;
    offset_pout = 0_00;
    #10_0;

  end

endmodule
