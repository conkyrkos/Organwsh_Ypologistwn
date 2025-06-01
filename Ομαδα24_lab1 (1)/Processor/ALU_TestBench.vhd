--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:14:54 03/11/2025
-- Design Name:   
-- Module Name:   /home/ise/Lab_1/ALU_TestBench.vhd
-- Project Name:  Lab_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 use IEEE.NUMERIC_STD.ALL;

use IEEE.STD_LOGIC_SIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

 
ENTITY ALU_TestBench IS
END ALU_TestBench;
 
ARCHITECTURE behavior OF ALU_TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
  
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 40 ns;	
		
		Op <= "0000";
A <= std_logic_vector(to_signed(1, 32));		
B <= std_logic_vector(to_signed(21, 32));
		wait for 50 ns;
		
	 -- Subtraction
        Op <= "0001";  
        A  <= "00000000000000000000000000010000";  -- 16 (0x10)
        B  <= "00000000000000000000000000010101";  -- 21 (0x15)
        wait for 50 ns;

        -- Overflow at Add
        Op <= "0000";  
        A  <= "01111111111111111111111111111111";  -- 2147483647 (0x7FFFFFFF)
        B  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        wait for 50 ns;

        -- Overflow & Cout at Add
        Op <= "0000";  
        A  <= "10000000000000000000000000000000";  -- -2147483648 (0x80000000)
        B  <= "11111111111111111111111111111111";  -- -1 (0xFFFFFFFF)
        wait for 50 ns;

        -- Subtraction
        Op <= "0001";  
        A  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        B  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        wait for 50 ns;

        -- Overflow at Subtraction
        Op <= "0001";  
        A  <= "01111111111111111111111111111111";  -- 2147483647 (0x7FFFFFFF)
        B  <= "11111111111111111111111111111111";  -- -1 (0xFFFFFFFF)
        wait for 50 ns;

        -- Carry Out at Subtraction
        Op <= "0001";  
        A  <= "11111111111111111111111111111110";  -- -2 (0xFFFFFFFE)
        B  <= "11111111111111111111111111111111";  -- -1 (0xFFFFFFFF)
        wait for 50 ns;

        -- Logic AND
        Op  <= "0010";
        A  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        B  <= "00000000000000000000000000000010";  -- 2 (0x00000002)
        wait for 50 ns;

        -- Logic OR
        Op <= "0011";
        A  <= "00000000000000000000000000000011";  -- 3 (0x00000011)
        B  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        wait for 50 ns;

        -- Arithmetic Right Shift
        Op <= "1000";
        A  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        B  <= "00000000000000000000000000000000";  -- 0 (0x00000000)
        wait for 50 ns;

        -- Logical Right Shift
        Op <= "1001";
        A  <= "00000000000000000000000000000011";  -- 3 (0x00000011)
        B  <= "00000000000000000000000000000000";  -- 0 (0x00000000)
        wait for 50 ns;

        -- Logical Left Shift
        Op <= "1010";
        A  <= "00000000000000000000000000000001";  -- 1 (0x00000001)
        B  <= "00000000000000000000000000000000";  -- 0 (0x00000000)
        wait for 50 ns;

        -- Rotate Left
        Op <= "1100";
        A  <= "00000000000000000000000001111111";  -- 127 (0x7F)
        B  <= "00000000000000000000000000000000";  -- 0 (0x00000000)
        wait for 50 ns;

        -- Rotate Right
        Op <= "1101";
        A  <= "00000000000000000000000000001111";  -- 15 (0x0F)
        B  <= "00000000000000000000000000001011";  -- 11 (0x0B)
        wait for 50 ns;

      wait;
   end process;

END;
