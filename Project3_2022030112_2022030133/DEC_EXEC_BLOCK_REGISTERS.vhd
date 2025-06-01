----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:21:58 05/18/2025 
-- Design Name: 
-- Module Name:    DEC_EXEC_BLOCK_REGISTERS - Behavioral 
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

entity DEC_EXEC_BLOCK_REGISTERS is
    Port ( we : in  STD_LOGIC;
				 CLK : in  STD_LOGIC;
				 RST : in  STD_LOGIC;
				Instr_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Instr_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Immed_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0);
           RFA_in : in  STD_LOGIC_VECTOR (31 downto 0);
           RFA_out : out  STD_LOGIC_VECTOR (31 downto 0);
           RFB_in : in  STD_LOGIC_VECTOR (31 downto 0);
           RFB_out : out  STD_LOGIC_VECTOR (31 downto 0);
           EXEC_in : in  STD_LOGIC_VECTOR (4 downto 0);
           EXEC_out : out  STD_LOGIC_VECTOR (4 downto 0);
           EXEC_MEM_in : in  STD_LOGIC_VECTOR (1 downto 0);
           EXEC_MEM_out : out  STD_LOGIC_VECTOR (1 downto 0);
           EXEC_WB_in : in  STD_LOGIC_VECTOR (1 downto 0);
           EXEC_WB_out : out  STD_LOGIC_VECTOR (1 downto 0);
           MUX_in : in  STD_LOGIC_VECTOR (4 downto 0);
           MUX_out : out  STD_LOGIC_VECTOR (4 downto 0);
           RFB_sel_in : in  STD_LOGIC;
           RFB_sel_out : out  STD_LOGIC);
end DEC_EXEC_BLOCK_REGISTERS;

architecture Structural of DEC_EXEC_BLOCK_REGISTERS is
component Register5bit 
Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (4 downto 0));
end component ;

component Register2bit 
 Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (1 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (1 downto 0));
end component;
component RegisterMOdule is
    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC
			  );
end component;
component Reg1   is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC;
           DataOut : out  STD_LOGIC);
end component;

begin

Rf_bin_sel_reg : Reg1
		port map(
					CLK => CLK,
					RST => RST,
					DataIn =>  RFB_sel_in,
					DataOut =>  RFB_sel_out,
					WE => '1'
				);
	

Immed_Register : RegisterMOdule
		port map(
						CLK => CLK,
						RST => RST,
						Data => Immed_in,
						DOUT => Immed_out,
						we => we
					);
RF_A_Register : RegisterMOdule
		port map(
						CLK => CLK,
						RST => RST,
						Data => RFA_in,
						DOUT => RFA_out,
						we => we
					);
RF_B_Register : RegisterMOdule
		port map(
						CLK => CLK,
						RST => RST,
						Data => RFB_in,
						DOUT => RFB_out,
						we => we
					);
WB_Addr_Register : RegisterMOdule
		port map(
						CLK => CLK,
						RST => RST,
						Data => Instr_in,
						DOUT => Instr_out,
						we => we
					);
					
Exec_control_Register : Register5bit
		port map(
						CLK => CLK,
						RST => RST,
						we => we,
						DataIn => EXEC_in,
						DataOUT => EXEC_out
					);
MuxResult_Register : Register5bit 
		port map(
						CLK => CLK,
						RST => RST,
						we => we,
						DataIn => MUX_in,
						DataOUT => MUX_out
					);
					
MEM_control_Register : Register2bit 
		port map(
						CLK => CLK,
						RST => RST,
						we => we,
						DataIn=> EXEC_MEM_in,
						DataOUT => EXEC_MEM_out
					);
WB_control_Register : Register2bit 
		port map(
						CLK => CLK,
						RST => RST,
						we => we,
						DataIn => EXEC_WB_in,
						DataOUT => EXEC_WB_out
					);

end Structural;

