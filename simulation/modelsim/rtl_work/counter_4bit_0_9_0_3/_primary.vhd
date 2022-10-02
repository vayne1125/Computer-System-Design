library verilog;
use verilog.vl_types.all;
entity counter_4bit_0_9_0_3 is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        carry_in        : in     vl_logic;
        value           : out    vl_logic_vector(3 downto 0);
        carry_out       : out    vl_logic;
        mode            : in     vl_logic
    );
end counter_4bit_0_9_0_3;
