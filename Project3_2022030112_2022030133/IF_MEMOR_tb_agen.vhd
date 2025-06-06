
--------------------------------------------------------------------------------
--
-- DIST MEM GEN Core - Address Generator
--
--------------------------------------------------------------------------------
--
-- (c) Copyright 2006_3010 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

--------------------------------------------------------------------------------
--
-- Filename: IF_MEMOR_tb_agen.vhd
--
-- Description:
--   Address Generator
--
--------------------------------------------------------------------------------
-- Author: IP Solutions Division
--
-- History: Sep 12, 2011 - First Release
--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
-- Library Declarations
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY work;
USE work.ALL;

ENTITY IF_MEMOR_TB_AGEN IS
  GENERIC (
    C_MAX_DEPTH : INTEGER :=  1024 ;
    RST_VALUE  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS=> '0');
    RST_INC  : INTEGER := 0);
  PORT (
    CLK         : IN STD_LOGIC;
    RST         : IN STD_LOGIC;
    EN          : IN STD_LOGIC;
    LOAD        :IN STD_LOGIC;
    LOAD_VALUE  : IN STD_LOGIC_VECTOR (31 DOWNTO 0)  := (OTHERS => '0');
    ADDR_OUT    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)   --OUTPUT VECTOR           
  );
END IF_MEMOR_TB_AGEN;

ARCHITECTURE BEHAVIORAL OF IF_MEMOR_TB_AGEN IS
  SIGNAL ADDR_TEMP : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS =>'0');
BEGIN
  ADDR_OUT <= ADDR_TEMP;
  PROCESS(CLK)
  BEGIN
    IF(RISING_EDGE(CLK)) THEN
      IF(RST='1') THEN
    	  ADDR_TEMP<= RST_VALUE + conv_std_logic_vector(RST_INC,32 ); 
      ELSE
        IF(EN='1') THEN
          IF(LOAD='1') THEN
	         ADDR_TEMP <=LOAD_VALUE;
	       ELSE
	         IF(ADDR_TEMP = C_MAX_DEPTH-1) THEN
         	  ADDR_TEMP<= RST_VALUE + conv_std_logic_vector(RST_INC,32 );
	         ELSE
	           ADDR_TEMP <= ADDR_TEMP + '1';
	         END IF;
	       END IF;
	     END IF;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE;
