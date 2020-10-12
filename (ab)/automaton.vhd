library ieee;
use ieee.std_logic_1164.all;

entity automaton is 
    port (
        clock: in std_logic;
        in_alphabet: in character;
        s_accepted: out std_logic
    );
end automaton;

architecture recognize of automaton is
    type STATES is (q0, a_state, b_state, rejected);
    signal state: STATES := q0;
begin
    transition: process(clock)
    begin
        if clock'event and clock = '1' then
            if in_alphabet = '.' then
                state <= q0;
            elsif in_alphabet = 'a' then
                case state is
                    when q0 => state <= a_state;
                    when others => state <= rejected;
                end case;
            elsif in_alphabet = 'b' then
                case state is
                    when a_state => state <= b_state;
                    when others => state <= rejected;
                end case;
            end if;
        end if;

        if clock'event and clock = '0' then
            if state = b_state then
                s_accepted <= '1';
            else 
                s_accepted <= '0';
            end if;
        end if;
    end process transition;
end recognize;