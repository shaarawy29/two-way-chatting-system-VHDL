----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2022 12:54:42 PM
-- Design Name: 
-- Module Name: ps2rx_tb - Behavioral
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

entity ps2rx_tb is
--  Port ( );
end ps2rx_tb;

architecture Behavioral of ps2rx_tb is

component ps2rx is 
    port (
        clk, rst : in std_logic;
        ps2d, ps2c : in std_logic;
        rx_en : in std_logic;
        rx_done_tick : out std_logic;
        shift_en : out std_logic;
        dout : out std_logic_vector(7 downto 0)
    );
end component;

component key2ascii is 
port (
        caps_enabled : in std_logic;
        shift_enabled : in std_logic;
        key_code : in std_logic_vector(7 downto 0);
        ascii_code : out std_logic_vector(7 downto 0)
    );
end component;

signal clk, reset, ps2d, ps2c, rx_en, rx_done_tick, shift_en: std_logic;
signal dout, ascii: std_logic_vector(7 downto 0);

begin
uut: ps2rx port map(clk, reset, ps2d, ps2c, rx_en, rx_done_tick, shift_en, dout);
uut1: key2ascii port map('0', '0', dout, ascii);
process
begin
clk <= '0'; wait for 2ns;
clk <= '1'; wait for 2ns;
end process;


process
begin
reset <= '1'; rx_en <= '1'; ps2d <= '1'; ps2c <= '1'; wait for 100ns;
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
ps2c <= '1';
wait;
end process;

end Behavioral;
