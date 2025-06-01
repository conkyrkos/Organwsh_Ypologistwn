--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:35:47 03/01/2025
-- Design Name:   
-- Module Name:   /home/ise/Saved_Games/Organ_Lab_1/TestBench.vhd
-- Project Name:  Organ_Lab_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TopLevel
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
 
ENTITY TestBench IS
END TestBench;
 
ARCHITECTURE behavior OF TestBench IS 
 s
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopLevel
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         ADDRWRITE : IN  std_logic_vector(4 downto 0);
         ADDRREAD : IN  std_logic_vector(4 downto 0);
         WR : IN  std_logic;
         RD : IN  std_logic;
         NUMBERIN : IN  std_logic_vector(15 downto 0);
         NUMBEROUT : OUT  std_logic_vector(15 downto 0);
         VALID : OUT  std_logic;
         WrEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal ADDRWRITE : std_logic_vector(4 downto 0) := (others => '0');
   signal ADDRREAD : std_logic_vector(4 downto 0) := (others => '0');
   signal WR : std_logic := '0';
   signal RD : std_logic := '0';
   signal NUMBERIN : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal NUMBEROUT : std_logic_vector(15 downto 0);
   signal VALID : std_logic;
   signal WrEn : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopLevel PORT MAP (
          CLK => CLK,
          RST => RST,
          ADDRWRITE => ADDRWRITE,
          ADDRREAD => ADDRREAD,
          WR => WR,
          RD => RD,
          NUMBERIN => NUMBERIN,
          NUMBEROUT => NUMBEROUT,
          VALID => VALID,
          WrEn => WrEn
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
   --Read test to determine if memory is correctly initialised

		RST<='1';
		wait for CLK_period*5;	
		RST<='0';


		ADDRREAD <="10101";
		RD <='1';
		WR <='0';
		wait for CLK_period*2;

		
--Write test on the 5th memory position of number 666 

		WR <='1';
		RD <='0';
		NUMBERIN <="0000001010011010";
		ADDRWRITE<="00101";
		wait for CLK_period*2;
		RST<='1';

--Read memory position 5 to determine if 666 was correctly saved
		
		
		wait for 100 ns;
		RST<='0';
		WR <='0';
		RD <='1';
		ADDRREAD <="00101";
		wait for CLK_period*2;

--Read/write test to determine if the program firstly reads the number in the given memory address and then writes, as the program requires
		
		WR <='1';
		RD <='1';
		ADDRREAD <="11111";
		NUMBERIN <="0000000011111010";
		ADDRWRITE<="10001";
		wait for CLK_period*2;
		
		WR <='1';
		RD <='1';
		ADDRREAD <="00001";
		NUMBERIN <="1010101010101010";
		ADDRWRITE<="00001";

--Reset to make sure the fsm returns to its "safe state" 

                RST <= '1';
     		wait for 100 ns;
      		RST <= '0';
      		wait for 100 ns;

--Final read test to determine if memory's bounds (address 0,31, and a random address in-between) is correctly initialised

		ADDRREAD <="10111";
		RD <='1';
		WR <='0';
		wait for CLK_period*2;


		ADDRREAD <="00000";
		RD <='1';
		WR <='0';
		wait for CLK_period*2;


		ADDRREAD <="11111";
		RD <='1';
		WR <='0';
		wait for CLK_period*2;
	

      
      -- Stop simulation
      wait;
   end process;
	END;

