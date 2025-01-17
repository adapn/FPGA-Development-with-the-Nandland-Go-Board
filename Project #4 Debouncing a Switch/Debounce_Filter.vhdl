library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

-- Entity Declaration
entity Debounce_Filter is
    generic (
        DEBOUNCE_LIMIT : integer := 20 -- Number of clock cycles to wait for stability
    );
    port (
        i_Clk       : in  std_logic;  -- Clock signal
        i_Bouncy    : in  std_logic;  -- Input signal with potential bouncing
        o_Debounced : out std_logic   -- Stable, debounced output signal
    );
end entity Debounce_Filter;

architecture RTL of Debounce_Filter is
    -- Internal signals
    signal r_Count : integer range 0 to DEBOUNCE_LIMIT := 0; -- ❶ Counter to track clock cycles of stability
    signal r_State : std_logic := '0'; -- Last stable state of the input
begin
    -- Process block for debouncing
    process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            -- ❷ Check if the input is different from the last stable state 
            -- and the counter hasn't reached the debounce limit
            if (i_Bouncy /= r_State and r_Count < DEBOUNCE_LIMIT - 1) then
                r_Count <= r_Count + 1; -- Increment counter to count stability duration

            -- ❸ If the counter has reached the debounce limit, the input is stable
            elsif r_Count = DEBOUNCE_LIMIT - 1 then
                r_State <= i_Bouncy; -- Update the stable state to the current input
                r_Count <= 0;        -- Reset the counter for the next event

            -- ❹ If input matches the last stable state, reset the counter
            else
                r_Count <= 0; -- Reset counter, as no debouncing is needed
            end if;
        end if;
    end process;

    -- ❺ Output the stable debounced signal
    o_Debounced <= r_State;

end architecture RTL;
