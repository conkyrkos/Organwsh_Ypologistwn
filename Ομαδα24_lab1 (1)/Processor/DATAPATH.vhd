----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:15 03/16/2025 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
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
		 MEM_WrEn: in  STD_LOGIC
		 );
         
end DATAPATH;
architecture STRUCTURAL of DATAPATH is

component   DECSTAGE
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
			  Opt_Ext : in STD_LOGIC_VECTOR (1 downto 0));
END COMPONENT;

COMPONENT Exec_TopLevel 
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           top_RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_Sel : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			  ZERO_ALU_out : OUT STD_LOGIC;
			  CarryOut: OUT STD_LOGIC;
			  OverFl: OUT STD_LOGIC);
END COMPONENT;

COMPONENT  IF_TOPLEVEL 
    Port ( pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_sel : in  STD_LOGIC;
           pc_lden : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           instr : out  STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT;

COMPONENT MEMSTAGE IS
  PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT word_byte_selector 
    Port ( number : in  STD_LOGIC_VECTOR (31 downto 0);
           selector : in  STD_LOGIC;
			  BYTE : in STD_LOGIC_VECTOR (1 downto 0);
           selector_output : out  STD_LOGIC_VECTOR (31 downto 0));
			
END COMPONENT;


signal signal_rf_a: STD_LOGIC_VECTOR (31 downto 0);
signal signal_rf_b: STD_LOGIC_VECTOR (31 downto 0);
signal signal_alu_out: STD_LOGIC_VECTOR (31 downto 0);
signal signal_immed: STD_LOGIC_VECTOR (31 downto 0);
signal signal_instr: STD_LOGIC_VECTOR (31 downto 0);
signal signal_mem: STD_LOGIC_VECTOR (31 downto 0);
signal signal_selector_out :STD_LOGIC_VECTOR (31 downto 0);


begin
W_OR_B:word_byte_selector ---WE NEED DO SEND THE ORDER TO MEMORY
    Port MAP ( 	 
number =>signal_mem,
selector => SELECTOR,
BYTE => signal_alu_out(1 DOWNTO 0),
selector_output =>signal_selector_out
);

memory:  MEMSTAGE PORT mAP(
a => signal_alu_out(11 DOWNTO 2),
d => signal_rf_b,
clk =>CLK,
we => MEM_WrEn,
spo =>signal_mem
  );


exec_level:Exec_TopLevel 
 Port MAP( 
RF_A =>signal_rf_a,
top_RF_B => signal_rf_b,
ALU_Bin_Sel =>ALU_Bin_Sel,
ALU_Func =>ALU_Func,
ALU_Out =>signal_alu_out,
Immed =>signal_immed,
ZERO_ALU_out =>ZERO_ALU_out,
CarryOut=>CarryOut,
OverFl=>OverFl

);


dec_level: DECSTAGE 
Port Map( 
RF_A =>signal_rf_a,
RF_B =>signal_rf_b,
Opt_Ext => Opt_Ext,
Immed => signal_immed,
Instr =>signal_instr,
RF_WrEn =>RF_WrEn,
ALU_out => signal_alu_out,
MEM_out => signal_selector_out,
RF_WrData_sel => RF_WrData_sel ,
RF_B_sel => RF_B_sel,
CLK =>CLK,
Reset =>Reset);




if_level:IF_TOPLEVEL 
Port map ( 
pc_immed =>signal_immed,
pc_sel => pc_sel, 
pc_lden => pc_lden,
rst =>RESET,
clk =>CLK,
instr => signal_instr 
);


Instr <=signal_instr;

end STRUCTURAL;

