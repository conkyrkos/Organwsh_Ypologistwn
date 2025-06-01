----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:03 05/19/2025 
-- Design Name: 
-- Module Name:    Hazard_det_Unit - Behavioral 
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

entity Hazard_det_Unit is
    Port ( RS : in  STD_LOGIC_VECTOR (4 downto 0);
           RT : in  STD_LOGIC_VECTOR (4 downto 0);
           RT_D_E : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WREN : in  STD_LOGIC;
           HAZARD_OUT : out  STD_LOGIC;
           PC_EN_HUZ : out  STD_LOGIC;
           WREN_I_D : out  STD_LOGIC);
end Hazard_det_Unit;

architecture Behavioral of Hazard_det_Unit is

begin
process(RS, RT, RT_D_E, MEM_WREN)
begin
	if (MEM_WREN = '1' and (RS = RT_D_E or Rt = RT_D_E)) then
		HAZARD_OUT <= '1';
		PC_EN_HUZ <= '0';
		WREN_I_D <= '0';
	else
		HAZARD_OUT <= '0';
		PC_EN_HUZ <= '1';
		WREN_I_D <= '1';
	end if;
end process;

end Behavioral;

