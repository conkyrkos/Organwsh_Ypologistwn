----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:51:48 03/21/2025 
-- Design Name: 
-- Module Name:    ControlPath - Behavioral 
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

entity ControlPath is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           INSTR : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_ZERO : in  STD_LOGIC;
           
			  ALU_FUNC : out  STD_LOGIC_VECTOR (3 downto 0);  
           ALU_BIN_SEL: OUT STD_LOGIC;
			  
			  SEL_BYTE: out  STD_LOGIC;
			 -- BYTE: OUT STD_LOGIC_VECTOR (1 downto 0);
			  MEM_WrEn : out  STD_LOGIC;
			  
			  RF_WR_EN : out  STD_LOGIC;
           RF_B_SEL : out  STD_LOGIC;
           RF_WR_SEL : out  STD_LOGIC;
			  Opt_Ext : out STD_LOGIC_VECTOR (1 downto 0);
           
			  PC_SEL : out  STD_LOGIC;
           PC_LD_EN : out  STD_LOGIC);
end ControlPath;

architecture Behavioral of ControlPath is

signal al_func: STD_LOGIC_VECTOR(3 downto 0);
signal op_code: STD_LOGIC_VECTOR(5 downto 0);

begin
al_func <= Instr(3 downto 0);
op_code <= Instr(31 downto 26);

process(RESET,ALU_ZERO,al_func,op_code)---zero for beq bne
begin

----NO SHIFT LEFT   |  2 SHIFT LEFT EXTENDER DEC
----------------------------------------
----ZERO FILL  \  00    |ZERO FILL 	\   11
----SIGN EXTEND\  10    |SIGN EXTEND \  01


-- PC_SEL για τον  καταχωρητή PC

-- 0: PC + 4
-- 1: PC + 4 + immediate


-- RF_WrData_sel δεδομένων για εγγραφή στο RF
-- 0: ALU
-- 1: MEM


-- RF_B_sel για τον προορισμό εγγραφής στο RFb
-- 0: input (15-11)
-- 1: (20-16)


-- ALU_BIN_sel για την είσοδο B της ALU
-- 0: RF_B
-- 1: Immediate

-- --------------------------------------------------------
-- | 6-bits | 5-bits | 5-bits | 5-bits | 5-bits | 6-bits |
-- --------------------------------------------------------
-- | Opcode |  Rs    |  Rd    |  Rt    | not-used|  Func  |
-- --------------------------------------------------------

-- --------------------------------------------------------
-- | 6-bits | 5-bits | 5-bits | 16-bits |
-- --------------------------------------------------------
-- | Opcode |  Rs    |  Rd    | Immediate |
-- --------------------------------------------------------


-- Περιγραφή θέσεων:

-- 1. Opcode: Από bit 31 μέχρι bit 26 (6 bits)
-- 2. Rs: Από bit 25 μέχρι bit 21 (5 bits)
-- 3. Rd: Από bit 20 μέχρι bit 16 (5 bits)
-- 4. Rt: Από bit 15 μέχρι bit 11 (5 bits)
-- 5. not-used: Από bit 10 μέχρι bit 6 (5 bits)
-- 6. Func: Από bit 5 μέχρι bit 0 (6 bits)

-- 1. Opcode: Από bit 31 μέχρι bit 26 (6 bits)
-- 2. Rs: Από bit 25 μέχρι bit 21 (5 bits)
-- 3. Rd: Από bit 20 μέχρι bit 16 (5 bits)
-- 4. Immediate: Από bit 15 μέχρι bit 0 (16 bits)


if (RESET ='1') then 
ALU_FUNC<="0000";
ALU_BIN_SEL <='0';
SEL_BYTE<='0';
MEM_WrEn <='0';
RF_WR_EN <='0';
RF_B_SEL <='0';
RF_WR_SEL <='0';
Opt_Ext <="00";       
PC_SEL <='0';
PC_LD_EN <='0';
else
case op_code is

--R type 100000  I TYPE 11.../01......

--R TYPE 
		when "100000" =>
				--alu so we dont need byte and mem so 
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
				
	--  li Load Immediate	RF[rd] <-SignExtend(Imm)	
	
		when "111000"=>
		--we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
		--Add with register 0
		ALU_Func <= "0000";
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE PC REG
		PC_LD_EN<='1';
		--SIGN EXTEND
		Opt_Ext <="10"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';	
		--I type
		RF_B_SEL<='1';
		--write to rd
		RF_WR_EN<='1';
		--ALU=>IMMED
		ALU_BIN_SEL<='1';
		
		
		--lui RF[rd]<-Imm<< 16 (zero-fill) 
		--RF[rd]<-RF[r0]+(Imm<< 16 (zero-fill))
		when "111001"=>
		--we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
		ALU_Func <= "0000";
		--PC+4 NOT IMMED
		PC_SEL<='0';	
		--ENABLE  WRITE PC REG 
		PC_LD_EN<='1';
		--zero+shift
		Opt_Ext <="11"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  RD=20-16=>RF_B_SEL =1 
		RF_B_SEL<='1';
		RF_WR_EN<='1';
		--ALU=>IMMED SELECTION
		ALU_BIN_SEL<='1';
		


      --addi[rd] <- RF[rs] + SignExtend(Imm)
		when "110000"=>
			
		--we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
		ALU_Func <= "0000";
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--sign extend
		Opt_Ext <="10"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='1';
		--ALU=>IMMED 
		ALU_BIN_SEL<='1';
			

		--andi RF[rd] <- RF[rs] & ZeroFill(Imm)
		when "110010"=>
				
		--we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
	   MEM_WrEn <='0';
		--and
		ALU_Func <= "0010";
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--ZERO FILL 
		Opt_Ext <="00"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='1';
		--ALU=>IMMED SO ALU BIN SIGNAL GONNA BE ON TOP 1
		ALU_BIN_SEL<='1';
			
			
		--ori OR IMMEDIATE RF[rd] <- RF[rs] & ZeroFill(Imm)
		when "110011"=>
			
		--we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
		--OR
		ALU_Func <= "0011";
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--ZERO FILL 
		Opt_Ext <="00"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='1';
		--ALU=>IMMED
		ALU_BIN_SEL<='1';

		--BRUNCH PC <- PC + 4 + (SignExtend(Imm) << 2) 
		when "111111"=>
			
	   --we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
			
		ALU_Func <= "0000";
		--PC + 4 + IMMED
		PC_SEL<='1';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--Sign extend+ SHIFT FOR 2
		Opt_Ext <="01"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='0';
		--DO NOT COUNT ALU OUT
		ALU_BIN_SEL<='0';
		
		
		
		--beq if (RF[rs] == RF[rd])
		-- PC <- PC + 4 + (SignExtend(Imm) << 2) else PC <- PC + 4 
		when "010000"=>
		
		--we dont need byte(SW,SB) and mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
				
		--sign extend+ SHIFT FOR 2
		Opt_Ext <="01"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE (i TYPE)
		RF_B_SEL<='1';
		RF_WR_EN<='0';
		--ALU=>IMMED 
		ALU_BIN_SEL<='0';
		--SUB 
		ALU_Func <= "0001";
		IF (ALU_ZERO='1') then 
			PC_SEL<='1';---PC+4+SHIFTED AND EXTENDED IMMED
		ELSE
		PC_SEL<='0';----PC+4
		END IF;
		--WRITE ENABLE PC REGISTER
		PC_LD_EN<='1';
	
			
		-- bne    if (RF[rs] != RF[rd])
		--PC  PC + 4 + (SignExtend(Imm) << 2) else PC <=PC + 4 
		when "010001"=>
		SEL_BYTE<='0';
		MEM_WrEn <='0';
			
		--sign extend+ SHIFT FOR 2
		Opt_Ext <="01"; 
		--TAKE ALU's OUT
		RF_WR_SEL<='0';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='0';
		--ALU=>IMMED SO ALU BIN SIGNAL GONNA BE ON TOP 1
		ALU_BIN_SEL<='0';
		--SUB 
		ALU_Func <= "0001";
		IF (ALU_ZERO='1') then 
			PC_SEL<='0';
		ELSE
		PC_SEL<='1';
		END IF;
		--WRITE ENABLE PC REGISTER
		PC_LD_EN<='1';


		--lb    RF[rd] <- ZeroFill(31 downto 8) & MEM[RF[rs] + SignExtend(Imm)](7 downto 0) 
		when "000011"=>
		
		--ADD IMMED
		ALU_BIN_SEL<='1'; 
		--ADDITION
		ALU_Func <= "0000";
		--read from memory not wrtite
		MEM_WrEn <='0';
		--LOAD BYTE
		SEL_BYTE<='1';
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--sign extend
		Opt_Ext <="10"; 
		--TAKE MEM's OUT
		RF_WR_SEL<='1';		
		--IMMED  RS=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='1';
		--ALU=>IMMED 
		ALU_BIN_SEL<='1';



      --lw RF[rd] <- MEM[RF[rs] + SignExtend(Imm)]
		when "001111"=>
	   --we dont need byte(SW,SB) and WRITE mem so 
		SEL_BYTE<='0';
		MEM_WrEn <='0';
		
		--ADDITION
		ALU_Func <= "0000";
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--sign extend
		Opt_Ext <="10"; 
		--TAKE MEM's OUT
		RF_WR_SEL<='1';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		RF_WR_EN<='1';
		--ALU=>IMMED SO ALU BIN SIGNAL GONNA BE ON TOP 1
		ALU_BIN_SEL<='1';


		--sw MEM[RF[rs] + SignExtend(Imm)] <-RF[rd]
		when "011111"=>
		--PC+4 NOT IMMED
		PC_SEL<='0';
		--ENABLE WRITING TO PC REG
		PC_LD_EN<='1';
		--sign extend
		Opt_Ext <="10"; 
		--TAKE MEM's OUT
		RF_WR_SEL<='1';		
		--IMMED  Rd=20-16=>RF_B_SEL =1 AND WE WRITE
		RF_B_SEL<='1';
		--WE DONT WRITE ON REG BUT ON MEM
		RF_WR_EN<='0';
		--ALU=>IMMED
		ALU_BIN_SEL<='1';
		ALU_Func <= "0000";
		SEL_BYTE<='0';
		--WRITE TO MEMORY
		MEM_WrEn <='1';	
		
		WHEN OTHERS=>
		
	ALU_FUNC<="0000";
	ALU_BIN_SEL <='0';
	SEL_BYTE<='0';
	MEM_WrEn <='0';
	RF_WR_EN <='0';
	RF_B_SEL <='0';
	RF_WR_SEL <='0';
	Opt_Ext <="00";       
	PC_SEL <='0';
	PC_LD_EN <='0';
	
end case;
end if;
end process;



end Behavioral;

