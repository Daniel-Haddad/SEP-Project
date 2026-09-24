//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Thu Sep 24 18:45:26 2026
//Host        : VictusDaniel running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (btn0,
    clk,
    led_tick,
    pulso_0,
    sw,
    valor);
  input btn0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk;
  output led_tick;
  output pulso_0;
  input [2:0]sw;
  output [2:0]valor;

  wire btn_0_1;
  wire clk_0_1;
  wire clk_divider_0_tick;
  wire [2:0]coord_input_0_valor;
  wire debounce_0_pulso;
  wire [2:0]sw_0_1;

  assign btn_0_1 = btn0;
  assign clk_0_1 = clk;
  assign led_tick = clk_divider_0_tick;
  assign pulso_0 = debounce_0_pulso;
  assign sw_0_1 = sw[2:0];
  assign valor[2:0] = coord_input_0_valor;
  design_1_clk_divider_0_0 clk_divider_0
       (.clk(clk_0_1),
        .tick(clk_divider_0_tick));
  design_1_coord_input_0_0 coord_input_0
       (.clk(clk_0_1),
        .confirmar(debounce_0_pulso),
        .sw(sw_0_1),
        .valor(coord_input_0_valor));
  design_1_debounce_0_0 debounce_0
       (.btn(btn_0_1),
        .clk(clk_0_1),
        .pulso(debounce_0_pulso));
endmodule
