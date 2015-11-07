module mp3
(
		input clk,
		input pmem_resp,
		input [127:0] pmem_rdata,
		
		output pmem_read, pmem_write,
		output [15:0] pmem_address,
		output [127:0] pmem_wdata
);


logic resp_a, resp_b, mem_read1, mem_read2, mem_write2;
logic [1:0] mem_byte_enable2;
logic [15:0] mem_addr1, mem_addr2, mem_rdata1, mem_rdata2, mem_wdata2;

cache_system Cache_Module
(
		.clk(clk),
		.CPU_instr_read(mem_read1),
		.CPU_instr_addr(mem_addr1),
		.CPU_data_read(mem_read2),
		.CPU_data_write(mem_write2),
		.CPU_data_byte_enable(mem_byte_enable2),
		.CPU_data_addr(mem_addr2),
		.CPU_data_wdata(mem_wdata2),
		.pmem_resp(pmem_resp),
		.pmem_rdata(pmem_rdata),
		
		.CPU_instr_resp(resp_a),
		.CPU_instr_rdata(mem_rdata1),
		.CPU_data_resp(resp_b),
		.CPU_data_rdata(mem_rdata2),
		.pmem_read(pmem_read),
		.pmem_write(pmem_write),
		.pmem_addr(pmem_address),
		.pmem_wdata(pmem_wdata)
);


cpu_datapath LC3b_CPU
(
		.clk(clk),
		.resp_a(resp_a),
		.resp_b(resp_b),
		.mem_addr1(mem_addr1),
		.mem_read1(mem_read1),
		.mem_rdata1(mem_rdata1),
		.mem_addr2(mem_addr2),
		.mem_read2(mem_read2),
		.mem_write2(mem_write2),
		.mem_rdata2(mem_rdata2),
		.mem_wdata2(mem_wdata2),
		.mem_byte_enable2(mem_byte_enable2)
);



endmodule : mp3