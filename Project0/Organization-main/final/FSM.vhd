----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:02:26 02/12/2025 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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

entity FSM is

    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           AddrWrite : in  STD_LOGIC_VECTOR (4 downto 0);
           AddrRead : in  STD_LOGIC_VECTOR (4 downto 0);
			  addWriteOut : out  STD_LOGIC_VECTOR (4 downto 0);
           addReadOut : out STD_LOGIC_VECTOR (4 downto 0);

           Write : in  STD_LOGIC;
           Read : in  STD_LOGIC;
        --   NumberIN : in  STD_LOGIC_VECTOR (15 downto 0);
           NumberOUT : out  STD_LOGIC_VECTOR (15 downto 0);
           Valid : out  STD_LOGIC;
			  WriteEnable : out STD_LOGIC			  );
	
end FSM;


architecture Behavioral of FSM is
type state is (Waiting,Writing,Reading,Reading_Writing);
signal s : state :=Waiting;
BEGIN
process
begin

--Valid <= '0';
	WAIT UNTIL CLK'EVENT ;


	if(RST ='1') THEN
		s<=Waiting;
		
		--NumberIN <= "000000000000000";
	else
	
	case s is
	
		-----------Waiting------------	
		when 	Waiting =>
		--WriteEnable <= '0';
			if Write ='0' and Read ='1' then
				s<=Reading;
				--addWriteOut<=AddrWrite;
				addReadOut<=AddrRead;
				--Valid <= '1';
				
			
			elsif Write ='1'and Read = '0' then
				s<=Writing;
				addWriteOut<=AddrWrite;
				--addReadOut<=AddrRead;
			--	Valid <= '0';
				
			elsif Write = '1' and Read = '1' then
				
				s<=Reading_Writing;
				addReadOut<=AddrRead;
			--	Valid <= '1';
				addWriteOut<=AddrWrite;
			else
				s<=Waiting;
				addWriteOut<=AddrWrite;
				addReadOut<=AddrRead;
			--	Valid <= '0';
			end if;
			-------------Reading----------
		when 	Reading =>
			if Write ='0' and Read ='1' then
				s<=Reading;
				addWriteOut<=AddrWrite;
				addReadOut<=AddrRead;
			--	Valid <= '1';
				
			
			
			elsif Write ='1'and Read = '0' then
			--	WriteEnable <='1';
				addWriteOut<=AddrWrite;
				--addReadOut<=AddrRead;
			--	Valid <= '0';
			s<=Writing;

			elsif Write = '1' and Read = '1' then
				s<=Reading_Writing;
				addReadOut<=AddrRead;
			--	Valid <= '1';
		--		WriteEnable <='1';
				addWriteOut<=AddrWrite;
				
			end if;
			
		----------------Writing-------------------
		when 	Writing =>
	--	WriteEnable <='1';
		
		--WriteEnable <='0';

			if Write ='0' and Read ='1' then
				s<=Reading;
				--addWriteOut<=AddrWrite;
				addReadOut<=AddrRead;
			--	Valid <= '1';
			
			
			elsif Write ='1'and Read = '0' then
			--	WriteEnable <='1';
				s<=Writing;
				addWriteOut<=AddrWrite;
				--addReadOut<=AddrRead;
			--	Valid <= '0';
				
			elsif Write = '1' and Read = '1' then
				s<=Reading_Writing;
				addReadOut<=AddrRead;
			--	Valid <= '1';
		--		WriteEnable <='1';
				addWriteOut<=AddrWrite;
				
			end if;
			
			-------------Read-Writing------------
			when 	Reading_Writing =>
		
			if Write ='0' and Read ='1' then
				s<=Reading;
				--addWriteOut<=AddrWrite;
				addReadOut<=AddrRead;
				--Valid <= '1';
			
			
			elsif Write ='1'and Read = '0' then
--				WriteEnable <='1';
				s<=Writing;
				addWriteOut<=AddrWrite;
				--addReadOut<=AddrRead;
				--Valid <= '0';
				
			elsif Write = '1' and Read = '1' then
				s<=Reading_Writing;
				addReadOut<=AddrRead;
				--Valid <= '1';
			--	WriteEnable <='1';
				addWriteOut<=AddrWrite;
				
				
			end if;
			
			when others =>
				s<=Waiting;
				addWriteOut<=AddrWrite;
				addReadOut<=AddrRead;
			--	Valid <= '0';
			end case;
			
		end if;
	

end process;
WriteEnable <= '1' WHEN s= Writing or s= Reading_Writing else '0';
Valid <= '1' WHEN s= Reading or s= Reading_Writing else '0';

end Behavioral;
