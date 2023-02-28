
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity gated_counter is
    Port ( clk : in STD_LOGIC;
           btnC : in std_logic;
           LED : out STD_LOGIC_VECTOR (15 downto 0));
end gated_counter;

architecture Behavioral of gated_counter is
    signal counter_d, counter_q, counter_bounce_d, counter_bounce_q: unsigned (15 downto 0);  
    signal bstore_d, bstore_q, test : std_logic ; 
begin
    
    process(clk, counter_d, counter_bounce_d)
    begin
        if (clk'event and clk = '1') then
        counter_q <= counter_d;
        counter_bounce_q <= counter_bounce_d;
        bstore_q <= bstore_d;
      end if;
    end process;
    
    bstore_d <= btnC;
    
    test <= '1' when bstore_q = '0' and btnC = '1' else '0';
    
    counter_d <= counter_q + 1 when  test = '1' and counter_bounce_q = 0 else
                 counter_q;
    
    counter_bounce_d <= counter_bounce_q + 1 when bstore_q = '1' or not(counter_bounce_q = 0) else
                      counter_bounce_q;
    
    LED <= std_logic_vector(counter_q);
    
end Behavioral;