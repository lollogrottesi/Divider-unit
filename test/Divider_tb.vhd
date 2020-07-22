----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 13:39:43
-- Design Name: 
-- Module Name: Divider_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Divider_tb is
--  Port ( );
end Divider_tb;

architecture Behavioral of Divider_tb is

component Restoring_divider is
    generic (N: integer := 32);
    port (dividend: in std_logic_vector(N-1 downto 0);
          divider: in std_logic_vector(N-1 downto 0);
          clk, rst: in std_logic;
          soa: in std_logic;    --StartOfAlgorithm.
          quotient: out std_logic_vector(N-1 downto 0);
          reminder: out std_logic_vector(N-1 downto 0);
          eoa: out std_logic);  --EndOfAlgorithm.
end component;

component Non_restoring_divider is
    generic (N: integer := 32);
    port (dividend: in std_logic_vector(N-1 downto 0);
          divider: in std_logic_vector(N-1 downto 0);
          clk, rst: in std_logic;
          soa: in std_logic;    --StartOfAlgorithm.
          quotient: out std_logic_vector(N-1 downto 0);
          reminder: out std_logic_vector(N-1 downto 0);
          eoa: out std_logic);  --EndOfAlgorithm.
end component;


constant N: integer := 8;
signal dividend, divider, quotient, reminder: std_logic_vector(N-1 downto 0);
signal clk, rst, soa, eoa: std_logic;
begin

dut : Non_restoring_divider generic map (N) --Change the name of component to change test.
                   port map (dividend, divider, clk, rst, soa, quotient, reminder, eoa);

clk_generation:
    process
    begin
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
    end process;

    process
    begin
        soa <= '0';
        rst <= '1';
        dividend <= "00010111";
        divider <=  "00001011";
        wait until clk = '1' and clk'event;
        rst <= '0';
        wait until clk = '1' and clk'event;
        soa <= '1';
        wait until clk = '1' and clk'event;
        soa <= '0';
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait until clk = '1' and clk'event;
        wait;
    end process;
end Behavioral;
