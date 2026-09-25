--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Fri Sep 25 11:54:35 2026
--Host        : LucasM_laptop running 64-bit major release  (build 9200)
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    btn0 : in STD_LOGIC;
    clk : in STD_LOGIC;
    led_tick : out STD_LOGIC;
    rgb_b : out STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 );
    valor : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_clk_divider_0_0 is
  port (
    clk : in STD_LOGIC;
    tick : out STD_LOGIC
  );
  end component design_1_clk_divider_0_0;
  component design_1_debounce_0_0 is
  port (
    clk : in STD_LOGIC;
    btn : in STD_LOGIC;
    pulso : out STD_LOGIC
  );
  end component design_1_debounce_0_0;
  component design_1_coord_input_0_0 is
  port (
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 );
    confirmar : in STD_LOGIC;
    valor : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component design_1_coord_input_0_0;
  component design_1_clk_divider_1_0 is
  port (
    clk : in STD_LOGIC;
    tick : out STD_LOGIC
  );
  end component design_1_clk_divider_1_0;
  component design_1_vio_0_0 is
  port (
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_vio_0_0;
  component design_1_ila_0_0 is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe1 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_ila_0_0;
  signal btn_0_1 : STD_LOGIC;
  signal clk_0_1 : STD_LOGIC;
  signal clk_divider_0_tick : STD_LOGIC;
  signal clk_divider_1_tick : STD_LOGIC;
  signal coord_input_0_valor : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal debounce_0_pulso : STD_LOGIC;
  signal sw_0_1 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_vio_0_probe_out0_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
begin
  btn_0_1 <= btn0;
  clk_0_1 <= clk;
  led_tick <= clk_divider_0_tick;
  rgb_b <= clk_divider_1_tick;
  sw_0_1(2 downto 0) <= sw(2 downto 0);
  valor(2 downto 0) <= coord_input_0_valor(2 downto 0);
clk_divider_0: component design_1_clk_divider_0_0
     port map (
      clk => clk_0_1,
      tick => clk_divider_0_tick
    );
clk_divider_1: component design_1_clk_divider_1_0
     port map (
      clk => clk_0_1,
      tick => clk_divider_1_tick
    );
coord_input_0: component design_1_coord_input_0_0
     port map (
      clk => clk_0_1,
      confirmar => debounce_0_pulso,
      sw(2 downto 0) => sw_0_1(2 downto 0),
      valor(2 downto 0) => coord_input_0_valor(2 downto 0)
    );
debounce_0: component design_1_debounce_0_0
     port map (
      btn => btn_0_1,
      clk => clk_0_1,
      pulso => debounce_0_pulso
    );
ila_0: component design_1_ila_0_0
     port map (
      clk => clk_0_1,
      probe0(0) => debounce_0_pulso,
      probe1(2 downto 0) => sw_0_1(2 downto 0),
      probe2(2 downto 0) => coord_input_0_valor(2 downto 0),
      probe3(0) => clk_divider_0_tick
    );
vio_0: component design_1_vio_0_0
     port map (
      clk => clk_0_1,
      probe_in0(2 downto 0) => coord_input_0_valor(2 downto 0),
      probe_in1(0) => debounce_0_pulso,
      probe_out0(0) => NLW_vio_0_probe_out0_UNCONNECTED(0)
    );
end STRUCTURE;
