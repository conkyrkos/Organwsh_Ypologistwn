----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:40:29 06/22/2024 
-- Design Name: 
-- Module Name:    Register5 - Behavioral 
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

entity Register5bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (4 downto 0));
end Register5bit;

architecture Behavioral of Register5bit is

signal tempOut: std_logic_vector(4 downto 0);

begin
process(CLK,WE,RST)
begin
	if RST='1' then
	   tempOut<="00000"; 
	else
	   if (WE='1' and rising_edge(CLK))then
	       tempOut<=DataIn;
	   else
	       tempOut<=tempOut;
	   end if;
    end if;
end process;

Dataout<=tempOut;

end Behavioral;

