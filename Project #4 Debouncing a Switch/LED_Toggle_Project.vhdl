library ieee; 
use ieee.std_logic_1164.all;


 --  ## Push-Button Switches
   -- set_io i_Switch_1 53
  --  set_io i_Switch_2 51
  --  set_io i_Switch_3 54
  --  set_io i_Switch_4 52


--LED Pins:
--set_io o_LED_1 56
--set_io o_LED_2 57
--set_io o_LED_3 59
--set_io o_LED_4 60

--CLOCK 
--set_io i_Clk 15

 --tOP LEVEL MODULE WHICH INST THE DEBOUNCE FILTER AND PREV LED BLINKER
entity LED_Toggle_Project is 
  port ( 
     i_Clk      : in  std_logic; 
     i_Switch_1 : in  std_logic; 
     o_LED_1    : out std_logic 
  ); 
end entity LED_Toggle_Project; 
architecture RTL of LED_Toggle_Project is 
  signal r_LED_1    : std_logic := '0'; 
  signal r_Switch_1 : std_logic := '0'; 
begin 
 process (i_Clk) is 
  begin 
     if rising_edge(i_Clk) then 
      r_Switch_1 <= i_Switch_1; 
      if i_Switch_1 = '0' and r_Switch_1 = '1' then 
         r_LED_1 <= not r_LED_1; 
        end if; 
     end if; 
  end process; 
  o_LED_1 <= r_LED_1; 
end architecture RTL;