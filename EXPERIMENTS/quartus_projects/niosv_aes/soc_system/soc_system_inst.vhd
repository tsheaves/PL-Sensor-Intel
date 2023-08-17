	component soc_system is
		port (
			clk_clk                 : in    std_logic                     := 'X';             -- clk
			locked_phi_in_export    : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			locked_phi_out_export   : out   std_logic;                                        -- export
			locked_theta_in_export  : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			locked_theta_out_export : out   std_logic;                                        -- export
			memory_mem_a            : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba           : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck           : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n         : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke          : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n         : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n        : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n        : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n         : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n      : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq           : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs          : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n        : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt          : out   std_logic;                                        -- mem_odt
			memory_mem_dm           : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin        : in    std_logic                     := 'X';             -- oct_rzqin
			niosv_reset_in_reset    : in    std_logic                     := 'X';             -- reset
			niosv_reset_out_export  : out   std_logic_vector(31 downto 0);                    -- export
			reset_phi_in_reset      : in    std_logic                     := 'X';             -- reset
			reset_phi_out_export    : out   std_logic_vector(31 downto 0);                    -- export
			reset_theta_in_reset    : in    std_logic                     := 'X';             -- reset
			reset_theta_out_export  : out   std_logic_vector(31 downto 0);                    -- export
			tdc_reset_in_reset      : in    std_logic                     := 'X';             -- reset
			tdc_reset_out_export    : out   std_logic_vector(31 downto 0);                    -- export
			theta_clks_refclk_clk   : in    std_logic                     := 'X'              -- clk
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			clk_clk                 => CONNECTED_TO_clk_clk,                 --               clk.clk
			locked_phi_in_export    => CONNECTED_TO_locked_phi_in_export,    --     locked_phi_in.export
			locked_phi_out_export   => CONNECTED_TO_locked_phi_out_export,   --    locked_phi_out.export
			locked_theta_in_export  => CONNECTED_TO_locked_theta_in_export,  --   locked_theta_in.export
			locked_theta_out_export => CONNECTED_TO_locked_theta_out_export, --  locked_theta_out.export
			memory_mem_a            => CONNECTED_TO_memory_mem_a,            --            memory.mem_a
			memory_mem_ba           => CONNECTED_TO_memory_mem_ba,           --                  .mem_ba
			memory_mem_ck           => CONNECTED_TO_memory_mem_ck,           --                  .mem_ck
			memory_mem_ck_n         => CONNECTED_TO_memory_mem_ck_n,         --                  .mem_ck_n
			memory_mem_cke          => CONNECTED_TO_memory_mem_cke,          --                  .mem_cke
			memory_mem_cs_n         => CONNECTED_TO_memory_mem_cs_n,         --                  .mem_cs_n
			memory_mem_ras_n        => CONNECTED_TO_memory_mem_ras_n,        --                  .mem_ras_n
			memory_mem_cas_n        => CONNECTED_TO_memory_mem_cas_n,        --                  .mem_cas_n
			memory_mem_we_n         => CONNECTED_TO_memory_mem_we_n,         --                  .mem_we_n
			memory_mem_reset_n      => CONNECTED_TO_memory_mem_reset_n,      --                  .mem_reset_n
			memory_mem_dq           => CONNECTED_TO_memory_mem_dq,           --                  .mem_dq
			memory_mem_dqs          => CONNECTED_TO_memory_mem_dqs,          --                  .mem_dqs
			memory_mem_dqs_n        => CONNECTED_TO_memory_mem_dqs_n,        --                  .mem_dqs_n
			memory_mem_odt          => CONNECTED_TO_memory_mem_odt,          --                  .mem_odt
			memory_mem_dm           => CONNECTED_TO_memory_mem_dm,           --                  .mem_dm
			memory_oct_rzqin        => CONNECTED_TO_memory_oct_rzqin,        --                  .oct_rzqin
			niosv_reset_in_reset    => CONNECTED_TO_niosv_reset_in_reset,    --    niosv_reset_in.reset
			niosv_reset_out_export  => CONNECTED_TO_niosv_reset_out_export,  --   niosv_reset_out.export
			reset_phi_in_reset      => CONNECTED_TO_reset_phi_in_reset,      --      reset_phi_in.reset
			reset_phi_out_export    => CONNECTED_TO_reset_phi_out_export,    --     reset_phi_out.export
			reset_theta_in_reset    => CONNECTED_TO_reset_theta_in_reset,    --    reset_theta_in.reset
			reset_theta_out_export  => CONNECTED_TO_reset_theta_out_export,  --   reset_theta_out.export
			tdc_reset_in_reset      => CONNECTED_TO_tdc_reset_in_reset,      --      tdc_reset_in.reset
			tdc_reset_out_export    => CONNECTED_TO_tdc_reset_out_export,    --     tdc_reset_out.export
			theta_clks_refclk_clk   => CONNECTED_TO_theta_clks_refclk_clk    -- theta_clks_refclk.clk
		);

