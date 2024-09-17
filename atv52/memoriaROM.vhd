library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 4;
          addrWidth: natural := 3
    );
   port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0);
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture assincrona of memoriaROM is

  type blocoMemoria is array(0 TO 2**addrWidth - 1) of std_logic_vector(dataWidth-1 DOWNTO 0);
  
  constant NOP  : std_logic_vector(3 downto 0) := "0000";
  constant LDA  : std_logic_vector(3 downto 0) := "0001";
  constant SOMA : std_logic_vector(3 downto 0) := "0010";
  constant SUB  : std_logic_vector(3 downto 0) := "0011";
  constant LDI  : std_logic_vector(3 downto 0) := "0100";
  constant STA  : std_logic_vector(3 downto 0) := "0101";
  constant JMP  : std_logic_vector(3 downto 0) := "0110";
  constant JEQ  : std_logic_vector(3 downto 0) := "0111";
  constant CEQ  : std_logic_vector(3 downto 0) := "1000";

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
  begin
      -- Palavra de Controle = SelMUX, Habilita_A, Reset_A, Operacao_ULA
      -- Inicializa os endereços:
        tmp(0)  := JMP & STD_LOGIC_VECTOR(to_unsigned(4, 9));
        tmp(1)  := JEQ & STD_LOGIC_VECTOR(to_unsigned(9, 9));
        tmp(2)  := NOP & STD_LOGIC_VECTOR(to_unsigned(0, 9));
        tmp(3)  := NOP & STD_LOGIC_VECTOR(to_unsigned(0, 9));
        tmp(4)  := LDI & STD_LOGIC_VECTOR(to_unsigned(5, 9));
		  tmp(5)  := STA & STD_LOGIC_VECTOR(to_unsigned(256, 9));
		  tmp(6)  := CEQ & STD_LOGIC_VECTOR(to_unsigned(256, 9));
		  tmp(7)  := JMP & STD_LOGIC_VECTOR(to_unsigned(1, 9));
		  tmp(8)  := NOP & STD_LOGIC_VECTOR(to_unsigned(0, 9));
		  tmp(9)  := LDI & STD_LOGIC_VECTOR(to_unsigned(4, 9));
		  tmp(10)  := CEQ & STD_LOGIC_VECTOR(to_unsigned(256, 9));
		  tmp(11)  := JEQ & STD_LOGIC_VECTOR(to_unsigned(3, 9));
		  tmp(12)  := JMP & STD_LOGIC_VECTOR(to_unsigned(12, 9));
		  return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;