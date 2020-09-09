library ieee;
use ieee.std_logic_1164.ALL;

entity clock is
    port(
        period: in time;
        number_cycle: in integer;
        output: out std_logic
    );
end clock;

architecture tick of clock is
    signal enable: std_logic := '1';
    signal w_clock: std_logic := '0';
begin
    reset: process
    begin
        enable <= '1';
        wait for number_cycle * period;
        enable <= '0';
        wait;
    end process reset;

    w_clock <= enable and not w_clock after period/2;
    output  <= w_clock;
    
end tick;
