library ieee;
use ieee.std_logic_1164.ALL;

entity clock is
    port(
        period: in time;
        enable: in std_logic;
        output: out std_logic
    );
end clock;

architecture tick of clock is
    signal w_clock: std_logic := '0';
begin
    w_clock <= enable and not w_clock after period/2;
    output  <= w_clock;
    
end tick;
