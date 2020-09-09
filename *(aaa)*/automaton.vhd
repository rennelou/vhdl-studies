library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity automaton is 
    port(
        s_reset: in std_logic;
        input: in std_logic_vector(0 to 255);
        s_accepted: out std_logic
    );
end automaton;

architecture recognize of automaton is
    type STATES is (q0, a0, a1, a2);
    signal state: STATES := q0;

begin
    transition: process(input)
        if input = 'a' then
            case state is
                when q0 => state <= a0;
                when a0 => state <= a1;
                when a1 => state <= a2;
            end case;
        end if;
    end process transition;
    
    s_accepted <= state = a2;
    
    reset: process(r_reset)
        if falling_edge(s_reset) then
            state <= q0;
        end if;
    end process reset;

end recognize;