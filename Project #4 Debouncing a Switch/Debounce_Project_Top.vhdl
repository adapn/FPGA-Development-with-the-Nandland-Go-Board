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

 --We’ll start with the top
--level module, which instantiates and links together two lower-level modules,
--one for debouncing the switch and the other for toggling the LED

entity Debounce_Project_Top is
    port (
        i_Clk   : in std_logic; -- D FF CLK
        i_Switch_1 : in std_logic;
        o_LED_1 : out std_logic
    );
end Debounce_Project_Top;

architecture rtl of Debounce_Project_Top is
    --Declare signal of the debounce input to be carreid into the filter 
    signal w_Debounced_Switch : STD_LOGIC; 
begin
   
    Debounce_Inst : entity work.Debounce_Filter
    generic map (
        DEBOUNCE_LIMIT => 250000) --Set the Debounce_limt to 250,000 clock cycles whch is 10ms.We got this by doing 10ms = Clock_Cycles * 40ns (40ns is the period we set)

    port map (
        i_Clk => i_Clk,
        i_Bouncy => i_Switch_1,
        o_Debounced => w_Debounced_Switch
    );
    
    LED_Toggle_Inst : entity work.LED_Toggle_Project
    port map (
        i_Clk => i_Clk,
        o_LED_1    => o_LED_1,
        i_Switch_1 => w_Debounced_Switch
    );


    

end rtl;