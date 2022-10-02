library verilog;
use verilog.vl_types.all;
entity seven_segment is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        y               : out    vl_logic_vector(6 downto 0)
    );
end seven_segment;
