--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Thu Sep 24 23:15:22 2026
--Host        : LucasM_laptop running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    btn0 : in STD_LOGIC;
    clk : in STD_LOGIC;
    led_tick : out STD_LOGIC;
    rgb_b : out STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 );
    valor : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    clk : in STD_LOGIC;
    led_tick : out STD_LOGIC;
    btn0 : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 );
    valor : out STD_LOGIC_VECTOR ( 2 downto 0 );
    rgb_b : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      btn0 => btn0,
      clk => clk,
      led_tick => led_tick,
      rgb_b => rgb_b,
      sw(2 downto 0) => sw(2 downto 0),
      valor(2 downto 0) => valor(2 downto 0)
    );
end STRUCTURE;
