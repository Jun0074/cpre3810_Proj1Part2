library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ID_EXE is
end entity;

architecture tb of tb_ID_EXE is
  -- Clock/reset/controls
  signal clk   : std_logic := '0';
  signal rst   : std_logic := '0';
  signal we    : std_logic := '1';
  signal flush : std_logic := '0';

  -- Inputs (from ID stage)
  signal i_oRS1, i_oRS2, i_Imm : std_logic_vector(31 downto 0) := (others => '0');
  signal i_PC, i_PCplus4        : std_logic_vector(31 downto 0) := (others => '0');
  signal i_rd, i_rs1, i_rs2     : std_logic_vector(4 downto 0)  := (others => '0');

  signal i_ALUSrcA, i_ALUSrc, i_Branch, i_Jump, i_MemWrite,
         i_MemRead, i_RegWrite, i_Halt : std_logic := '0';
  signal i_ALUOp     : std_logic_vector(3 downto 0) := (others => '0');
  signal i_ResultSrc : std_logic_vector(1 downto 0) := (others => '0');
  signal i_LoadType  : std_logic_vector(2 downto 0) := (others => '0');

  -- Outputs (to EX stage)
  signal idex_oRS1, idex_oRS2, idex_PC, idex_PCplus4, idex_Imm : std_logic_vector(31 downto 0);
  signal idex_rd, idex_rs1, idex_rs2 : std_logic_vector(4 downto 0);
  signal idex_ALUOp : std_logic_vector(3 downto 0);
  signal idex_ResultSrc : std_logic_vector(1 downto 0);
  signal idex_LoadType : std_logic_vector(2 downto 0);
  signal idex_ALUSrcA, idex_ALUSrc, idex_Branch, idex_Jump,
         idex_MemWrite, idex_MemRead, idex_RegWrite, idex_Halt : std_logic;

  constant Tclk : time := 10 ns;

begin
  -- Clock generation
  clk_proc : process
  begin
    clk <= '0'; wait for Tclk/2;
    clk <= '1'; wait for Tclk/2;
  end process;

  -- DUT instantiation
  DUT : entity work.ID_EXE
    port map(
      i_CLK => clk,
      i_RST => rst,
      i_WE => we,
      i_FLUSH => flush,

      i_oRS1 => i_oRS1,
      i_oRS2 => i_oRS2,
      i_rd => i_rd,
      i_rs1 => i_rs1,
      i_rs2 => i_rs2,
      i_PC => i_PC,
      i_PCplus4 => i_PCplus4,
      i_Imm => i_Imm,

      i_ALUSrcA => i_ALUSrcA,
      i_ALUSrc  => i_ALUSrc,
      i_ALUOp   => i_ALUOp,
      i_Branch  => i_Branch,
      i_Jump    => i_Jump,
      i_ResultSrc => i_ResultSrc,
      i_MemWrite  => i_MemWrite,
      i_MemRead   => i_MemRead,
      i_RegWrite  => i_RegWrite,
      i_LoadType  => i_LoadType,
      i_Halt      => i_Halt,

      idex_oRS1 => idex_oRS1,
      idex_oRS2 => idex_oRS2,
      idex_rd => idex_rd,
      idex_rs1 => idex_rs1,
      idex_rs2 => idex_rs2,
      idex_PC => idex_PC,
      idex_PCplus4 => idex_PCplus4,
      idex_Imm => idex_Imm,
      idex_ALUSrcA => idex_ALUSrcA,
      idex_ALUSrc  => idex_ALUSrc,
      idex_ALUOp   => idex_ALUOp,
      idex_Branch  => idex_Branch,
      idex_Jump    => idex_Jump,
      idex_ResultSrc => idex_ResultSrc,
      idex_MemWrite  => idex_MemWrite,
      idex_MemRead   => idex_MemRead,
      idex_RegWrite  => idex_RegWrite,
      idex_LoadType  => idex_LoadType,
      idex_Halt      => idex_Halt
    );

  -- Start test proc
  stim : process
  begin
    -------------------------------------------------------------------
    -- Phase 0: Reset asserted (all outputs cleared)
    -------------------------------------------------------------------
    rst <= '1'; we <= '1'; flush <= '0';
    i_oRS1 <= x"DEADBEEF";
    i_oRS2 <= x"CAFEBABE";
    i_PC <= x"00001000";
    i_PCplus4 <= x"00001004";
    i_Imm <= x"11112222";
    i_rd <= "00010";
    i_rs1 <= "00001";
    i_rs2 <= "00011";
    i_ALUOp <= "1010";
    i_ALUSrc <= '1';
    i_ALUSrcA <= '1';
    i_Branch <= '1';
    i_Jump <= '1';
    i_ResultSrc <= "10";
    i_MemWrite <= '1';
    i_MemRead <= '1';
    i_RegWrite <= '1';
    i_LoadType <= "100";
    i_Halt <= '1';
    wait for 20 ns;

    -------------------------------------------------------------------
    -- Phase 1: Release reset, normal operation
    -------------------------------------------------------------------
    rst <= '0';
    i_oRS1 <= x"00000011";
    i_oRS2 <= x"00000022";
    i_PC <= x"00002000";
    i_PCplus4 <= x"00002004";
    i_Imm <= x"22223333";
    i_rd <= "00100";
    i_rs1 <= "00010";
    i_rs2 <= "00101";
    i_ALUOp <= "0011";
    i_ALUSrc <= '0';
    i_ALUSrcA <= '1';
    i_Branch <= '0';
    i_Jump <= '0';
    i_ResultSrc <= "01";
    i_MemWrite <= '0';
    i_MemRead <= '1';
    i_RegWrite <= '1';
    i_LoadType <= "010";
    i_Halt <= '0';
    wait until rising_edge(clk);
    wait for 20 ns;

    -------------------------------------------------------------------
    -- Phase 2: Flush active (zeros control signals only)
    -------------------------------------------------------------------
    flush <= '1';
    i_oRS1 <= x"AAAA0001";
    i_oRS2 <= x"BBBB0002";
    i_PC <= x"00003000";
    i_PCplus4 <= x"00003004";
    i_Imm <= x"33334444";
    i_rd <= "00111";
    i_rs1 <= "00110";
    i_rs2 <= "01000";
    i_ALUOp <= "1111";
    i_ALUSrc <= '1';
    i_ALUSrcA <= '0';
    i_Branch <= '1';
    i_Jump <= '1';
    i_ResultSrc <= "10";
    i_MemWrite <= '1';
    i_MemRead <= '1';
    i_RegWrite <= '1';
    i_LoadType <= "011";
    i_Halt <= '1';
    wait until rising_edge(clk);
    flush <= '0';
    wait for 30 ns;

    -------------------------------------------------------------------
    -- Phase 3: Stall (WE=0), hold outputs even if inputs change
    -------------------------------------------------------------------
    we <= '0';
    i_oRS1 <= x"CCCC0003";
    i_oRS2 <= x"DDDD0004";
    i_PC <= x"00004000";
    i_PCplus4 <= x"00004004";
    i_Imm <= x"44445555";
    i_rd <= "01010";
    i_rs1 <= "01001";
    i_rs2 <= "01011";
    i_ALUOp <= "0001";
    i_ALUSrc <= '0';
    i_ALUSrcA <= '1';
    i_Branch <= '1';
    i_Jump <= '0';
    i_ResultSrc <= "00";
    i_MemWrite <= '0';
    i_MemRead <= '0';
    i_RegWrite <= '0';
    i_LoadType <= "001";
    i_Halt <= '0';
    wait for 30 ns;

    -------------------------------------------------------------------
    -- Phase 4: Resume (WE=1), latch new inputs
    -------------------------------------------------------------------
    we <= '1';
    wait until rising_edge(clk);
    wait for 30 ns;

    wait;
  end process;
end architecture;
