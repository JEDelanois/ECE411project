import lc3b_types::*;

module L2_cache
(
		input clk,
		input pmem_resp,
		input [1023:0] pmem_rdata,
		input arb_read,
		input arb_write,
		input [15:0] arb_address,
		input [127:0] arb_wdata,
	 
		output L2_resp,
		output pmem_read,
		output pmem_write,
		output [127:0] arb_rdata,
		output [15:0] pmem_address,
		output [1023:0] pmem_wdata
);

logic hit, w2_hit, load_LRU, LRU_in, LRU_out, w1_dirty_in, w2_dirty_in, w1_dirty_out, w2_dirty_out, write_back_bit, rw_mux_sel, writemux_sel;
logic [3:0] load_w1, load_w2;

logic [1023:0] in_rdata, out_wdata;
logic [127:0] in_wdata, out_rdata;
logic [15:0] in_addr, out_addr;
logic in_read, in_write, in_resp, out_read, out_write, out_resp;

assign in_rdata = pmem_rdata;
assign in_wdata = arb_wdata;
assign in_addr = arb_address;
assign in_read = arb_read;
assign in_write = arb_write;
assign in_resp = pmem_resp;

/*
register #(1024) rdata_in_reg
(
	.clk(clk),
	.load(clk),
	.in(pmem_rdata),
	.out(in_rdata)
);

register #(128) wdata_in_reg
(
	.clk(clk),
	.load(clk),
	.in(arb_wdata),
	.out(in_wdata)
);

register #(16) addr_in_reg
(
	.clk(clk),
	.load(clk),
	.in(arb_address),
	.out(in_addr)
);

register #(1) read_in_reg
(
	.clk(clk),
	.load(clk),
	.in(arb_read),
	.out(in_read)
);

register #(1) write_in_reg
(
	.clk(clk),
	.load(clk),
	.in(arb_write),
	.out(in_write)
);

register #(1) resp_in_reg
(
	.clk(clk),
	.load(clk),
	.in(pmem_resp),
	.out(in_resp)
);
*/

L2_cache_datapath cache_data
(
		.clk,
		.load_LRU(load_LRU),
		.LRU_in(LRU_in),
		.w1_dirty_in(w1_dirty_in),
		.w2_dirty_in(w2_dirty_in),
		.write_back_bit(write_back_bit),
		.rw_mux_sel(rw_mux_sel),
		.writemux_sel(writemux_sel),
		.load_w1(load_w1),
		.load_w2(load_w2),
		.arb_wdata(in_wdata),
		.arb_address(in_addr),
		.pmem_rdata(in_rdata),
		
		.hit(hit),
		.w2_hit(w2_hit),
		.LRU_out(LRU_out),
		.w1_dirty_out(w1_dirty_out),
		.w2_dirty_out(w2_dirty_out),
		.arb_rdata(out_rdata),
		.pmem_address(out_addr),
		.pmem_wdata(out_wdata)
);


L2_cache_control cache_ctrl
(
	.clk,
	.arb_read(in_read),
	.arb_write(in_write),
	.pmem_resp(in_resp),
	.hit(hit),
	.w2_hit(w2_hit),
	.LRU_out(LRU_out),
	.w1_dirty_out(w1_dirty_out),
	.w2_dirty_out(w2_dirty_out),
	
	.load_w1(load_w1),
	.load_w2(load_w2),
	.load_LRU(load_LRU),
	.LRU_in(LRU_in),
	.w1_dirty_in(w1_dirty_in),
	.w2_dirty_in(w2_dirty_in),
	.write_back_bit(write_back_bit),
	.rw_mux_sel(rw_mux_sel),
	.writemux_sel(writemux_sel),
	.arb_resp(out_resp),
	.pmem_read(out_read),
	.pmem_write(out_write)
);



register #(128) rdata_out_reg
(
	.clk(clk),
	.load(clk),
	.in(out_rdata),
	.out(arb_rdata)
);

register #(1024) wdata_out_reg
(
	.clk(clk),
	.load(clk),
	.in(out_wdata),
	.out(pmem_wdata)
);

register #(16) addr_out_reg
(
	.clk(clk),
	.load(clk),
	.in(out_addr),
	.out(pmem_address)
);

register #(1) read_out_reg
(
	.clk(clk),
	.load(clk),
	.in(out_read),
	.out(pmem_read)
);

register #(1) write_out_reg
(
	.clk(clk),
	.load(clk),
	.in(out_write),
	.out(pmem_write)
);

register #(1) resp_out_reg
(
	.clk(clk),
	.load(clk),
	.in(out_resp),
	.out(L2_resp)
);


endmodule : L2_cache