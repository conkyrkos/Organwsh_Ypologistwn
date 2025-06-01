----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:35 05/18/2025 
-- Design Name: 
-- Module Name:    Mem_Wb - Behavioral 
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

entity Mem_Wb is
    Port ( Data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Addr_in : in  STD_LOGIC_VECTOR (4 downto 0);
           Addr_out : out  STD_LOGIC_VECTOR (4 downto 0);
           Mem_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_out : out  STD_LOGIC_VECTOR (31 downto 0);
           WB_in : in  STD_LOGIC_VECTOR (1 downto 0);
           WB_out : out  STD_LOGIC_VECTOR (1 downto 0);
           Rd_Rt_in : in  STD_LOGIC_VECTOR (4 downto 0);
           Rd_Rt_out : out  STD_LOGIC_VECTOR (4 downto 0);
           we : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end Mem_Wb;

architecture Behavioral of Mem_Wb is

component RegisterMOdule is
    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
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

component Register5bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (4 downto 0));
			  
end component;

begin

ALU_reg: RegisterMOdule
	port map (	CLK => CLK,
					RST => RST,
					we => '1',
					Data => Data_in,
					Dout => Data_out
				);
				
memAdr: Register5bit
	port map (	CLK => CLK,
					RST => RST,
					we => '1',
					Datain => Rd_Rt_in,
					Dataout => Rd_Rt_out
				);
	
Rd_Rt_register: Register5bit
	port map (	CLK => CLK,
					RST => RST,
					we => '1',
					Datain => Addr_in,
					Dataout => Addr_out
				);
				
mem_reg: RegisterMOdule
	port map (	CLK => CLK,
					RST => RST,
					we => '1',
					Data => Mem_in,
					Dout => Mem_out
				);

WB_control_Register : Register2bit
		port map(
						CLK => CLK,
						RST => RST,
						we => '1',
						Datain => WB_in,
						Dataout => WB_out
					);


end Behavioral;

