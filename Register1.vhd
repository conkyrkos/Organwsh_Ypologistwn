----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:57:23 06/22/2024 
-- Design Name: 
-- Module Name:    Register12 - Behavioral 
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

entity Register1 is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC;
           DataOut : out  STD_LOGIC);
end Register1;

architecture Behavioral of Register1 is

signal tmpDout : STD_LOGIC; 

begin
	process(CLK)
	begin
        
	if (rising_edge(CLK)) then 
		if RST='1' then
			tmpDout <= '0';
		else 
			if WE = '1' then
				tmpDout <= DataIn;
			end if;
		end if;
	end if;
		
	end process;
	
	DataOut <= tmpDout;

end Behavioral;

