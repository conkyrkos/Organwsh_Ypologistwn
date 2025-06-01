----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:26 03/16/2025 
-- Design Name: 
-- Module Name:    IF_TOPLEVEL - Behavioral 
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

entity IF_TOPLEVEL is
    Port ( pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_sel : in  STD_LOGIC;
           pc_lden : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_TOPLEVEL;

architecture structural of IF_TOPLEVEL is

component muxx
Port ( pc_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_sel : in  STD_LOGIC;
           pc_signal : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_to_pc : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC
Port (     clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pc_ld_en : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Incrementor
 Port ( number : in  STD_LOGIC_VECTOR (31 downto 0);
           adder : in  STD_LOGIC_VECTOR (31 downto 0);
           outp : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component if_MEMOR
PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
  end component;
  
signal mux_to_pc_signal :STD_LOGIC_VECTOR (31 downto 0);
signal pc_to_adder_signal :STD_LOGIC_VECTOR (31 downto 0);
signal adder_to_immed_signal :STD_LOGIC_VECTOR (31 downto 0);
signal immed_to_mux_signal :STD_LOGIC_VECTOR (31 downto 0);
signal adder_to_mux_signal :STD_LOGIC_VECTOR (31 downto 0);

begin

----
meme: if_MEMOR port map(
a =>pc_to_adder_signal(11 DOWNTO 2),-----------check 32 to 10????
spo =>instr
);

p_c : PC PORT MAP(
clk=>clk,
rst=>rst,
pc_ld_en=>pc_lden,
input=>mux_to_pc_signal,
output=>pc_to_adder_signal
);


adder0: Incrementor Port map( --pc+4
number =>pc_to_adder_signal,
adder =>"00000000000000000000000000000100",--+4
outp =>adder_to_mux_signal
);

adder1: Incrementor Port map( --pc+4+immed
number =>adder_to_mux_signal,
adder =>pc_immed,
outp =>immed_to_mux_signal
);

mu:muxx port map(
pc_immed =>immed_to_mux_signal,
pc_sel =>pc_sel,
pc_signal =>adder_to_mux_signal,
mux_to_pc =>mux_to_pc_signal
);



end structural;

