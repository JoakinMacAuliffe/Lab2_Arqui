library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu4 is
Port (
    A : in STD_LOGIC_VECTOR (3 downto 0);
    B : in STD_LOGIC_VECTOR (3 downto 0);
    SEL : in STD_LOGIC_VECTOR (2 downto 0);
    R : out STD_LOGIC_VECTOR(3 downto 0);
    CARRY : out STD_LOGIC;
    BORROW : out STD_LOGIC;
    ZERO : out STD_LOGIC
);
end alu4;

architecture Behavioral of alu4 is
begin
    process(A, B, SEL)
        variable temp_A : unsigned(4 downto 0);
        variable temp_B : unsigned(4 downto 0);
        variable temp_R : unsigned(4 downto 0);
        variable res   : STD_LOGIC_VECTOR(3 downto 0);
    begin
        CARRY <= '0';
        BORROW <= '0';
        ZERO <= '0';
        res := "0000";

        case SEL is
            when "000" =>
                res := A and B;
            when "001" =>
                res := A or B;
            when "010" =>
                res := A xor B;
            when "011" =>
                res := not A;
            when "100" =>
                temp_A := '0' & unsigned(A);
                temp_B := '0' & unsigned(B);
                temp_R := temp_A + temp_B;
                res := std_logic_vector(temp_R(3 downto 0));
                CARRY <= temp_R(4);
            when "101" =>
                if unsigned(A) < unsigned(B) then
                    BORROW <= '1';
                end if;
                res := std_logic_vector(unsigned(A) - unsigned(B));
            when "110" =>
                res := std_logic_vector(shift_left(unsigned(A), 1));
            when "111" =>
                res := std_logic_vector(shift_right(unsigned(A), 1));
            when others =>
                res := "0000";
        end case;

        R <= res;

        if res = "0000" then
            ZERO <= '1';
        else
            ZERO <= '0';
        end if;

    end process;
end Behavioral;