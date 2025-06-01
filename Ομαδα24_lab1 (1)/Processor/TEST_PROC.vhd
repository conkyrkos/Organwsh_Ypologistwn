--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:08:01 03/24/2025
-- Design Name:   
-- Module Name:   /home/ise/Desktop/Labratory/TEST_PROC.vhd
-- Project Name:  Datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP_TOP_LEVEL
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
 
ENTITY TEST_PROC IS
END TEST_PROC;
 
ARCHITECTURE behavior OF TEST_PROC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP_TOP_LEVEL
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         CARRY_OUT : OUT  std_logic;
         OVF : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal CARRY_OUT : std_logic;
   signal OVF : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP_TOP_LEVEL PORT MAP (
          CLK => CLK,
          RESET => RESET,
          CARRY_OUT => CARRY_OUT,
          OVF => OVF
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
--	wait for 5 ns;
RESET <='1';
      wait for CLK_period*2;
RESET <='0';
      wait;
   end process;

END;
