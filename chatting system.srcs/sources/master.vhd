----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2022 04:29:52 PM
-- Design Name: 
-- Module Name: master - Behavioral
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

entity master is
 Port ( clk, reset: in std_logic;
        ps2d, ps2c: in std_logic;
        data_in: in std_logic;
        --display_in: in std_logic;
        --display_out: out std_logic;
        data_sent: out std_logic;
        tx: out std_logic
        --rx_en: in std_logic;
        --tx_start: out std_logic;
        --rx_done_tick: out std_logic;
        --tx_start_led: out std_logic;
        --dout_led: out std_logic_vector(7 downto 0);
        --dout: out std_logic_vector (7 downto 0)
         );
end master;

architecture Behavioral of master is

signal make_code: std_logic_vector(7 downto 0) := "00000000";
signal ascii: std_logic_vector(7 downto 0) := "00000000";
signal received_data: std_logic_vector(7 downto 0) := "00000000";
signal key_done, received_done, tx_display_done, tx_data_done: std_logic;
signal display: std_logic;
signal dis_data: std_logic_vector(7 downto 0);
signal tick: std_logic;
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

component uart_tx is
generic (
    DBIT : integer := 8; -- # da ta b i t s
    SB_TICK : integer := 16 -- # t i c k s f o r s t o p b i t s
);
port(
    clk , reset : in std_logic ;
    tx_start : in std_logic ;
    s_tick : in std_logic ;
    din : in std_logic_vector (7 downto 0);
    tx_done_tick : out std_logic ;
    tx : out std_logic
);
end component ;

component uart_rx is
generic (
    DBIT : integer := 8; -- # d a t a b i t s
    SB_TICK : integer := 16 -- # t i c k s f o r s t o p b i t s
);
port(
    clk , reset : in std_logic ;
    rx : in std_logic ;
    s_tick : in std_logic ;
    rx_done_tick : out std_logic ;
    dout : out std_logic_vector (7 downto 0)
);
end component;


component baud_gen is 
port(
    clk : in std_logic ;
    reset : in std_logic ;
    dvsr : in std_logic_vector (10 downto 0);
    tick : out std_logic
);
end component ;


component key2ascii is 
port (
        caps_enabled : in std_logic;
        shift_enabled : in std_logic;
        key_code : in std_logic_vector(7 downto 0);
        ascii_code : out std_logic_vector(7 downto 0)
    );
end component;

begin


display <= received_done or key_done;
dis_data <= received_data when received_done = '1' else
            ascii when key_done = '1' else
            "00000000";
ps2rx_unit: ps2rx port map(clk, reset, ps2d, ps2c, '1', key_done, shift_en, make_code);
key2ascii_unit: key2ascii port map('0', shift_en, make_code, ascii);
baud_gen_unit: baud_gen port map(clk, reset, "00101000101", tick);
uart_tx_unit_display: uart_tx port map(clk, reset, display, tick, dis_data, tx_display_done, tx);
uart_tx_unit_send_data: uart_tx port map(clk, reset, key_done, tick, ascii, tx_data_done, data_sent);
uart_rx_unit: uart_rx port map(clk, reset, data_in, tick, received_done, received_data);
--00101000101



end Behavioral;
