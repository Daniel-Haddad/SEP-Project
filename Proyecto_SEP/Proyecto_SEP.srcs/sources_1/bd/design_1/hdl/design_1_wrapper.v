//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Thu Sep 24 18:45:26 2026
//Host        : VictusDaniel running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (btn0,
    clk,
    led_tick,
    pulso_0,
    sw,
    valor);
  input btn0;
  input clk;
  output led_tick;
  output pulso_0;
  input [2:0]sw;
  output [2:0]valor;

  wire btn0;
  wire clk;
  wire led_tick;
  wire pulso_0;
  wire [2:0]sw;
  wire [2:0]valor;

  design_1 design_1_i
       (.btn0(btn0),
        .clk(clk),
        .led_tick(led_tick),
        .pulso_0(pulso_0),
        .sw(sw),
        .valor(valor));
endmodule
