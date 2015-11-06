import lc3b_types::*;

module mp3
(
		input clk,

		/*
		input pmem_resp,
		input [127:0] pmem_rdata,
		output pmem_read, pmem_write,
		output [15:0] pmem_address,
		output [127:0] pmem_wdata,
		*/

		/* Memory signals*/
		output lc3b_word mem_addr1,
		output logic mem_read1,
		output logic mem_write1,
		input lc3b_word mem_rdata1,
		output lc3b_word mem_addr2,
		output logic mem_read2,
		output logic mem_write2,
		output lc3b_mem_wmask mem_byte_enable2,
		input lc3b_word mem_rdata2,
		output lc3b_word mem_wdata2
);

assign mem_write1 = 0;

/*
cache_system LC3b_Cache
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


cpu_datapath LC3b_CPU
(
		.clk,
		.mem_addr1,
		.mem_read1,
		.mem_rdata1,
		.mem_addr2,
		.mem_read2,
		.mem_write2,
		.mem_rdata2,
		.mem_wdata2,
		.mem_byte_enable2
);



endmodule : mp3