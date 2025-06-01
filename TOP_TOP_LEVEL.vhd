----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:06 03/24/2025 
-- Design Name: 
-- Module Name:    TOP_TOP_LEVEL - Behavioral 
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

entity TOP_TOP_LEVEL is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           CARRY_OUT : out  STD_LOGIC;
           OVF : out  STD_LOGIC);
end TOP_TOP_LEVEL;

architecture structural of TOP_TOP_LEVEL is

component DATAPATH
Port( Instr : OUT  STD_LOGIC_VECTOR (31 downto 0);
       RF_WrEn : in  STD_LOGIC;
   --        ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
---           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
       RF_WrData_sel : in  STD_LOGIC;
       RF_B_sel : in  STD_LOGIC;
       CLK : in  STD_LOGIC;
       Reset : in  STD_LOGIC;
         --  Immed : out  STD_LOGIC_VECTOR (31 downto 0);
         SELECTOR  : in  STD_LOGIC;--for byte or word
		 	  --RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           --RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
		 Opt_Ext : in STD_LOGIC_VECTOR (1 downto 0);
		   --RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           --top_RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
       ALU_Bin_Sel : in  STD_LOGIC;
       ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
		 CarryOut: OUT STD_LOGIC;
			  OverFl: OUT STD_LOGIC;
           --ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
          -- Immed : in  STD_LOGIC_VECTOR (31 downto 0);
		 ZERO_ALU_out : OUT STD_LOGIC;
			  
			  
			--  pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
       pc_sel : in  STD_LOGIC;
       pc_lden : in  STD_LOGIC;
		 MEM_WrEn: in  STD_LOGIC;
		------WRITE ENABLES-------- 
		RegRFA_WE: in  STD_LOGIC;
		RegRFB_WE: in  STD_LOGIC;
	   RegALU_WE	: in  STD_LOGIC;
		RegIMMED_WE: in  STD_LOGIC;
		RegInstr_WE: in  STD_LOGIC;
		RegWorB_WE: in  STD_LOGIC
			
		 );
end component;
component ControlPath
port(
			  CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           INSTR : in  STD_LOGIC_VECTOR (31 downto 0);
           
			  ALU_FUNC : out  STD_LOGIC_VECTOR (3 downto 0);
           ALU_ZERO : in  STD_LOGIC;
           ALU_BIN_SEL: OUT STD_LOGIC;
			  
			  SEL_BYTE: out  STD_LOGIC;
			---  BYTE: OUT STD_LOGIC_VECTOR (1 downto 0);
			  MEM_WrEn : out  STD_LOGIC;
			  
			  RF_WR_EN : out  STD_LOGIC;
           RF_B_SEL : out  STD_LOGIC;
           RF_WR_SEL : out  STD_LOGIC;
			  Opt_Ext : out STD_LOGIC_VECTOR (1 downto 0);
           
			  PC_SEL : out  STD_LOGIC;
           PC_LD_EN : out  STD_LOGIC;
			  
			  RegRFA_WE: out  STD_LOGIC;
				RegRFB_WE: out  STD_LOGIC;
				RegALU_WE	: out  STD_LOGIC;
				RegIMMED_WE: out  STD_LOGIC;
				RegInstr_WE: out  STD_LOGIC;
				RegWorB_WE: out  STD_LOGIC
			
);
end component;

--SIGNALS 
signal signal_ALU_Bin_sel,signal_ByteSelector,signal_ALU_zero,signal_MEM_WrEn,signal_PC_sel,signal_PC_LdEn : std_logic; 
signal signalRF_WrData_sel,signal_RF_B_sel,signal_RF_Wr_En : std_logic;
signal signal_OptExtender : std_logic_vector(1 downto 0);
signal signal_ALU_func : std_logic_vector(3 downto 0);
signal signal_Instr : std_logic_vector(31 downto 0);

signal signal_RegRFA_WE : std_logic;
signal signal_RegRFB_WE: std_logic;
signal signal_RegALU_WE: std_logic;
signal signal_RegIMMED_WE: std_logic;
signal signal_RegInstr_WE: std_logic;
signal signal_RegWorB_WE: std_logic;


begin

controller: ControlPath
port map(
CLK => CLK,
RESET => RESET,
INSTR => signal_Instr,
ALU_FUNC =>signal_ALU_func,
ALU_ZERO =>signal_ALU_zero,
ALU_BIN_SEL	  =>signal_ALU_Bin_sel,
SEL_BYTE=>signal_ByteSelector,
--BYTE =>open,
MEM_WrEn =>signal_MEM_WrEn,
RF_WR_EN =>signal_RF_Wr_En,
RF_B_SEL=>signal_RF_B_sel,
RF_WR_SEL =>signalRF_WrData_sel,
Opt_Ext=>signal_OptExtender,         
PC_SEL =>signal_PC_sel,
PC_LD_EN =>signal_PC_LdEn,
RegRFA_WE=>signal_RegRFA_WE,
RegRFB_WE=>signal_RegRFB_WE, 
RegALU_WE=>signal_RegALU_WE,
RegIMMED_WE=>signal_RegIMMED_WE,
RegInstr_WE=>signal_RegInstr_WE,
RegWorB_WE=>signal_RegWorB_WE
);

data1: DATAPATH
Port map(
Instr =>signal_Instr,
RF_WrEn =>signal_RF_Wr_En,
RF_WrData_sel=>signalRF_WrData_sel ,
RF_B_sel=>signal_RF_B_sel,
CLK =>CLK,
Reset =>RESET,
SELECTOR =>signal_ByteSelector,
Opt_Ext =>signal_OptExtender,
ALU_Bin_Sel =>signal_ALU_Bin_sel,
ALU_Func =>signal_ALU_func,
ZERO_ALU_out =>signal_ALU_zero,
pc_sel => signal_PC_sel,
pc_lden =>signal_PC_LdEn,
MEM_WrEn=>  signal_MEM_WrEn,
CarryOut=>CARRY_OUT,
OverFl=>Ovf,
RegRFA_WE=>signal_RegRFA_WE,
RegRFB_WE=>signal_RegRFB_WE, 
RegALU_WE=>signal_RegALU_WE,
RegIMMED_WE=>signal_RegIMMED_WE,
RegInstr_WE=>signal_RegInstr_WE,
RegWorB_WE=>signal_RegWorB_WE 
);


end structural;

