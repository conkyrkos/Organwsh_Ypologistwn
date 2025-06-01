----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:24:44 03/12/2025 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( awr : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is

begin
process(Awr)
begin
--Wait until Awr'event;
case(awr) is

when "00000" => Output <= "00000000000000000000000000000001";
when "00001" => Output <= "00000000000000000000000000000010";
when "00010" => Output <= "00000000000000000000000000000100";
when "00011" => Output <= "00000000000000000000000000001000";
when "00100" => Output <= "00000000000000000000000000010000";
when "00101" => Output <= "00000000000000000000000000100000";
when "00110" => Output <= "00000000000000000000000001000000";
when "00111" => Output <= "00000000000000000000000010000000";
when "01000" => Output <= "00000000000000000000000100000000";
when "01001" => Output <= "00000000000000000000001000000000";
when "01010" => Output <= "00000000000000000000010000000000";
when "01011" => Output <= "00000000000000000000100000000000";
when "01100" => Output <= "00000000000000000001000000000000";
when "01101" => Output <= "00000000000000000010000000000000";
when "01110" => Output <= "00000000000000000100000000000000";
when "01111" => Output <= "00000000000000001000000000000000";
when "10000" => Output <= "00000000000000010000000000000000";
when "10001" => Output <= "00000000000000100000000000000000";
when "10010" => Output <= "00000000000001000000000000000000";
when "10011" => Output <= "00000000000010000000000000000000";
when "10100" => Output <= "00000000000100000000000000000000";
when "10101" => Output <= "00000000001000000000000000000000";
when "10110" => Output <= "00000000010000000000000000000000";
when "10111" => Output <= "00000000100000000000000000000000";
when "11000" => Output <= "00000001000000000000000000000000";
when "11001" => Output <= "00000010000000000000000000000000";
when "11010" => Output <= "00000100000000000000000000000000";
when "11011" => Output <= "00001000000000000000000000000000";
when "11100" => Output <= "00010000000000000000000000000000";
when "11101" => Output <= "00100000000000000000000000000000";
when "11110" => Output <= "01000000000000000000000000000000";
when "11111" => Output <= "10000000000000000000000000000000";
when others  => Output <= "00000000000000000000000000000000";
end case;
end process;
end Behavioral;

