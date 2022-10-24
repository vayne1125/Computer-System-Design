library verilog;
use verilog.vl_types.all;
entity ROM is
    port(
        Rom_data_out    : out    vl_logic_vector(13 downto 0);
        Rom_addr_in     : in     vl_logic_vector(10 downto 0)
    );
end ROM;
