
// (C) 2022 tomo3136a
//
// All Rights Reserved.
//
//   

`timescale 1us / 1us
module m_top(
    p32, p14r5, p12, p8a, 
    p5r5, p3r8, p3r3, 
    p1r2, p1r8, p2r5, 
    p3r3d, p1r8d, p3r3a, 
    pin, psw_n, en_p14r5);

output p32, p14r5, p12, p8a;
output p5r5, p3r8, p3r3;
output p1r2, p1r8, p2r5;
output p3r3d, p1r8d, p3r3a;
input pin, psw_n, en_p14r5;

wire signed [15:0] p32, p14r5, p12, p8a;
wire signed [15:0] p5r5, p3r8, p3r3;
wire signed [15:0] p1r2, p1r8, p2r5;
wire signed [15:0] p3r3d, p1r8d, p3r3a;
wire signed [15:0] pin, pin_1;

wire shdn_n, poff_trg, shdn_in, psw_n, poff_n;
wire uv_n, flt_plim_n, en_plim;
wire pg_p14r5, pg_p12, pg_p5r5, pg_p3r8, pg_p3r3;
wire pg_p1r2, pg_p1r8, pg_p2r5, pg_core;
wire ov, ov_p14r5, ov_p12, ov_p5r5, ov_p3r8, ov_p3r3;
wire en_p14r5;

pullup (shdn_n), (poff_trg), (psw_n), (poff_n);
pullup (uv_n), (flt_plim_n), (en_plim);
pullup (pg_p14r5), (pg_p12), (pg_p5r5), (pg_p3r8), (pg_p3r3);
pullup (pg_p1r2), (pg_p1r8), (pg_p2r5);
pulldown (ov_p14r5), (ov_p12), (ov_p5r5), (ov_p3r8), (ov_p3r3);

//power in
assign shdn_in = 1'b0;
assign ov = ov_p14r5 | ov_p12 | ov_p5r5 | ov_p3r8 | ov_p3r3;
m_poff i_poff (
    shdn_n, poff_trg, 
    shdn_in, psw_n, poff_n, ov, uv_n);

//power limmit
c_plim i_plim (
    pin_1, uv_n, flt_plim_n, en_plim, 
    pin, pin, shdn_n);
defparam i_plim.ver = 2;        //version
defparam i_plim.pin_min = 3_00; //input-minimum 3.0
defparam i_plim.pin_uv = 17_50; //input-under 17.5
defparam i_plim.pin_ov = 40_00; //input-over 40.0
defparam i_plim.t_wrn = 2_00;   //warning timer 2ms
defparam i_plim.t_flt = 2_00;   //fault timer 2ms
defparam i_plim.t_dwn = 50_00;  //down timer 50ms
defparam i_plim.tsd = 2_00;     //input-enable-delay 1ms
defparam i_plim.thr = 1_00;     //input-throuthrate 10mV/10us

//dcdc
assign p32 = pin_1;

//dcdc(1)
//assign en_p14r5 = 1'b1;
c_dcdc i_dcdc_p14r5 (
    p14r5, pg_p14r5, 
    pin_1, p12, en_p14r5, 16'b0);
defparam i_dcdc_p14r5.vout = 14_50;     //output value 14.5
defparam i_dcdc_p14r5.pin_min = 3_00;   //input minimum 3.0
defparam i_dcdc_p14r5.ton = 10;         //on delay 0.1ms
defparam i_dcdc_p14r5.tss = 80;         //soft start 0.8ms
assign ov_p14r5 = (p14r5 > 18_00) ? 1'b1 : 1'bz;

c_dcdc i_dcdc_p12 (p12, pg_p12, pin_1, pin_1, 1'b1, 16'b0);
defparam i_dcdc_p12.vout = 12_00;   //output value 12.0
defparam i_dcdc_p12.pin_min = 3_00; //input minimum 3.0
defparam i_dcdc_p12.ton = 10;       //on delay 0.1ms
defparam i_dcdc_p12.tss = 4_40;     //soft start 4.4ms
assign ov_p12 = (p12 > 13_00) ? 1'b1 : 1'bz;

c_dcdc i_dcdc_p5r5 (p5r5, pg_p5r5, pin_1, pin_1, 1'b1, 16'b0);
defparam i_dcdc_p5r5.vout = 5_50;   //output value 5.5
defparam i_dcdc_p5r5.pin_min = 3_00;//input minimum 3.0
defparam i_dcdc_p5r5.ton = 10;      //on delay 0.1ms
defparam i_dcdc_p5r5.tss = 4_40;    //soft start 4.4ms
assign ov_p5r5 = (p5r5 > 6_30) ? 1'b1 : 1'bz;

c_dcdc i_dcdc_p3r8 (p3r8, pg_p3r8, pin_1, pin_1, 1'b1, 16'b0);
defparam i_dcdc_p3r8.vout = 3_80;   //output value 3.8
defparam i_dcdc_p3r8.pin_min = 3_00;//input minimum 3.0
defparam i_dcdc_p3r8.ton = 10;      //on delay 0.1ms
defparam i_dcdc_p3r8.tss = 4_40;    //soft start 4.4ms
assign ov_p3r8 = (p3r8 > 4_70) ? 1'b1 : 1'bz;

c_dcdc i_dcdc_p3r3 (p3r3, pg_p3r3, pin_1, pin_1, 1'b1, 16'b0);
defparam i_dcdc_p3r3.vout = 3_30;   //output value 3.3
defparam i_dcdc_p3r3.pin_min = 3_00;//input minimum 3.0
defparam i_dcdc_p3r3.ton = 10;      //on delay 0.1ms
defparam i_dcdc_p3r3.tss = 4_40;    //soft start 4.4ms
assign ov_p3r3 = (p3r3 > 3_60) ? 1'b1 : 1'bz;

//ldo
c_ldo i_ldo_p8a (p8a, p12, p12, (p3r3 > 1_00));
defparam i_ldo_p8a.vout = 8_00;     //output value 8
defparam i_ldo_p8a.pin_min = 1_00;  //input minimum 1
defparam i_ldo_p8a.tss = 1;         //soft start 10us

//dcdc(2)
c_dcdc i_dcdc_p1r2 (p1r2, pg_p1r2, p3r3, p3r3, pg_p5r5, 16'b0);
defparam i_dcdc_p1r2.vout = 1_20;   //output value 1.2
defparam i_dcdc_p1r2.pin_min = 3_00;//input minimum 3.0
defparam i_dcdc_p1r2.ton = 10;      //on delay 0.1ms
defparam i_dcdc_p1r2.tss = 4_44;    //soft start 4.44ms

c_dcdc i_dcdc_p1r8 (p1r8, pg_p1r8, p3r3, p5r5, pg_p1r2, 16'b0);
defparam i_dcdc_p1r8.vout = 1_80;   //output value 1.8
defparam i_dcdc_p1r8.pin_min = 3_00;//input minimum 3.0
defparam i_dcdc_p1r8.ton = 10;      //on delay 0.1ms
defparam i_dcdc_p1r8.tss = 4_44;    //soft start 4.44ms

c_dcdc i_dcdc_p2r5 (p2r5, pg_p2r5, p3r3, p5r5, pg_p1r2, 16'b0);
defparam i_dcdc_p2r5.vout = 2_50;   //output value 2.5
defparam i_dcdc_p2r5.pin_min = 3_00;//input minimum 3.0
defparam i_dcdc_p2r5.ton = 10;      //on delay 0.1ms
defparam i_dcdc_p2r5.tss = 4_40;    //soft start 4.4ms

//ldo/psw
assign pg_core = pg_p1r8 | pg_p2r5;
c_psw i_psw_p3r3d (p3r3d, p3r3, p5r5, pg_core);
defparam i_psw_p3r3d.pin_min = 1_00;//input minimum 1.0
defparam i_psw_p3r3d.ton = 1;       //on delay 10us
defparam i_psw_p3r3d.tss = 1_37;    //soft start 1.37ms

c_psw i_psw_p1r8d (p1r8d, p3r3, p5r5, pg_core);
defparam i_psw_p1r8d.pin_min = 1_00;//input minimum 1.0
defparam i_psw_p1r8d.ton = 1;       //on delay 10us
defparam i_psw_p1r8d.tss = 1_57;    //soft start 1.57ms

c_ldo i_ldo_p3r3a (p3r3a, p3r8, p5r5, pg_core);
defparam i_ldo_p3r3a.vout = 3_30;   //output value 3.3
defparam i_ldo_p3r3a.pin_min = 1_00;//input minimum 1.0
defparam i_ldo_p3r3a.ton = 1;       //on delay 10us
defparam i_ldo_p3r3a.tss = 1_00;    //soft start 1ms

endmodule
