----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:24:49 02/15/2025 
-- Design Name: 
-- Module Name:    TopLevel - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TopLevel is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           ADDRWRITE : in  STD_LOGIC_VECTOR (4 downto 0);
           ADDRREAD : in  STD_LOGIC_VECTOR (4 downto 0);
           WR : in  STD_LOGIC;
           RD : in  STD_LOGIC;
           NUMBERIN : in  STD_LOGIC_VECTOR (15 downto 0);
           NUMBEROUT : out  STD_LOGIC_VECTOR (15 downto 0);
           VALID : out  STD_LOGIC;
			  WrEn : out STD_LOGIC
			  );
end TopLevel;

architecture Stractural of TopLevel is

COMPONENT FSM IS 
	PORT(
			  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           AddrWrite : in  STD_LOGIC_VECTOR (4 downto 0);
           AddrRead : in  STD_LOGIC_VECTOR (4 downto 0);
			  addWriteOut : out  STD_LOGIC_VECTOR (4 downto 0);
           addReadOut : out STD_LOGIC_VECTOR (4 downto 0);
           Write : in  STD_LOGIC;
           Read : in  STD_LOGIC;
         --  NumberIN : in  STD_LOGIC_VECTOR (15 downto 0);
           NumberOUT : out  STD_LOGIC_VECTOR (15 downto 0);
           Valid : out  STD_LOGIC;
			  WriteEnable : out STD_LOGIC
			  );
	END COMPONENT;


--COMPONENT Memor_Block IS
---PORT (
   -- clka : IN STD_LOGIC;
--    wea : IN STD_LOGIC_vector(0 downto 0);
--    addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	 
	-- addrb : IN STD_LOGIC_VECTOR(4 DOWNTO 0);---one set for read and one for write
	-- doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  --);
--end component;
COMPONENT Memory_Block
  PORT (
    a : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dpra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    dpo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

signal Write_En :STD_LOGIC ;
signal addrd: std_logic_vector (4 downto 0);
signal addwr: std_logic_vector (4 downto 0);






begin


WrEn <= Write_En ;

--sel_addr <= addrd when Write_En = "0" else addwr;

U0: FSM PORT MAP(
CLK => CLK,
RST =>RST,
AddrWrite => ADDRWRITE,
AddrRead => ADDRREAD,
addWriteOut => addwr,
addReadOut => addrd,
Write => WR,
Read => RD,
Valid => VALID,
WriteEnable=>Write_En
--NumberIN => "0000000000000000"
);

U1 : Memory_Block
  PORT MAP (
    a => addwr,
    d => NUMBERIN,
    dpra => addrd,
    clk => CLK,
    we => Write_En,
    --spo => spo,
    dpo => NUMBEROUT
  );

--U1: Memor_Block PORT MAP(
--clka=>CLK,
--wea =>Write_En ,
--addra => sel_addr,
--dina =>  NumberIN,
---douta => NumberOUT
--addrb => addwr
--);



end Stractural;

