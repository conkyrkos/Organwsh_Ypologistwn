----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:52:57 03/12/2025 
-- Design Name: 
-- Module Name:    MUX1 - Behavioral 
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

entity MUX32 is

    Port ( in0 : in  STD_LOGIC_VECTOR (31 downto 0);
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
end MUX32;

architecture Behavioral of MUX32 is

begin

process(Ard,in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11, in12, in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31)

	begin
	
	--wait until Ard' event;

	if (Ard = "00000") then
	 mux_out <= in0;
	 
	elsif (Ard = "00001") then
	 mux_out <= in1;
	 
	elsif (Ard = "00010") then
	 mux_out <= in2;
	 
	elsif (Ard = "00011") then
	 mux_out <= in3;
	 
	elsif (Ard = "00100") then
	 mux_out <= in4;
	 
	elsif (Ard = "00101") then
	 mux_out <= in5;
	 
	elsif (Ard = "00110") then
	 mux_out <= in6;
	 
	elsif (Ard = "00111") then
	 mux_out <= in7;
	 
	elsif (Ard = "01000") then
	 mux_out <= in8;
	 
	elsif (Ard = "01001") then
	 mux_out <= in9;
	 
	elsif (Ard = "01010") then
	 mux_out <= in10;
	 
	elsif (Ard = "01011") then
	 mux_out <= in11;
	 
	elsif (Ard = "01100") then
	 mux_out <= in12;
	 
	elsif (Ard = "01101") then
	 mux_out <= in13;
	 
	elsif (Ard = "01110") then
	 mux_out <= in14;
	 
	elsif (Ard = "01111") then
	 mux_out <= in15;
	 
	elsif (Ard = "10000") then
	 mux_out <= in16;
	 
	elsif (Ard = "10001") then
	 mux_out <= in17;
	 
	elsif (Ard = "10010") then
	 mux_out <= in18;
	 
	elsif (Ard = "10011") then
	 mux_out <= in19;
	 
	elsif (Ard = "10100") then
	 mux_out <= in20;
	 
	elsif (Ard = "10101") then
	 mux_out <= in21;
	 
	elsif (Ard = "10110") then
	 mux_out <= in22;
	 
	elsif (Ard = "10111") then
	 mux_out <= in23;
	 
	elsif (Ard = "11000") then
	 mux_out <= in24;
	 
	elsif (Ard = "11001") then
	 mux_out <= in25;
	 
	elsif (Ard = "11010") then
	 mux_out <= in26;
	 
	elsif (Ard = "11011") then
	 mux_out <= in27;
	 
	elsif (Ard = "11100") then
	 mux_out <= in28;
	
	elsif (Ard = "11101") then
	 mux_out <= in29;
	 
	elsif (Ard = "11110") then
	 mux_out <= in30;
	 
	elsif (Ard = "11111") then
	 mux_out <= in31;
	 
end if;

end process;
	 

end Behavioral;

