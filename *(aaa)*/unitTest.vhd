library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

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

        component automaton
            port(
                clock: in std_logic;
                s_reset: in std_logic;
                input: in character;
                s_accepted: out std_logic
            );
        end component;

        signal w_clock: std_logic := '0';
        signal s_reset: std_logic := '0';
        signal s_input: character;
        signal s_accepted: std_logic := '0';

    begin
        CLOCK1: clock port map(period, number_cycle, w_clock);
        A0: automaton port map(w_clock, s_reset, s_input, s_accepted);

        test: process
        begin    
            wait for period;
            s_input <= 'b';
            wait for period;
            s_input <= 'a';
            wait for period;
            s_input <= 'a';
            wait for period;
            s_input <= 'a';
            wait for period;
            s_input <= 'b';
            wait for period;
            
            s_reset <= '1';
            wait for 2*period;
            s_reset <= '0';

            wait;
        end process test;

        verify: process(w_clock)
        begin
            if falling_edge(W_clock) then
                write(output, "INPUT: " & character'image(s_input) &
                              "OUTPUT: " & std_logic'image(s_accepted) & CR & LF);
            end if;
        end process verify;
    end test;