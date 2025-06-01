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
           PC_LD_EN : out  STD_LOGIC:='0';
				RegRFA_WE: out  STD_LOGIC;
				RegRFB_WE: out  STD_LOGIC;
				RegALU_WE	: out  STD_LOGIC;
				RegIMMED_WE: out  STD_LOGIC;
				RegInstr_WE: out  STD_LOGIC:='0';
				RegWorB_WE: out  STD_LOGIC
			  );
end ControlPath;

architecture Behavioral of ControlPath is

signal al_func: STD_LOGIC_VECTOR(3 downto 0);
signal op_code: STD_LOGIC_VECTOR(5 downto 0);
type state is (IF_STAGE,DEC_STAGE,EXEC_STAGE,Write_back_Stage,b_stage,bne_stage,beq_stage,memory_stage);
signal s : state :=IF_STAGE;

begin

al_func <= Instr(3 downto 0);
op_code <= Instr(31 downto 26);

process(CLK,RESET,ALU_ZERO,al_func,op_code,Instr)---zero for beq bne
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

if(Reset='1') then 
s <= IF_STAGE;
RegInstr_WE<='1';

elsIF(RISING_EDGE(CLK)) THEN

--		RegInstr_WE<='1';
--		RegRFA_WE<='1';
--		RegRFB_WE<='1';
--		RegALU_WE<='1';
--		RegIMMED_WE<='1';
--		RegWorB_WE<='1';
		
case s is
	
		when if_stage =>
		
		--Register Write enables
		
		RegInstr_WE<='1';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='0';
		RegIMMED_WE<='0';
		RegWorB_WE<='0';
		

			SEL_BYTE<='0';
			MEM_WrEn <='0';
			ALU_Func <= "0000";
			--PC_SEL<='0';
			PC_LD_EN<='0';
			Opt_Ext <="10"; 
			RF_WR_SEL<='0';	
			RF_B_SEL<='0';
			RF_WR_EN<='0';
			ALU_BIN_SEL<='0';
			s <=DEC_STAGE;

	when DEC_STAGE => 
	
	--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='1';
		RegRFB_WE<='1';
		RegALU_WE<='0';
		RegIMMED_WE<='1';
		RegWorB_WE<='0';
		
		CASE(op_code) is
		
			---R TYPE ALU
			when"100000" =>
			
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="00"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='0';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='0';
				s <=EXEC_STAGE;
				
		-------------load immediate------------
		
			when	"111000" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="10"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				s <=EXEC_STAGE;
				
				---LUI
				
			when	"111001" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="11"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				s <=EXEC_STAGE;	
				
				----addi
				
			when	"110000" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="10"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				s <=EXEC_STAGE;
			
			---andi
			
			when	"110010" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="00"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				s <=EXEC_STAGE;
				
			---ori
			
			when	"110011" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="00"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				s <=EXEC_STAGE;
				
				---brunch
				
			when	"111111" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='1';
				PC_LD_EN<='1';
				Opt_Ext <="01"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='0';
				s <=b_stage;
				
	---branch eq
	
			when	"010000" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="01"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='0';
				s <=EXEC_STAGE;		
				
	---branch not eq
	
			when	"010001" =>
		
				SEL_BYTE<='0';
				MEM_WrEn <='0';
				PC_SEL<='0';
				PC_LD_EN<='0';
				Opt_Ext <="01"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='0';
				s <=EXEC_STAGE;	
				
				-- load word
				
			when "001111" =>
				MEM_WrEn  <= '0';
				SEL_BYTE <= '0';
				PC_SEL <= '0';
				PC_LD_EN <= '0';
				RF_WR_EN <= '0';
				RF_WR_SEL <= '1';
				RF_B_SEL <= '1';
				Opt_Ext <= "10";
				ALU_Func <= "0000";
				ALU_BIN_SEL <= '1';
				s <=EXEC_STAGE;	
						
				-- store word
			when "011111" =>
				MEM_WrEn  <= '0';
				SEL_BYTE <= '0';
				PC_SEL <= '0';
				PC_LD_EN <= '0';
				RF_WR_EN <= '0';
				RF_WR_SEL <= '0';
				RF_B_SEL <= '1';
				Opt_Ext <= "10";
				ALU_Func <= "0000";
				ALU_BIN_SEL <= '1';
				s <=EXEC_STAGE;	

				-- load byte
				
			when "000011" =>
			
				MEM_WrEn  <= '0';
				SEL_BYTE <= '0';
				PC_SEL <= '0';
				PC_LD_EN <= '0';
				RF_WR_EN <= '0';
				RF_WR_SEL <= '1';
				RF_B_SEL <= '1';
				Opt_Ext <= "10";
				ALU_Func <= "0000";
				ALU_BIN_SEL <= '1';
				s <=EXEC_STAGE;	

			when others =>
			
		end case;
		
	when EXEC_STAGE =>
	
	--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='1';
		RegIMMED_WE<='0';
		RegWorB_WE<='0';

			SEL_BYTE     <= '0';
			MEM_WrEn     <= '0';
			PC_SEL       <= '0';
			PC_LD_EN     <= '0';
			Opt_Ext      <= "00";
			RF_WR_SEL    <= '0';
			RF_B_SEL     <= '0';
			RF_WR_EN     <= '0';
			ALU_BIN_SEL  <= '0';
  
		case op_code is

			 -- (R-type) 
			 when "100000" =>
				ALU_Func    <= al_func;
				PC_LD_EN    <= '1';
				ALU_BIN_SEL <= '0';     -- 2η είσοδος ALU από RF_B
				RF_WR_EN    <= '1';  
				s           <= WRITE_BACK_STAGE;

			 -- LI (Immediate)
			 when "111000" =>
				PC_LD_EN    <= '1';
				Opt_Ext     <= "10";    
				RF_B_SEL    <= '0';     
				RF_WR_EN    <= '1';     
				ALU_Func    <= "0000";  
				ALU_BIN_SEL <= '1';     
				s           <= WRITE_BACK_STAGE;
			-- LuI (Immediate)
			 when "111001" =>
				PC_LD_EN    <= '1';
				Opt_Ext     <= "11";    
				RF_B_SEL    <= '0';     
				RF_WR_EN    <= '1';     
				ALU_Func    <= "0000";  
				ALU_BIN_SEL <= '1';     
				s           <= WRITE_BACK_STAGE;

			-- addi
			 when "110000" =>
				PC_LD_EN    <= '1';
				Opt_Ext     <= "10";    
				RF_B_SEL    <= '0';     
				RF_WR_EN    <= '1';     
				ALU_Func    <= "0000";  
				ALU_BIN_SEL <= '1';     
				s           <= WRITE_BACK_STAGE;
					-- andi
			 when "110010" =>
				PC_LD_EN    <= '1';
				Opt_Ext     <= "00";    
				RF_B_SEL    <= '0';     
				RF_WR_EN    <= '1';     
				ALU_Func    <= "0010";  
				ALU_BIN_SEL <= '1';     
				s           <= WRITE_BACK_STAGE;
						-- ori
			 when "110011" =>
				PC_LD_EN    <= '1';
				Opt_Ext     <= "00";    
				RF_B_SEL    <= '0';     
				RF_WR_EN    <= '1';     
				ALU_Func    <= "0011";  
				ALU_BIN_SEL <= '1';     
				s           <= WRITE_BACK_STAGE;
						---branch
			 when	"111111" =>
				
				PC_LD_EN<='1';
				Opt_Ext <="01"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='0';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				s <=b_stage;		

					---brunch eq
			 when	"010000" =>
				
				PC_SEL  <= '1';
				PC_LD_EN<='1';
				Opt_Ext <="01"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='0';
				RF_WR_EN<='0';
				ALU_Func <= "0001";
				ALU_BIN_SEL<='0';
				s <=beq_stage;			
				
					---brunch not eq
			 when	"010001" =>
			 
				PC_SEL  <= '1';
				PC_LD_EN<='1';
				Opt_Ext <="01"; 
				RF_WR_SEL<='0';	
				RF_B_SEL<='0';
				RF_WR_EN<='0';
				ALU_Func <= "0001";
				ALU_BIN_SEL<='0';
				s <=bne_stage;	
						
					---load word
			 when	"001111" =>
				
				PC_SEL  <= '0';
				PC_LD_EN<='0';
				Opt_Ext <="10"; 
				RF_WR_SEL<='1';--write on RS FROM mem	
				RF_B_SEL<='1';---i type
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';--take immed`
				s <=memory_stage;		
						
					---store word
			 when	"011111" =>
			 
				PC_SEL  <= '0';
				PC_LD_EN<='1';
				Opt_Ext <="10"; 
				RF_WR_SEL<='1';	
				RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				MEM_WrEn  <= '1';
				s <=memory_stage;		

					---load byte
			 when	"000011" =>
			 
				PC_SEL  <= '0';
			   SEL_BYTE     <= '1';
				PC_LD_EN<='0';
				Opt_Ext <="10"; 
				RF_WR_SEL<='1';	
			   RF_B_SEL<='1';
				RF_WR_EN<='0';
				ALU_Func <= "0000";
				ALU_BIN_SEL<='1';
				SEL_BYTE<='1';
				s <=memory_stage;			

			 when others =>
				
		  end case;
  
		when WRITE_BACK_STAGE =>
		
		--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='0';
		RegIMMED_WE<='0';
		RegWorB_WE<='0';

				SEL_BYTE     <= '0';
				MEM_WrEn     <= '0';
				PC_SEL       <= '0';
				PC_LD_EN     <= '0';
				Opt_Ext      <= "00";
				
				if(op_code = "000011" or op_code = "011111" or op_code = "001111") then
				RF_WR_SEL    <= '1';
				RF_WR_EN     <= '1'; 
				else
				RF_WR_SEL<= '0';
				end if;
				
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '0';       
				ALU_BIN_SEL  <= '0';        
				ALU_Func     <= al_func;    
				RegInstr_WE  <= '1';
				s <= IF_STAGE;	
				
		when beq_stage =>
		
			--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='0';
		RegIMMED_WE<='0';
		RegWorB_WE<='0';


				SEL_BYTE     <= '0';
				MEM_WrEn     <= '0';
				if ALU_ZERO='1' then
					PC_SEL       <= '1';--+4+immed
				else
					PC_SEL       <= '0';
				end if;
				PC_LD_EN     <= '0';
				Opt_Ext      <= "01";
				RF_WR_SEL    <= '0';
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '0';       
				ALU_BIN_SEL  <= '0';        
				ALU_Func     <= al_func;    
				s <= IF_STAGE;	
				
			when bne_stage =>
			
				--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='0';
		RegIMMED_WE<='0';
		RegWorB_WE<='0';


				SEL_BYTE     <= '0';
				MEM_WrEn     <= '0';
				if(ALU_ZERO='0') then
				PC_SEL       <= '1';--+4+immed
				else
				PC_SEL       <= '0';
				end if;
				PC_LD_EN     <= '0';
				Opt_Ext      <= "01";
				RF_WR_SEL    <= '0';
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '0';       
				ALU_BIN_SEL  <= '0';        
				ALU_Func     <= al_func;    
				s <= IF_STAGE;	
				
			when b_stage =>
			
			--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='0';
		RegIMMED_WE<='0';
		RegWorB_WE<='0';


				SEL_BYTE     <= '0';
				MEM_WrEn     <= '0';
				PC_SEL       <= '1';--+4+immed
				PC_LD_EN     <= '0';
				Opt_Ext      <= "01";
				RF_WR_SEL    <= '0';
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '1';       
				ALU_BIN_SEL  <= '1';        
				ALU_Func     <= al_func;    
				s <= IF_STAGE;	
				
			when memory_stage =>
			
			--Register Write enables
		
		RegInstr_WE<='0';
		RegRFA_WE<='0';
		RegRFB_WE<='0';
		RegALU_WE<='0';
		RegIMMED_WE<='0';
		RegWorB_WE<='1';
			
				case op_code is
				
				when "011111" =>
			--SW
				SEL_BYTE  <= '0';
				MEM_WrEn     <= '0';
				PC_SEL       <= '0';--+4
				PC_LD_EN     <= '0';
				Opt_Ext      <= "10";
				RF_WR_SEL    <= '0';
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '0';       
				ALU_BIN_SEL  <= '0';        
				ALU_Func     <= "0000";
				s<=IF_STAGE;
				
				when "001111"=>
			--LW
				SEL_BYTE     <= '0';
				MEM_WrEn     <= '0';
				PC_SEL       <= '0';--+4
				PC_LD_EN     <= '1';
				Opt_Ext      <= "10";
				RF_WR_SEL    <= '1';
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '1';       
				ALU_BIN_SEL  <= '0';        
				ALU_Func     <= "0000";
				s<=WRITE_BACK_STAGE	;
				
					when "000011"=>
			---LB
				SEL_BYTE     <= '1';
				MEM_WrEn     <= '0';
				PC_SEL       <= '0';--+4
				PC_LD_EN     <= '1';
				Opt_Ext      <= "10";
				RF_WR_SEL    <= '1';
				RF_B_SEL     <= '0';
				RF_WR_EN     <= '1';       
				ALU_BIN_SEL  <= '0';        
				ALU_Func     <= "0000";
				s<=WRITE_BACK_STAGE;
							 when others =>

				end case;
			end case;
		RegInstr_WE<='1';
		RegRFA_WE<='1';
		RegRFB_WE<='1';
		RegALU_WE<='1';
		RegIMMED_WE<='1';
		RegWorB_WE<='1';
		
	END IF;

	end process;

end Behavioral;	

