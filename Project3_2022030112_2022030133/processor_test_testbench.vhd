-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
           COMPONENT PROCESSOR
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
			CARRY_OUT : out  STD_LOGIC;
          OVF : out  STD_LOGIC
        );
    END COMPONENT;

          SIGNAL <signal1> :  std_logic;
          SIGNAL <signal2> :  std_logic_vector(3 downto 0);
          

  BEGIN

  -- Component Instantiation
          uut: <component name> PORT MAP(
                  <port1> => <signal1>,
                  <port3> => <signal2>
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
