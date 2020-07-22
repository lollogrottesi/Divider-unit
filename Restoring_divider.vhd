----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 12:39:08
-- Design Name: 
-- Module Name: Divider_unit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Restoring_divider is
    generic (N: integer := 32);
    port (dividend: in std_logic_vector(N-1 downto 0);
          divider: in std_logic_vector(N-1 downto 0);
          clk, rst: in std_logic;
          soa: in std_logic;    --StartOfAlgorithm.
          quotient: out std_logic_vector(N-1 downto 0);
          reminder: out std_logic_vector(N-1 downto 0);
          eoa: out std_logic);  --EndOfAlgorithm.
end Restoring_divider;

architecture Behavioral of Restoring_divider is

type statetype is (reset, idle, shift, sum_up, check_sign, restore, incr_count);
signal c_j, n_j: integer;
signal c_state, n_state: statetype;
signal c_a_q, n_a_q: std_logic_vector(2*N-1 downto 0);
begin
    clk_process:
        process(clk)
        begin
            if (clk='1'and clk'event) then
                if (rst = '1') then
                    c_state <= reset;
                    c_a_q <= (others =>'0');
                    c_j <= 0;
                else 
                    c_a_q <= n_a_q;
                    c_state <= n_state;
                    c_j <= n_j;
                end if;
            end if;
        end process;

    state_process:
        process(soa, dividend, divider, c_state, c_j, c_a_q)
        begin
            case c_state is
                when reset =>
                    n_state <= idle;
                    eoa <= '0'; 
                    n_a_q <= c_a_q;
                when idle =>
                    eoa <= '0';
                    n_j <= 0;
                    if (soa = '1') then
                        n_state <= shift;--start algorithm.
                        n_a_q(N-1 downto 0) <= dividend;
                        n_a_q (2*N-1 downto N) <= (others => '0');
                    else
                        n_a_q <= (others=>'0');
                        n_state <= idle;
                    end if;
                when shift =>

                    n_a_q <= std_logic_vector(shift_left(signed(c_a_q),1));
                    n_state <= sum_up;
                when sum_up =>    
                    n_a_q(2*N-1 downto N) <= std_logic_vector(signed(c_a_q(2*N-1 downto N)) - signed(divider));
                    n_state <= check_sign;
                when check_sign =>
                    if (c_a_q(2*N-1) = '0') then
                        n_a_q(0) <= '1';
                        n_state <= incr_count;
                    else
                        n_a_q(0) <= '0';
                        n_state <= restore;
                    end if;   
                when restore =>
                    n_a_q(2*N-1 downto N) <=   std_logic_vector(signed(c_a_q(2*N-1 downto N)) + signed(divider)); 
                    n_state <= incr_count;
                when incr_count =>
                    n_j <= c_j + 1;
                    if (c_j = N-1) then
                        eoa <= '1';
                        n_state <= idle;
                    else
                        eoa <= '0';
                        n_state <= shift;
                    end if;             
            end case;
        end process;
quotient <= c_a_q (N-1 downto 0);
reminder <= c_a_q (2*N-1 downto N);
end Behavioral;
