--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:12:57 03/19/2025
-- Design Name:   
-- Module Name:   /home/ise/Desktop/Labratory/RegisterFileTB.vhd
-- Project Name:  Datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegistFile
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegisterFileTB IS
END RegisterFileTB;
 
ARCHITECTURE behavior OF RegisterFileTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegistFile
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
			 Reset : IN std_logic 
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
	 signal Reset : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0):= (others => '0');
   signal Dout2 : std_logic_vector(31 downto 0):= (others => '0');
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegistFile PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
			  Reset => Reset
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Reset <= '1';
      wait for 10		ns;	
		
		--read from empty 
		Reset <= '0';
      wait for Clk_period*10;
		
		Ard1 <= "00000";
		Ard2 <= "00000";
		
		--write 1s to register 1 
		
		wait for 100 ns;
		WrEn <= '1';
		Awr <= "00001";
		Din <= x"ffffffff";
		Ard1 <= "00000";
		Ard2 <= "00000";
		
		--read register 1 content and output to dout 1 and 2
		
		wait for 100 ns;
		
		WrEn <= '0';
		Awr <= "00000";
		Ard1 <= "00001";
		Ard2 <= "00001";
		
		--try to write with 0 wr en fail
		
		wait for 100 ns;
		WrEn <= '0';
		Awr <= "00001";
		Din <= x"00000001";
		Ard1 <= "00000";
		Ard2 <= "00000";
		
		--read register 1 content and output to dout 1
		
		wait for 100 ns;
		
		WrEn <= '0';
		Awr <= "00000";
		Ard1 <= "00001";
		Ard2 <= "00000";
		
		
		--try to write to register 0
		
		wait for 100 ns;
		WrEn <= '1';
		Awr <= "00000";
		Din <= x"00000111";
		Ard1 <= "00000";
		Ard2 <= "00000";
		
		--read register 0 content and output to dout 2
		
		wait for 100 ns;
		
		WrEn <= '0';
		Awr <= "00000";
		Ard1 <= "00001";
		Ard2 <= "00000";
		
		
		
		
					

   wait;
   end process;

END;
