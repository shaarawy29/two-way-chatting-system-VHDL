----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/08/2022 07:06:49 PM
-- Design Name: 
-- Module Name: master_tb - Behavioral
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

entity master_tb is
--  Port ( );
end master_tb;

architecture Behavioral of master_tb is

component master is
Port ( clk, reset: in std_logic;
        ps2d, ps2c: in std_logic;
        data_in: in std_logic;
        data_sent: out std_logic;
        tx: out std_logic
        
         );
end component;

signal clk, reset, ps2d, ps2c, data_in, data_sent, tx: std_logic;

begin

uut: master port map(clk, reset, ps2d, ps2c, data_in, data_sent, tx);

FPGA_clk_process: process
begin
clk <= '1'; wait for 5ns;
clk <= '0'; wait for 5ns;
end process;

process
begin
reset <= '1'; ps2d <= '1'; ps2c <= '1'; data_in <= '1'; wait for 100ns;
reset <= '0'; wait for 100ns;
ps2d <= '0'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '0'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '1'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '0'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '0'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '0'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '1'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '0'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '1'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '0'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2d <= '1'; ps2c <= '1'; wait for 100ns;
ps2c <= '0'; wait for 100ns;
ps2c <= '1'; ps2d <= '1'; wait;
end process;

end Behavioral;
