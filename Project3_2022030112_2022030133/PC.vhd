----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:50:11 03/16/2025 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pc_ld_en : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is
signal signal_output : STD_LOGIC_VECTOR (31 downto 0);
begin
process(clk,rst,pc_ld_en)
begin
--wait until clk'event or rst'event or pc_ld_en'event;
if (rst='1') then 
		signal_output<=(31 downto 0 => '0');
	else	
if rising_edge(clk) then 
			if(pc_ld_en='0') then
				signal_output<=	signal_output;
			else
				signal_output <=input;
			end if;
	end if;
end if;

end process;
output<=signal_output;
end Behavioral;

