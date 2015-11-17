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
		.arb_wdata,
		.arb_address,
		.pmem_rdata,
		
		.hit(hit),
		.w2_hit(w2_hit),
		.LRU_out(LRU_out),
		.w1_dirty_out(w1_dirty_out),
		.w2_dirty_out(w2_dirty_out),
		.arb_rdata,
		.pmem_address,
		.pmem_wdata
);


L2_cache_control cache_ctrl
(
	.clk,
	.arb_read,
	.arb_write,
	.pmem_resp,
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
	.arb_resp(L2_resp),
	.pmem_read,
	.pmem_write
);



endmodule : L2_cache