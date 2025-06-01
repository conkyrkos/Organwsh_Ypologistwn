----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:13 05/23/2025 
-- Design Name: 
-- Module Name:    Top_pipesline - Behavioral 
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

entity Top_pipesline is
 Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end Top_pipesline;

architecture Behavioral of Top_pipesline is
component DATAPATHPIPES is
Port(		  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_SEL : in  STD_LOGIC;
           PC_LDEN : in  STD_LOGIC;
           RF_B_SEL : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           OptExt : in  STD_LOGIC_VECTOR (1 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Bin_Sel : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
			  SELECTOR : in STD_LOGIC;
			  ZERO_ALU_out : out STD_LOGIC;
			  Instr : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component ControlPath is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           INSTR : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_ZERO : in  STD_LOGIC;
           
			  ALU_FUNC : out  STD_LOGIC_VECTOR (3 downto 0);  
           ALU_BIN_SEL: OUT STD_LOGIC;
			  
			  SEL_BYTE: out  STD_LOGIC;
			 -- BYTE: OUT STD_LOGIC_VECTOR (1 downto 0);
			  MEM_WrEn : out  STD_LOGIC;
			  
			  RF_WR_EN : out  STD_LOGIC;
           RF_B_SEL : out  STD_LOGIC;
           RF_WR_SEL : out  STD_LOGIC;
			  Opt_Ext : out STD_LOGIC_VECTOR (1 downto 0);
           
			  PC_SEL : out  STD_LOGIC;
           PC_LD_EN : out  STD_LOGIC);
end component;


signal Instr_sig : STD_LOGIC_VECTOR (31 downto 0);
signal ALU_zero_sig : STD_LOGIC;
signal PC_sel_sig : STD_LOGIC;
signal PC_LdEn_sig : STD_LOGIC;
signal RF_B_sel_sig : STD_LOGIC;
signal RF_WrData_sel_sig : STD_LOGIC;
signal opt_ext_sig : STD_LOGIC_VECTOR (1 downto 0);
signal ALU_func_sig : STD_LOGIC_VECTOR (3 downto 0);
signal ALU_Bin_sel_sig : STD_LOGIC;
signal MEM_WrEn_sig : STD_LOGIC;
signal Selectort_sig : STD_LOGIC;
signal RF_WrEn_sig : STD_LOGIC;
signal Instr_Reg_WrEn_sig : STD_LOGIC;

begin


datapat :DATAPATHPIPES
Port MAP(  CLK => CLK,
           RST => RST,
           PC_SEL =>PC_sel_sig ,
           PC_LDEN =>PC_LdEn_sig ,
           RF_B_SEL => RF_B_sel_sig,
           RF_WrData_sel =>RF_WrData_sel_sig ,
           OptExt => opt_ext_sig,
           RF_WrEn =>RF_WrEn_sig ,
           ALU_Func => ALU_func_sig ,
           ALU_Bin_Sel => ALU_Bin_sel_sig,
           MEM_WrEn => MEM_WrEn_sig,
			  SELECTOR => Selectort_sig,
			  ZERO_ALU_out => ALU_zero_sig ,
			  Instr => Instr_sig
			  
			  );
			  
CONTROL :Controlpath

port map(  CLK => CLK,
           RESET => RST,
           INSTR => Instr_sig,
			  ALU_ZERO => ALU_zero_sig, 
			  ALU_FUNC  => ALU_func_sig,
           ALU_BIN_SEL => ALU_Bin_sel_sig,  
			  SEL_BYTE=> Selectort_sig,
			  MEM_WrEn => MEM_WrEn_sig , 
			  RF_WR_EN => RF_WrEn_sig,
           RF_B_SEL => RF_B_sel_sig,
           RF_WR_SEL => RF_WrData_sel_sig,
			  Opt_Ext => opt_ext_sig,       
			  PC_SEL => PC_sel_sig,
           PC_LD_EN =>PC_LdEn_sig 
			  
			  );
			  
			  
end Behavioral;

