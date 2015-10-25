module mp3_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic mem_read1;
logic mem_write1;
logic mem_read2;
logic mem_write2;
logic [1:0] mem_byte_enable2;
logic [15:0] mem_addr1;
logic [15:0] mem_addr2;
logic [15:0] mem_rdata1;
logic [15:0] mem_rdata2;
logic [15:0] mem_wdata2;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp3 dut
(
    .clk,

    /* Memory signals*/
    .mem_addr1,
    .mem_read1,
    .mem_write1,
    .mem_rdata1,
    .mem_addr2,
    .mem_read2,
    .mem_write2,
    .mem_byte_enable2,
    .mem_rdata2,
    .mem_wdata2
);

magic_memory_dp magic_memory_dp
(
    .clk,

    /* Port A */
    .read_a(mem_read1),
    .write_a(mem_write1),
    .wmask_a(),
    .address_a(mem_addr1),
    .wdata_a(),
    .resp_a(),
    .rdata_a(mem_rdata1),

    /* Port B */
    .read_b(mem_read2),
    .write_b(mem_write2),
    .wmask_b(mem_byte_enable2),
    .address_b(mem_addr2),
    .wdata_b(mem_wdata2),
    .resp_b(),
    .rdata_b(mem_rdata2)
);

endmodule : mp3_tb
