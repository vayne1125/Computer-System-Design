library verilog;
use verilog.vl_types.all;
entity hw_1017_2 is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        W               : out    vl_logic_vector(3 downto 0)
    );
end hw_1017_2;
