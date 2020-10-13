library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity unitTest is
end unitTest;
    
architecture test of unitTest is
    
    constant period: time := 10ns;    
    component clock
        port(
            period: in time;
            enable: in std_logic;
            output: out std_logic
        );
    end component;
    component ab_automaton
        port(
            clock: in std_logic;
            in_alphabet: in character;
            s_accepted: out std_logic
        );
    end component;
    signal w_clock: std_logic := '0';
    signal w_enable: std_logic := '1';
    signal in_alphabet: character;
    signal s_accepted: std_logic := '0';

    file input_buf: text;

begin
    CLOCK1: clock port map(period, w_enable, w_clock);
    A0: ab_automaton port map(w_clock, in_alphabet, s_accepted);
    
    test: process
        variable rdline: line;
        variable wrline: line;

        variable v_input: character;
    begin
        file_open(input_buf, "input.txt", read_mode);

        while not endfile(input_buf) loop
            readline(input_buf, rdline);

            write(wrline, string'("Input: "));

            for j in 1 to rdline'length loop
                wait until falling_edge(W_clock);
                
                in_alphabet <= rdline(j);
                wait until rising_edge(W_clock);
                
                write(wrline, in_alphabet);
            end loop;

            write(wrline, string'(" Output: "));
            write(wrline, s_accepted);

            writeline(output, wrline);
        end loop;
        
        w_enable <= '0';
        file_close(input_buf);
        wait;
    end process test;
end test;