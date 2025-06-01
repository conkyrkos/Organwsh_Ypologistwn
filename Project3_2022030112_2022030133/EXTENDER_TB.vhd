--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:58:22 03/25/2025
-- Design Name:   
-- Module Name:   /home/ise/xilinx_shared/LabratoryKFVAHVHAVJLKERFV/Labratory/EXTENDER_TB.vhd
-- Project Name:  Datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXTENDER
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
 
ENTITY EXTENDER_TB IS
END EXTENDER_TB;
 
ARCHITECTURE behavior OF EXTENDER_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXTENDER
    PORT(
         Instr : IN  std_logic_vector(15 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         ext_op : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(15 downto 0) := (others => '0');
   signal ext_op : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXTENDER PORT MAP (
          Instr => Instr,
          Immed => Immed,
          ext_op => ext_op
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
	  --zero fill
     instr <= "1111110000000000";
	  ext_op <= "00";
	  wait for 100 ns;
	  
	   --sign extend
     instr <= "1111110000000000";
	  ext_op <= "10";
	  wait for 100 ns;
	  
	   --zero fill and shift left by 2
     instr <= "1111110000000000";
	  ext_op <= "11";
	  wait for 100 ns;
	  
	   --sign extend and shift left by 2
     instr <= "1111110000000000";
	  ext_op <= "01";
	  wait for 100 ns;
	  

      -- insert stimulus here 

      wait;
   end process;

END;
