library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu4_tb is
end alu4_tb;

architecture Behavioral of alu4_tb is

    component alu4
    Port (
        A : in STD_LOGIC_VECTOR (3 downto 0);
        B : in STD_LOGIC_VECTOR (3 downto 0);
        SEL : in STD_LOGIC_VECTOR (2 downto 0);
        R : out STD_LOGIC_VECTOR(3 downto 0);
        CARRY : out STD_LOGIC;
        BORROW : out STD_LOGIC;
        ZERO : out STD_LOGIC
    );
    end component;

    signal A_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal SEL_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal R_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal CARRY_tb : STD_LOGIC;
    signal BORROW_tb : STD_LOGIC;
    signal ZERO_tb : STD_LOGIC;

begin

    uut: alu4 Port map (
        A => A_tb,
        B => B_tb,
        SEL => SEL_tb,
        R => R_tb,
        CARRY => CARRY_tb,
        BORROW => BORROW_tb,
        ZERO => ZERO_tb
    );

    stim_proc: process
    begin
        A_tb <= "1010"; B_tb <= "1100"; SEL_tb <= "000";
        wait for 10 ns;
        assert R_tb = "1000" report "Error en operacion AND" severity error;

        A_tb <= "1010"; B_tb <= "1100"; SEL_tb <= "001";
        wait for 10 ns;
        assert R_tb = "1110" report "Error en operacion OR" severity error;

        A_tb <= "1010"; B_tb <= "1100"; SEL_tb <= "010";
        wait for 10 ns;
        assert R_tb = "0110" report "Error en operacion XOR" severity error;

        A_tb <= "1010"; B_tb <= "0000"; SEL_tb <= "011";
        wait for 10 ns;
        assert R_tb = "0101" report "Error en operacion NOT" severity error;

        A_tb <= "0101"; B_tb <= "0011"; SEL_tb <= "100";
        wait for 10 ns;
        assert R_tb = "1000" report "Error en operacion Suma 1" severity error;

        A_tb <= "1111"; B_tb <= "0001"; SEL_tb <= "100";
        wait for 10 ns;
        assert R_tb = "0000" report "Error en operacion Suma 2 (R)" severity error;
        assert CARRY_tb = '1' report "Error en operacion Suma 2 (CARRY)" severity error;

        A_tb <= "1001"; B_tb <= "0011"; SEL_tb <= "101";
        wait for 10 ns;
        assert R_tb = "0110" report "Error en operacion Resta 1" severity error;

        A_tb <= "0011"; B_tb <= "0101"; SEL_tb <= "101";
        wait for 10 ns;
        assert R_tb = "1110" report "Error en operacion Resta 2 (R)" severity error;
        assert BORROW_tb = '1' report "Error en operacion Resta 2 (BORROW)" severity error;

        A_tb <= "0101"; B_tb <= "0000"; SEL_tb <= "110";
        wait for 10 ns;
        assert R_tb = "1010" report "Error en operacion Shift Left" severity error;

        A_tb <= "1010"; B_tb <= "0000"; SEL_tb <= "111";
        wait for 10 ns;
        assert R_tb = "0101" report "Error en operacion Shift Right" severity error;

        wait;
    end process;

end Behavioral;
