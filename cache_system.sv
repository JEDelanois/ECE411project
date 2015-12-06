module cache_system
(
		input clk,
		input CPU_instr_read,
		input [15:0] CPU_instr_addr,
		input CPU_data_read, CPU_data_write,
		input [1:0] CPU_data_byte_enable,
		input [15:0] CPU_data_addr, CPU_data_wdata,
		input pmem_resp,
	   input [1023:0] pmem_rdata,
		
		output CPU_instr_resp,
		output [15:0] CPU_instr_rdata,
		output CPU_data_resp,
		output [15:0] CPU_data_rdata,
		output pmem_read, pmem_write,
		output [15:0] pmem_addr,
		output [1023:0] pmem_wdata
);

logic data_resp, data_read, data_write, instr_resp, instr_read, instr_write, L2_resp, L2_read, L2_write, ev_resp, ev_read, ev_write;
logic [15:0] data_addr, instr_addr, L2_address, ev_addr;
logic [127:0] data_rdata, data_wdata, instr_rdata, instr_wdata, L2_wdata, L2_rdata,
					ev_rdata, ev_wdata;

logic in_read, in_write, in_resp;
logic [1:0] in_byte_enable;
logic [15:0] in_addr, in_rdata, in_wdata;
					
L1_cache	Instruction_Cache_L1
(
		.clk(clk),
		.arb_resp(instr_resp),
		.arb_rdata(instr_rdata),
		.mem_read(CPU_instr_read),
		.mem_write(1'b0),
		.mem_byte_enable(2'b11),
		.mem_address(CPU_instr_addr),
		.mem_wdata(16'b1 /* The system should never use this, as write is permanently 0.*/),
	 
		.mem_resp(CPU_instr_resp),
		.arb_read(instr_read),
		.arb_write(instr_write),
		.mem_rdata(CPU_instr_rdata),
		.arb_address(instr_addr),
		.arb_wdata(instr_wdata)
);




register #(16) rdata_in_reg
(
	.clk(clk),
	.load(clk),
	.in(data_rdata),
	.out(in_rdata)
);

register #(16) wdata_in_reg
(
	.clk(clk),
	.load(clk),
	.in(CPU_data_wdata),
	.out(in_wdata)
);

register #(16) addr_in_reg
(
	.clk(clk),
	.load(clk),
	.in(CPU_data_addr),
	.out(in_addr)
);

register #(1) read_in_reg
(
	.clk(clk),
	.load(clk),
	.in(CPU_data_read),
	.out(in_read)
);

register #(1) write_in_reg
(
	.clk(clk),
	.load(clk),
	.in(CPU_data_write),
	.out(in_write)
);

register #(1) resp_in_reg
(
	.clk(clk),
	.load(clk),
	.in(data_resp),
	.out(in_resp)
);

register #(2) byte_in_reg
(
	.clk(clk),
	.load(clk),
	.in(CPU_data_byte_enable),
	.out(in_byte_enable)
);




L1_cache Data_Cache_L1
(
		.clk(clk),
		.arb_resp(in_resp),
		.arb_rdata(in_rdata),
		.mem_read(in_read),
		.mem_write(in_write),
		.mem_byte_enable(in_byte_enable),
		.mem_address(in_addr),
		.mem_wdata(in_wdata),
	 
		.mem_resp(CPU_data_resp),
		.arb_read(data_read),
		.arb_write(data_write),
		.mem_rdata(CPU_data_rdata),
		.arb_address(data_addr),
		.arb_wdata(data_wdata)
);

/*
eviction_buffer
(
		.clk(clk), .ev_write(ev_write), .ev_read(ev_read), .pmem_resp(pmem_resp),
		.ev_addr(ev_addr),
		.ev_wdata(ev_wdata), .pmem_rdata(pmem_rdata),
		
		
		.ev_resp(ev_resp),	.pmem_write(pmem_write), .pmem_read(pmem_read),
		.pmem_addr(pmem_addr),
		.pmem_wdata(pmem_wdata), .ev_rdata(ev_rdata)
);
*/


arbiter L1_Arbiter
(		.instr_read(instr_read), .instr_write(instr_write),
		.instr_addr(instr_addr),
		.instr_wdata(instr_wdata),
		.instr_rdata(instr_rdata),
		.instr_resp(instr_resp),
		
		.data_read(data_read), .data_write(data_write),
		.data_addr(data_addr),
		.data_wdata(data_wdata),
		.data_rdata(data_rdata),
		.data_resp(data_resp),
		
		.L2_read, .L2_write,
		.L2_addr(L2_address),
		.L2_wdata(L2_wdata),
		.L2_rdata(L2_rdata),
		.L2_resp
);


L2_cache L2_Cache
(
		.clk,
		.pmem_resp,
		.pmem_rdata,
		.arb_read(L2_read),
		.arb_write(L2_write),
		.arb_address(L2_address),
		.arb_wdata(L2_wdata),
	 
		.L2_resp,
		.pmem_read,
		.pmem_write,
		.arb_rdata(L2_rdata),
		.pmem_address(pmem_addr),
		.pmem_wdata
);


endmodule : cache_system