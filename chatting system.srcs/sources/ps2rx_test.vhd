----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2022 04:34:10 PM
-- Design Name: 
-- Module Name: ps2rx_test - Behavioral
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

entity ps2rx_test is
port (
    clk, reset: in std_logic;
    ps2d, ps2c: in std_logic; -- key data, key clock
    --rx_en : in std_logic;
    --rx_done_tick: out std_logic;
    --ps2c_out: out std_logic;
   -- ps2d_out: out std_logic;
    ascii_out: out std_logic_vector (7 downto 0);
    make_code_out: out std_logic_vector(7 downto 0)
);
end ps2rx_test;

architecture Behavioral of ps2rx_test is
signal shift_en: std_logic;
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

signal make_code, ascii: std_logic_vector(7 downto 0);
signal rx_done_tick: std_logic;

begin

ps2rx_unit: ps2rx port map(clk, reset, ps2d, ps2c, '1', rx_done_tick, shift_en, make_code);
key2ascii_unit: key2ascii port map('0', shift_en, make_code, ascii);
make_code_out <= make_code;
ascii_out <= ascii;
--ps2c_out <= ps2c;
--ps2d_out <= ps2d;

end Behavioral;
