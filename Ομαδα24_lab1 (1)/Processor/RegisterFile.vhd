----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:53 03/12/2025 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
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

entity RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end RegisterFile;

architecture Structural of RegisterFile is

Component Decoder

 Port ( awr : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
			  
End component;

Component MUX32   Port ( in0 : in  STD_LOGIC_VECTOR (31 downto 0);
			  in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           in2 : in  STD_LOGIC_VECTOR (31 downto 0);
           in3 : in  STD_LOGIC_VECTOR (31 downto 0);
           in4 : in  STD_LOGIC_VECTOR (31 downto 0);
           in5 : in  STD_LOGIC_VECTOR (31 downto 0);
           in6 : in  STD_LOGIC_VECTOR (31 downto 0);
           in7 : in  STD_LOGIC_VECTOR (31 downto 0);
           in8 : in  STD_LOGIC_VECTOR (31 downto 0);
           in9 : in  STD_LOGIC_VECTOR (31 downto 0);
           in10 : in  STD_LOGIC_VECTOR (31 downto 0);
           in11 : in  STD_LOGIC_VECTOR (31 downto 0);
           in12 : in  STD_LOGIC_VECTOR (31 downto 0);
           in13 : in  STD_LOGIC_VECTOR (31 downto 0);
           in14 : in  STD_LOGIC_VECTOR (31 downto 0);
           in15 : in  STD_LOGIC_VECTOR (31 downto 0);
           in16 : in  STD_LOGIC_VECTOR (31 downto 0);
           in17 : in  STD_LOGIC_VECTOR (31 downto 0);
           in18 : in  STD_LOGIC_VECTOR (31 downto 0);
           in19 : in  STD_LOGIC_VECTOR (31 downto 0);
           in20 : in  STD_LOGIC_VECTOR (31 downto 0);
           in21 : in  STD_LOGIC_VECTOR (31 downto 0);
           in22 : in  STD_LOGIC_VECTOR (31 downto 0);
           in23 : in  STD_LOGIC_VECTOR (31 downto 0);
           in24 : in  STD_LOGIC_VECTOR (31 downto 0);
           in25 : in  STD_LOGIC_VECTOR (31 downto 0);
           in26 : in  STD_LOGIC_VECTOR (31 downto 0);
           in27 : in  STD_LOGIC_VECTOR (31 downto 0);
           in28 : in  STD_LOGIC_VECTOR (31 downto 0);
           in29 : in  STD_LOGIC_VECTOR (31 downto 0);
           in30 : in  STD_LOGIC_VECTOR (31 downto 0);
           in31 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
			  
End component;

Component RegisterMOdule
 Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
			  
End component;
signal dec_to_Reg : STD_LOGIC_VECTOR (31 downto 0);
signal  And_to_Reg :STD_LOGIC_VECTOR (31 downto 0);
type TypeRegisters_Bus is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
signal Register_Out: TypeRegisters_Bus;

begin
U1 : Decoder Port Map(
awr=>Awr,
output => dec_to_Reg);

And_to_Reg(0) <= (dec_to_Reg(0) AND WrEn);
And_to_Reg(1) <= (dec_to_Reg(1) AND WrEn);
And_to_Reg(2) <= (dec_to_Reg(2) AND WrEn);
And_to_Reg(3) <= (dec_to_Reg(3) AND WrEn);
And_to_Reg(4) <= (dec_to_Reg(4) AND WrEn);
And_to_Reg(5) <= (dec_to_Reg(5) AND WrEn);
And_to_Reg(6) <= (dec_to_Reg(6) AND WrEn);
And_to_Reg(7) <= (dec_to_Reg(7) AND WrEn);
And_to_Reg(8) <= (dec_to_Reg(8) AND WrEn);
And_to_Reg(9) <= (dec_to_Reg(9) AND WrEn);
And_to_Reg(10) <= (dec_to_Reg(10) AND WrEn);
And_to_Reg(11) <= (dec_to_Reg(11) AND WrEn);
And_to_Reg(12) <= (dec_to_Reg(12) AND WrEn);
And_to_Reg(13) <= (dec_to_Reg(13) AND WrEn);
And_to_Reg(14) <= (dec_to_Reg(14) AND WrEn);
And_to_Reg(15) <= (dec_to_Reg(15) AND WrEn);
And_to_Reg(16) <= (dec_to_Reg(16) AND WrEn);
And_to_Reg(17) <= (dec_to_Reg(17) AND WrEn);
And_to_Reg(18) <= (dec_to_Reg(18) AND WrEn);
And_to_Reg(19) <= (dec_to_Reg(19) AND WrEn);
And_to_Reg(20) <= (dec_to_Reg(20) AND WrEn);
And_to_Reg(21) <= (dec_to_Reg(21) AND WrEn);
And_to_Reg(22) <= (dec_to_Reg(22) AND WrEn);
And_to_Reg(23) <= (dec_to_Reg(23) AND WrEn);
And_to_Reg(24) <= (dec_to_Reg(24) AND WrEn);
And_to_Reg(25) <= (dec_to_Reg(25) AND WrEn);
And_to_Reg(26) <= (dec_to_Reg(26) AND WrEn);
And_to_Reg(27) <= (dec_to_Reg(27) AND WrEn);
And_to_Reg(28) <= (dec_to_Reg(28) AND WrEn);
And_to_Reg(29) <= (dec_to_Reg(29) AND WrEn);
And_to_Reg(30) <= (dec_to_Reg(30) AND WrEn);
And_to_Reg(31) <= (dec_to_Reg(31) AND WrEn);


Register0: RegisterMOdule port map(
		CLK => Clk,
		WE => And_to_Reg(0),
		Data => Din,
		DOUT => Register_Out(0));

GEN_REGISTERS: for i in 1 to 31 generate
begin
    Register_inst: RegisterMOdule port map(
        CLK => Clk,
        WE => And_to_Reg(i),
        Data => Din,
        DOUT => Register_Out(i)
    );
end generate GEN_REGISTERS;

Mux1: MUX32 port map(
Ard=> Ard1,
in0 => Register_Out(0),
in1 => Register_Out(1),
in2 => Register_Out(2),
in3 => Register_Out(3),
in4 => Register_Out(4),
in5 => Register_Out(5),
in6 => Register_Out(6),
in7 => Register_Out(7),
in8 => Register_Out(8),
in9 => Register_Out(9),
in10 => Register_Out(10),
in11 => Register_Out(11),
in12 => Register_Out(12),
in13 => Register_Out(13),
in14 => Register_Out(14),
in15 => Register_Out(15),
in16 => Register_Out(16),
in17 => Register_Out(17),
in18 => Register_Out(18),
in19 => Register_Out(19),
in20 => Register_Out(20),
in21 => Register_Out(21),
in22 => Register_Out(22),
in23 => Register_Out(23),
in24 => Register_Out(24),
in25 => Register_Out(25),
in26 => Register_Out(26),
in27 => Register_Out(27),
in28 => Register_Out(28),
in29 => Register_Out(29),
in30 => Register_Out(30),
in31 => Register_Out(31),
mux_out => Dout1);


mux2: MUX32 port map(
Ard=> Ard2,
in0 => Register_Out(0),
in1 => Register_Out(1),
in2 => Register_Out(2),
in3 => Register_Out(3),
in4 => Register_Out(4),
in5 => Register_Out(5),
in6 => Register_Out(6),
in7 => Register_Out(7),
in8 => Register_Out(8),
in9 => Register_Out(9),
in10 => Register_Out(10),
in11 => Register_Out(11),
in12 => Register_Out(12),
in13 => Register_Out(13),
in14 => Register_Out(14),
in15 => Register_Out(15),
in16 => Register_Out(16),
in17 => Register_Out(17),
in18 => Register_Out(18),
in19 => Register_Out(19),
in20 => Register_Out(20),
in21 => Register_Out(21),
in22 => Register_Out(22),
in23 => Register_Out(23),
in24 => Register_Out(24),
in25 => Register_Out(25),
in26 => Register_Out(26),
in27 => Register_Out(27),
in28 => Register_Out(28),
in29 => Register_Out(29),
in30 => Register_Out(30),
in31 => Register_Out(31),
mux_out => Dout2);

end Structural;

