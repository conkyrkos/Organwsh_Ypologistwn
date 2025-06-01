----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:02:45 05/18/2025 
-- Design Name: 
-- Module Name:    mux_2_1 - Behavioral 
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

entity mux_2_1 is
    Port ( in0 : in  STD_LOGIC_VECTOR (1 downto 0);
           in1 : in  STD_LOGIC_VECTOR (1 downto 0);
           sel : in  STD_LOGIC;
           mux_out : out  STD_LOGIC_VECTOR (1 downto 0));
end mux_2_1;

architecture Behavioral of mux_2_1 is
begin
mux_out<=in1 WHEN sel = '1' ELSE in0;


end Behavioral;

