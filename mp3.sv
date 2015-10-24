module mp3
(
		input clk,
		input pmem_resp,
		input [127:0] pmem_rdata,
		output pmem_read, pmem_write,
		output [15:0] pmem_address,
		output [127:0] pmem_wdata
);

/*
cache LC3b_Cache
(
		.clk(clk),
		.pmem_resp(pmem_resp),
		.pmem_rdata(pmem_rdata),
		.pmem_read(pmem_read),
		.pmem_write(pmem_write),
		.pmem_address(pmem_address),
		.pmem_wdata(pmem_wdata)
);

*/


cpu LC3b_CPU
(
		.clk(clk),
		.pc_out(),
		.mem_rdata(),
		.mem_read1()
);



endmodule : mp3