----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:01:33 03/16/2025 
-- Design Name: 
-- Module Name:    mux_add4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity muxx is
    Port ( pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_sel : in  STD_LOGIC;
           pc_signal : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_to_pc : out  STD_LOGIC_VECTOR (31 downto 0));
end muxx;

architecture Behavioral of muxx is
signal mux_out : STD_LOGIC_VECTOR (31 downto 0);
begin
--process(pc_sel,pc_immed,pc_signal)
--begin
----wait until 	pc_sel'event or pc_immed'event or pc_signal'event;
----case (pc_sel) is 
----	when  '0' =>
----		mux_out <= pc_signal;
----	when others =>
----		mux_out <= pc_immed;
----END CASE;
--END PROCESS;
--mux_to_pc<=mux_out;
mux_to_pc <= pc_immed WHEN pc_sel='1' ELSE pc_signal;
end Behavioral;

