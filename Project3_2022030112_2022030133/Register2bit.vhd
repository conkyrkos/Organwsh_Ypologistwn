----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:40:13 06/22/2024 
-- Design Name: 
-- Module Name:    Register2 - Behavioral 
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

entity Register2bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (1 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (1 downto 0));
end Register2bit;

architecture Behavioral of Register2bit is

signal tempOut: std_logic_vector(1 downto 0);

begin
process(CLK,WE,RST)
begin
	if RST='1' then
	   tempOut<="00"; 
		 
	else
	   if (WE='1' and rising_edge(CLK))then
	       tempOut<=DataIn;
	   else
	       tempOut<=tempOut;
	   end if;
    end if;
end process;

DataOut<=tempOut;


end Behavioral;

