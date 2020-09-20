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
    tick: process(clock, s_reset)
    begin
        if falling_edge(s_reset) then
            actual_state <= q0;
        elsif rising_edge(clock) then
            actual_state <= next_state;
        end if;
    end process tick;

    transition: process(actual_state, input)
    begin
        next_state <= actual_state;
        if (input = 'a') then
            case actual_state is
                when q0 => next_state <= a0;
                when a0 => next_state <= a1;
                when a1 => next_state <= a2;
                when a2 => next_state <= a2;
            end case;
        end if;
    end process transition;
    
    s_accepted <= '1' when actual_state = a2 else '0';

end recognize;