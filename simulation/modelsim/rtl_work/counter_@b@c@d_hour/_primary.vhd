library verilog;
use verilog.vl_types.all;
entity counter_BCD_hour is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        carry_in        : in     vl_logic;
        q               : out    vl_logic_vector(13 downto 0);
        s               : out    vl_logic_vector(7 downto 0)
    );
end counter_BCD_hour;
