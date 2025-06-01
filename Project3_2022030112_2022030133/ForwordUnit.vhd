----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:15:33 05/18/2025 
-- Design Name: 
-- Module Name:    ForwordUnit - Behavioral 
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

entity ForwordUnit is
    Port ( RS : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_RT : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_MEM_WB : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_EXEC_MEM : in  STD_LOGIC_VECTOR (4 downto 0);
           WREN_EXEC_MEM : in  STD_LOGIC;
           WREN_MEM_WB : in  STD_LOGIC;
           FA : out  STD_LOGIC_VECTOR (1 downto 0);
           FB : out  STD_LOGIC_VECTOR (1 downto 0));
end ForwordUnit;

architecture Behavioral of ForwordUnit is
signal fA_sig : STD_LOGIC_VECTOR (1 downto 0);
signal fB_sig : STD_LOGIC_VECTOR (1 downto 0); 
begin
process(RS,RD_RT,RD_EXEC_MEM,RD_MEM_WB,WREN_EXEC_MEM,WREN_MEM_WB)
begin
-- 	F A
		if (WREN_EXEC_MEM = '1' and RD_EXEC_MEM /= "00000" and RD_EXEC_MEM = RS) then
			fA_sig <= "10";
		elsif (WREN_MEM_WB = '1' and RD_MEM_WB /= "00000" and RD_MEM_WB = RS) then
		elsif (WREN_MEM_WB = '1' and RD_MEM_WB /= "00000" and RD_MEM_WB = RS) then
			fA_sig <= "01";
		else
			fA_sig <= "00";
		end if;
		
		
--  F B
		if (WREN_EXEC_MEM = '1' and RD_EXEC_MEM /= "00000" and RD_EXEC_MEM = RD_RT) then
			fB_sig <= "10";
		elsif (WREN_MEM_WB = '1' and RD_MEM_WB /= "00000" and RD_MEM_WB = RD_RT) then
			fB_sig <= "01";
		else
			fB_sig <= "00";
		end if;

end process;
fA <= fA_sig;
fB <= fB_sig;
end Behavioral;

