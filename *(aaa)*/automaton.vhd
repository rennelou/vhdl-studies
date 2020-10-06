-- Usa estilo 1
-- Saida assincronas

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity automaton is 
    port(
        clock: in std_logic;
        s_reset: in std_logic;
        input: in character;
        s_accepted: out std_logic
    );
end automaton;

architecture recognize of automaton is
    type STATES is (q0, a0, a1, a2);
    signal actual_state, next_state: STATES := q0;

begin
    
    transition: process(s_reset, clock)
    begin

        if falling_edge(clock) then
            actual_state <= next_state;

            if next_state = a2 then
                s_accepted <= '1';
            else
                s_accepted <= '0';
            end if;
        elsif rising_edge(clock) then
            next_state <= actual_state;
            
            if input = 'a' then
                case actual_state is
                    when q0 => next_state <= a0;
                    when a0 => next_state <= a1;
                    when a1 => next_state <= a2;
                    when a2 => next_state <= a2;
                end case;
            end if;
        end if;
        
        if s_reset'event and s_reset = '0' then
            next_state <= q0;
        end if;
        
    end process transition;
end recognize;