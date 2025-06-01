----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:46 03/12/2025 
-- Design Name: 
-- Module Name:    RegisterMOdule - Behavioral 
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

entity RegisterMOdule is
    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in STD_LOGIC
			  );
end RegisterMOdule;

architecture Behavioral of RegisterMOdule is

signal data_out :STD_LOGIC_VECTOR (31 downto 0);

begin
process (CLK,reset,WE)
begin
--Wait until CLK'EVENT and CLK='1';

 
 IF rising_edge(CLK)THEN
	if(reset='1') then 
	data_out<="00000000000000000000000000000000";
	else
	if (WE = '0') then
		data_out <= data_out;
	else
		data_out <= Data;
	end if;
END IF;
END IF;


end process;
DOUT<=data_out;
end Behavioral;
