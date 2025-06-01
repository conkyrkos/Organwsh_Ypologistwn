----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:54:23 03/14/2025 
-- Design Name: 
-- Module Name:    Instr_to_Immed - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-----------------EXTENDER-----------
entity EXTENDER is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
			  ext_op : in  STD_LOGIC_VECTOR (1 downto 0));
end EXTENDER;

architecture Behavioral of EXTENDER is
signal instra : STD_LOGIC_VECTOR (15 downto 0);
--signal temp : STD_LOGIC_VECTOR (31 downto 0);

begin

process(Instr,ext_op)
begin
--wait until Instr'event or ext_op'event;
instra<=Instr;

----NO SHIFT LEFT   |  2 SHIFT LEFT 
----------------------------------------
----ZERO FILL  \  00    |ZERO FILL 	\   11
----SIGN EXTEND\  10    |SIGN EXTEND \  01



case(ext_op) is 

	when "10"=> --sign extend
		Immed <= (31 downto 16=> Instr(15)) & Instr;
	
	when "00"=> -- zero fill 
		Immed<=  ( 31 downto 16=>'0') & Instr  ;
	
	
	when "01"=>--sign extend and shift left for 2----GIA NA MHN XASOUME TA MSB PRWTA KNM THN PRAJH KAI META SLL
	--	temp<= (31 downto 16=> Instr(15)) & Instr;
		Immed <= std_logic_vector(signed((31 downto 16 => Instr(15)) & Instr) sll 2); --std_logic_vector(unsigned(temp) sll 2);

	when "11"=> --ZERO FILL AND SHIFT
	--	temp<= std_logic_vector(((31 downto 16 => Instr(15)) & Instr) sll 2);
	--	Immed <= std_logic_vector(signed(temp) sll 2); 
		--Immed <= std_logic_vector(signed(Instr & (16 downto 0 => '0')) sll 16); --std_logic_vector(unsigned(temp) sll 2);
		Immed <= Instr & (31 downto 16=> Instr(15)) ;
		when others =>
	
end case;
end process;
end Behavioral;

