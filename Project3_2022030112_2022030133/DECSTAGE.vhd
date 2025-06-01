----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:25:56 03/14/2025 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  Opt_Ext : in STD_LOGIC_VECTOR (1 downto 0);
			  muxout: out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;




architecture Stractural of DECSTAGE is

component RegistFile
   Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
			  Reset :  in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end Component;
component Mux2_1 
 Port ( 	  mem_out : in  STD_LOGIC_VECTOR (31 downto 0);
           alu_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component EXTENDER 
Port ( 	  Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
			  ext_op : in  STD_LOGIC_VECTOR (1 downto 0));
end Component;

component  mux5bit
 Port ( istr15_11 : in  STD_LOGIC_VECTOR (4 downto 0);
           instrt20_16 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux5out : out  STD_LOGIC_VECTOR (4 downto 0);
           rf_b1_sel : in  STD_LOGIC);
end component;


Signal mux5_signal : STD_LOGIC_VECTOR (4 downto 0);
Signal mux32_signal : STD_LOGIC_VECTOR (31 downto 0);

begin
ex : EXTENDER port map(
Instr => Instr(15 downto 0),
Immed => Immed,
ext_op => Opt_Ext
);

regis: RegistFile port map(
Ard1=>Instr(25 downto 21),
Ard2=>mux5_signal,
Awr  =>Instr(20 downto 16),
Dout1 =>RF_A,
Dout2 =>RF_B,
Din => mux32_signal,
WrEn => RF_WrEn,
Clk => CLK,
Reset =>Reset
);

mux5: mux5bit port map(
istr15_11 => Instr(15 downto 11),
instrt20_16=> Instr(20 downto 16),
mux5out => mux5_signal,
rf_b1_sel =>RF_B_sel
);

mux32: Mux2_1 port map(
mem_out =>MEM_out,
alu_out=>ALU_out,
RF_WrData_sel =>RF_WrData_sel,
mux_out => mux32_signal
);

muxout<=mux32_signal;
end Stractural;

