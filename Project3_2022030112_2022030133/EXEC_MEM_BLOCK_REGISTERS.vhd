----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:19:45 05/18/2025 
-- Design Name: 
-- Module Name:    EXEC_MEM_BLOCK_REGISTERS - Behavioral 
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

entity EXEC_MEM_BLOCK_REGISTERS is
    Port ( Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Instruction_adress_in : in  STD_LOGIC_VECTOR (4 downto 0);
           Instruction_adress_out : out  STD_LOGIC_VECTOR (4 downto 0);
           mem_adress_in : in  STD_LOGIC_VECTOR (31 downto 0);
           mem_adress_out : out  STD_LOGIC_VECTOR (31 downto 0);
           mem_in : in  STD_LOGIC_VECTOR (1 downto 0);
           mem_out : out  STD_LOGIC_VECTOR (1 downto 0);
           mem_wb_in : in  STD_LOGIC_VECTOR (1 downto 0);
           mem_wb_out : out  STD_LOGIC_VECTOR (1 downto 0);
           rd_rt_in : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_rt_out : out  STD_LOGIC_VECTOR (4 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			   WE : in  STD_LOGIC);
end EXEC_MEM_BLOCK_REGISTERS;

architecture Behavioral of EXEC_MEM_BLOCK_REGISTERS is

component Register5bit is

    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (4 downto 0));
			  
end component;

component RegisterMOdule is

    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC
			  );
			  
end component;

component Register2bit is

    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (1 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (1 downto 0));
			  
end component; 
begin

ALU_Register : RegisterMOdule
			port map(
							CLK => CLK,
							RST => RST,
							we => '1',
							Data => mem_adress_in,
							Dout => mem_adress_out
						);
						
RF_B_Register : RegisterMOdule
			port map(
							CLK => CLK,
							RST => RST,
							we => '1',
							Data => Data_in,
							Dout => Data_out
						);
						
WB_Addr_Register : Register5bit
			port map(
							CLK => CLK,
							RST => RST,
							we => '1',
							Datain => Instruction_adress_in,
							Dataout => Instruction_adress_out
						);
						
Rd_Rt_Register : Register5bit
			port map(
							CLK => CLK,
							RST => RST,
							we => '1',
							Datain => rd_rt_in,
							Dataout => rd_rt_out
						);	
	
MEM_control_Register : Register2bit
		port map(
						CLK => CLK,
						RST => RST,
						we => '1',
						Datain => mem_in,
						Dataout => mem_out
					);
					
WB_control_Register : Register2bit
		port map(
						CLK => CLK,
						RST => RST,
						we => '1',
						Datain => mem_wb_in,
						Dataout => mem_wb_out
					);


end Behavioral;

