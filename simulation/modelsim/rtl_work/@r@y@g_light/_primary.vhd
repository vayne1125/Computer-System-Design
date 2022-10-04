library verilog;
use verilog.vl_types.all;
entity RYG_light is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        R               : out    vl_logic_vector(1 downto 0);
        Y               : out    vl_logic_vector(1 downto 0);
        G               : out    vl_logic_vector(1 downto 0)
    );
end RYG_light;
