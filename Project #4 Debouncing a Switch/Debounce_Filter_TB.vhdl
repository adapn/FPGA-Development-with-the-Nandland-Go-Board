library ieee; 
use ieee.std_logic_1164.all;
use std.env.finish; 


entity Debounce_Filter_TB is
end Debounce_Filter_TB;

architecture test of Debounce_Filter_TB is
  signal r_Clk, r_bouncy, w_Debounced : STD_LOGIC := '0';
begin
r_clk <= not r_Clk after 2 ns; --we repeatedly invert a signal after a fixed amount of
--time to generate a 50 percent duty cycle signal that will toggle for the
--duration of the testbench execution. The signal inverts every 2 ns, for a clock
--period of 4 ns per cycle.

UUT : entity work.Debounce_Filter
 generic map(
    DEBOUNCE_LIMIT => 4 --This means our debounce filter will only look for four clock cycles
    --of stability before it deems the output debounced. In a real FPGA, this would
    --be a very short amount of time (less than 1 microsecond), probably not long
    --enough to actually fix the problem. However, keep in mind the purpose of
    --this testbench: we want to make sure that our FPGA logic works as intended.
    --That logic is functionally the same whether we’re waiting 4 clock cycles or
    --250,000 clock cycles.
)
 port map(
    i_Clk => r_Clk,
    i_Bouncy => r_bouncy,
    o_Debounced => w_Debounced
);
  process is 
  begin 
    wait for 10 ns;
    r_bouncy <= '1';  -- toggle state of input pin
    wait until rising_edge(r_Clk); 
    r_bouncy <= '0';  -- simulate a glitch/bounce of switch
    wait until rising_edge(r_Clk); 
    r_Bouncy <= '1';  -- bounce goes away
    wait for 24 ns;
    finish;
  end process;
end test;