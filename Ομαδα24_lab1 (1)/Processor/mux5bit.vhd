----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:06:15 03/14/2025 
-- Design Name: 
-- Module Name:    mux5bit - Behavioral 
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

entity mux5bit is
    Port ( istr15_11 : in  STD_LOGIC_VECTOR (4 downto 0);
           instrt20_16 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux5out : out  STD_LOGIC_VECTOR (4 downto 0);
           rf_b1_sel : in  STD_LOGIC);
end mux5bit;

architecture Behavioral of mux5bit is
signal int_to_mux :STD_LOGIC_VECTOR (4 downto 0);
begin
--process(rf_b1_sel)
--begin
----wait until rf_b1_sel'event;
--case rf_b1_sel  is
--
--when '0' =>
--
--	int_to_mux<=istr15_11;
--
--when '1' =>
--
--	int_to_mux<=instrt20_16;
--	
--when others =>
--
--
--end case;
--
--end process;

mux5out<=istr15_11 WHEN rf_b1_sel = '0' ELSE instrt20_16;

end Behavioral;

