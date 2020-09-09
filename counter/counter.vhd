library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity counter is
    port(
        clock: in std_logic;
        output: out natural range 0 to 255
    );
end counter;

architecture increment of counter is
begin
    tick_clock: process(clock)
        variable i: natural range 0 to 255 := 0;
    begin
        if falling_edge(clock) then
            i := i + 1;
        end if;

        output <= i;
    end process tick_clock;
end increment;