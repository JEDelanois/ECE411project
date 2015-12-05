module cache_system
(
		input clk,
		input CPU_instr_read,
		input [15:0] CPU_instr_addr,
		input CPU_data_read, CPU_data_write,
		input [1:0] CPU_data_byte_enable,
		input [15:0] CPU_data_addr, CPU_data_wdata,
		input pmem_resp,
	   input [127:0] pmem_rdata, //input [1023:0] pmem_rdata,
		
		output CPU_instr_resp,
		output [15:0] CPU_instr_rdata,
		output CPU_data_resp,
		output [15:0] CPU_data_rdata,
		output pmem_read, pmem_write,
		output [15:0] pmem_addr,
		output [127:0] pmem_wdata //output [1023:0] pmem_wdata
);

logic data_resp, data_read, data_write, instr_resp, instr_read, instr_write, L2_resp, L2_read, L2_write, ev_resp, ev_read, ev_write;
logic [15:0] data_addr, instr_addr, L2_address, ev_addr;
logic [127:0] data_rdata, data_wdata, instr_rdata, instr_wdata, L2_wdata, L2_rdata,
					ev_rdata, ev_wdata;

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

L1_cache Data_Cache_L1
(
		.clk(clk),
		.arb_resp(data_resp),
		.arb_rdata(data_rdata),
		.mem_read(CPU_data_read),
		.mem_write(CPU_data_write),
		.mem_byte_enable(CPU_data_byte_enable),
		.mem_address(CPU_data_addr),
		.mem_wdata(CPU_data_wdata),
	 
		.mem_resp(CPU_data_resp),
		.arb_read(data_read),
		.arb_write(data_write),
		.mem_rdata(CPU_data_rdata),
		.arb_address(data_addr),
		.arb_wdata(data_wdata)
);


//Delete this and uncomment the block below to restore L2 -- Also follow instructions in physical_memory.sv
//Also change the port bits on mp3.sv as well as cache_system.sv (top of this page)
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
		
		.L2_read(pmem_read), .L2_write(pmem_write),
		.L2_addr(pmem_addr),
		.L2_wdata(pmem_wdata),
		.L2_rdata(pmem_rdata),
		.L2_resp(pmem_resp)
		
		/*
		.L2_read(ev_read), .L2_write(ev_write),
		.L2_addr(ev_addr),
		.L2_wdata(ev_wdata),
		.L2_rdata(ev_rdata),
		.L2_resp(ev_resp)
		*/
);

/*
eviction_buffer
(
		.clk(clk), .ev_write(ev_write), .ev_read(ev_read), .pmem_resp(pmem_resp),
		.ev_addr(ev_addr),
		.ev_wdata(ev_wdata), .pmem_rdata(pmem_rdata),
		
		
		.ev_resp(ev_resp),	.pmem_write(pmem_write), .pmem_read,
		.pmem_addr,
		.pmem_wdata, .ev_rdata(ev_resp)
);


/*
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

*/
endmodule : cache_system