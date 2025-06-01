----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:38:03 03/14/2025 
-- Design Name: 
-- Module Name:    Mux2_1 - Behavioral 
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

entity Mux2_1 is
    Port ( mem_out : in  STD_LOGIC_VECTOR (31 downto 0);
           alu_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux2_1;

architecture Behavioral of Mux2_1 is
--signal int_to_out :STD_LOGIC_VECTOR (31 downto 0);
begin
--process(RF_WrData_sel)
--begin
----wait until RF_WrData_sel'event;
--case RF_WrData_sel  is
--
--when '0' =>
--
--	int_to_out<=mem_out;
--
--when '1' =>
--
--	int_to_out<=alu_out;
--	
--	
--when others=>
--
--end case;
--
--end process;

mux_out<=mem_out WHEN RF_WrData_sel='1' ELSE alu_out;


end Behavioral;

