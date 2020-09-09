library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity unitTest is
end unitTest;

architecture test of unitTest is
    
    constant period: time := 10ns;    
    constant number_cycle: integer := 20;

    component clock
        port(
            period: in time;
            number_cycle: in integer;
            output: out std_logic
        );
    end component;

    component counter
        port(
            clock: in std_logic;
            output: out natural range 0 to 255
        );
    end component;

    signal w_clock: std_logic := '0';
    signal w_out: natural range 0 to 255;

begin
    COUNTER1: counter port map(w_clock, w_out);
    CLOCK1: clock port map(period, number_cycle, w_clock);

end test;