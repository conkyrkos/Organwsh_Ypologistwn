--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:21:34 03/24/2025
-- Design Name:   
-- Module Name:   /home/ise/Desktop/Labratory/DAATAPATH_TB.vhd
-- Project Name:  Datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DAATAPATH_TB IS
END DAATAPATH_TB;
 
ARCHITECTURE behavior OF DAATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         Instr : OUT  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         SELECTOR : IN  std_logic;
         Opt_Ext : IN  std_logic_vector(1 downto 0);
         ALU_Bin_Sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         ZERO_ALU_out : OUT  std_logic;
         pc_sel : IN  std_logic;
         pc_lden : IN  std_logic;
         MEM_WrEn : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';
   signal SELECTOR : std_logic := '0';
   signal Opt_Ext : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_Sel : std_logic := '0';
   signal ALU_Func : std_logic_vector(3 downto 0) := (others => '0');
   signal pc_sel : std_logic := '0';
   signal pc_lden : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';

 	--Outputs
   signal ZERO_ALU_out : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          CLK => CLK,
          Reset => Reset,
          SELECTOR => SELECTOR,
          Opt_Ext => Opt_Ext,
          ALU_Bin_Sel => ALU_Bin_Sel,
          ALU_Func => ALU_Func,
          ZERO_ALU_out => ZERO_ALU_out,
          pc_sel => pc_sel,
          pc_lden => pc_lden,
          MEM_WrEn => MEM_WrEn
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

 -- Ενεργοποίηση reset για αρχικοποίηση
        Reset <= '1';
        wait for 30 ns;
        Reset <= '0';
        wait for 20 ns;


 ----------------------------------------------------------------
      --  Instr         <= "00111100000000100000000000000000";  -- LUI $2, 0x0000 (παράδειγμα)
        RF_WrEn       <= '1';
        RF_WrData_sel <= '0';         -- Επιλογή ALU ως πηγή εγγραφής
        RF_B_sel      <= '0';         -- Επιλογή για immediate
        Opt_Ext       <= "10";        -- ZERO FILL + SHIFT LEFT (μετατόπιση κατά 16)
        ALU_Bin_Sel   <= '0';
		   ALU_Func      <= "0000";       -- Απλή πρόσθεση (το shift γίνεται από τον extender)
        pc_sel        <= '0';          -- PC + 4
        pc_lden       <= '0';
        MEM_WrEn      <= '0';
		  SELECTOR <= '0';
        wait for CLK_period*2;
			RF_WrEn       <= '0';
			RF_B_sel      <= '1'; 
		--Instr <= "10000000001000100010000000110000";
	
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				--INCREASE PC+=4 AND WE WRITE'0' FOR R 1 FOR IMMED
				PC_SEL <= '0';
				PC_LD_EN <='1';--WRITE
				--R=> we want ALU=> RF_WR<=0 IF MEM => RF_WR=1
				RF_WR_SEL <='0';
				--ALU SO WE CHOOSE [RT]
				RF_B_SEL<='0'; 	
				--WRITE TO [rd]
				RF_WR_EN<='1'; 	
				--alu b<= rf_b so alu's mux =>0 => alu bin_sel=0
				ALU_BIN_SEL<='0';
				ALU_Func <= al_func;
	
      wait;
   end process;

END;
