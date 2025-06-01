----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:52:08 03/11/2025 
-- Design Name: 
-- Module Name:    Exec_TopLevel - Behavioral 
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

entity Exec_TopLevel is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           top_RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_Sel : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			  ZERO_ALU_out : OUT STD_LOGIC;
			  CarryOut: OUT STD_LOGIC;
			  OverFl: OUT STD_LOGIC);
end Exec_TopLevel;

architecture Structural of Exec_TopLevel is
component ALU
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
			  END COMPONENT;
component Mux
Port ( RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal outMuxToAlu : STD_LOGIC_VECTOR (31 downto 0);
begin
U1: ALU Port Map(
A =>RF_A,
B => outMuxToAlu,
Op => ALU_Func,
Zero =>ZERO_ALU_out,
Output=>ALU_Out,
Cout =>CarryOut,----------
Ovf  =>OverFl-----------ask processor swtiriaadh 
);
U2: Mux Port Map(
RF_B=>top_RF_B,
immed=>Immed,
ALU_Bin_sel=>ALU_Bin_Sel,
mux_Out=>outMuxToAlu
);



end Structural;

