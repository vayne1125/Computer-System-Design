library verilog;
use verilog.vl_types.all;
entity counter_reg is
    generic(
        STATE_TOGTHER   : integer := 0;
        STATE_CNT1      : integer := 1;
        STATE_STOP      : integer := 2
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load_w          : in     vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STATE_TOGTHER : constant is 1;
    attribute mti_svvh_generic_type of STATE_CNT1 : constant is 1;
    attribute mti_svvh_generic_type of STATE_STOP : constant is 1;
end counter_reg;
