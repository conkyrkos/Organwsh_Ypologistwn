----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:16:14 03/06/2025 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
           Zero : out  STD_LOGIC:='0';
           Cout : out  STD_LOGIC:='0';
           Ovf : out  STD_LOGIC:='0');
end ALU;

architecture Behavioral of ALU is
signal Ou : STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
signal Out_cout : STD_LOGIC_VECTOR (32 downto 0):= (others => '0');
signal overflow : STD_LOGIC;
begin

--wait until op'event or A'event or B'event;
process(op,A,B)
begin
---overflow <= ((a(31) AND b(31) AND (NOT output(31))) OR ((NOT a(31)) AND (NOT b(31)) AND output(31)));

	case(Op)is
	
	when "0000" => --Addition
		Ou <= A+B;
--if(((A(31) = '1') AND (B(31) = '1') AND (Ou(31) = '0')) OR 
--   ((A(31) = '0') AND (B(31) = '0') AND (Ou(31) = '1'))) then
--   	Ov <='1';
--		else 
--		Ov <='0';
--		end if;
	Out_cout<= (A(31) & A)+(B(31) & B);
	---Cout<=Out_cout(32);--Carry Out <= result (32)
	--Out_cout<=((A(31) & A)+(B(31) & B))(32)--Out_cout(32);

	when "0001" => --Subtraction
	Ou <= A-B;
	
	--if((A(31)/=B(31) AND (A(31) /= Ou(31)))) then
	--	overflow <='1';
	--	else 
	--	overflow <='0';
	--	end if;
	--Out_cout<= ((A(31)& A) - (B(31) & B));
	
	
	when "0010" => --Logic And
	Ou <= A and B;
	
	when "0011" => --Logic Or
	Ou <= A or B;
	
	when "0100" => --Logic Not
	Ou <= not A;
	
	when "1000" => --Msb shift right
	Ou <= std_logic_vector(shift_right(signed (A),1));--- {Α[31], Α[31], ... Α[1]}
	
	when "1001" => --Logic shift right
	Ou <= std_logic_vector(signed(A) srl 1);
	
	when "1010" => --Logic shift left
	Ou <= std_logic_vector(signed(A) sll 1);
	
	when "1100" => --Rotate left
	Ou <= std_logic_vector(signed(A) rol 1);
	
	when "1101" => --Rotate right
	Ou <= std_logic_vector(signed(A) ror 1);
	
	when others =>
		--Ovf<='0';
		--Cout<='0';
		
end case; 


end process;

---Out_cout<= (((A(31)& A)-(B(31)& B)) when (Op="0001")) or (((A(31) & A)+(B(31) & B)) when (op="0000")) ;
--Carry Out <= result (32)

Ovf <= '1' when ((A(31) = B(31)) and (B(31) /= Ou(31)) and Op="0000")or ((A(31) /= B(31)) and (A(31) /=Ou(31)) and Op="0001") else '0';
Zero <= '1' when Ou =(Ou'range => '0') else '0';
Cout<=Out_cout(32);
Output<=Ou;
--ovf<=overflow;
end Behavioral;
