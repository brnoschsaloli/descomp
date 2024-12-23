library ieee;
use ieee.std_logic_1164.all;

entity decoderFunct is
  port ( entrada : in std_logic_vector(5 downto 0);
         saida : out std_logic_vector(2 downto 0)
  );
end entity;

architecture comportamento of decoderFunct is

  constant SOMA : std_logic_vector(5 downto 0) := "100000";
  constant SUB  : std_logic_vector(5 downto 0) := "100010";

  begin
saida <= "000" when entrada = SOMA else
         "001" when entrada = SUB else
         "000";  -- NOP para os entradas Indefinidas
end architecture;