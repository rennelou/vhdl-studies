-- Usa estilo 1
-- Saida assincronas

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity aaa_automaton is 
    port(
        clock: in std_logic;
        input: in character;
        s_accepted: out std_logic
    );
end aaa_automaton;

architecture recognize of aaa_automaton is
    type STATES is (q0, a0, a1, a2);
    signal state: STATES := q0;

begin
    
    transition: process(clock)
    begin

        if rising_edge(clock) then
            if input = 'a' then
                case state is
                    when q0 => state <= a0;
                    when a0 => state <= a1;
                    when a1 => state <= a2;
                    when a2 => state <= a2;
                end case;
            elsif input = '.' then
                state <= q0;
            end if;
        elsif falling_edge(clock) then
            if state = a2 then
                s_accepted <= '1';
            else
                s_accepted <= '0';
            end if;
        end if;
        
    end process transition;
end recognize;