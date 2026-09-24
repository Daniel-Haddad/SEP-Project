library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_divider is
     generic (
        DIV : integer := 62_500_000 --generico para AO2, 1hz default
    );

    
    port(
    clk : in std_logic;  -- 125MHZ
    tick : out std_logic);
end clk_divider;

architecture Behavioral of clk_divider is

    signal tick_int : std_logic := '0';

begin

    process(clk)
        variable cuenta : integer range 0 to DIV := 0;
    begin
        if rising_edge(clk) then
            if cuenta = DIV - 1 then
                cuenta   := 0;
                tick_int <= not tick_int;
            else
                cuenta := cuenta + 1;
            end if;
        end if;
    end process;

    tick <= tick_int;

end Behavioral;