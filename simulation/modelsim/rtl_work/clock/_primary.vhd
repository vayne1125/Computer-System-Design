library verilog;
use verilog.vl_types.all;
entity clock is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        q               : out    vl_logic_vector(27 downto 0);
        s               : out    vl_logic_vector(15 downto 0)
    );
end clock;
