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

logic hit, w1_hit, w2_hit, w3_hit, w4_hit, load_LRU, w1_dirty_in, w2_dirty_in, w3_dirty_in, w4_dirty_in,
				w1_dirty_out, w2_dirty_out, w3_dirty_out, w4_dirty_out, write_back_bit, rw_mux_sel;
logic [1:0] writemux_sel;
logic [2:0] LRU_in, LRU_out;
logic [3:0] load_w1, load_w2, load_w3, load_w4;

L2_cache_datapath cache_data
(
		.clk,
		.load_LRU(load_LRU),
		.LRU_in(LRU_in),
		.writemux_sel(writemux_sel),
		.w1_dirty_in(w1_dirty_in),
		.w2_dirty_in(w2_dirty_in),
		.w3_dirty_in(w3_dirty_in),
		.w4_dirty_in(w4_dirty_in),
		.write_back_bit(write_back_bit),
		.rw_mux_sel(rw_mux_sel),
		.load_w1(load_w1),
		.load_w2(load_w2),
		.load_w3(load_w3),
		.load_w4(load_w4),
		.arb_wdata,
		.arb_address,
		.pmem_rdata,
		
		.hit(hit),
		.w1_hit(w1_hit),
		.w2_hit(w2_hit),
		.w3_hit(w3_hit),
		.w4_hit(w4_hit),
		.LRU_out(LRU_out),
		.w1_dirty_out(w1_dirty_out),
		.w2_dirty_out(w2_dirty_out),
		.w3_dirty_out(w3_dirty_out),
		.w4_dirty_out(w4_dirty_out),
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
	.w1_hit(w1_hit),
	.w2_hit(w2_hit),
	.w3_hit(w3_hit),
	.w4_hit(w4_hit),
	.LRU_out(LRU_out),
	.w1_dirty_out(w1_dirty_out),
	.w2_dirty_out(w2_dirty_out),
	.w3_dirty_out(w3_dirty_out),
	.w4_dirty_out(w4_dirty_out),
	
	.load_w1(load_w1),
	.load_w2(load_w2),
	.load_w3(load_w3),
	.load_w4(load_w4),
	.load_LRU(load_LRU),
	.LRU_in(LRU_in),
	.writemux_sel(writemux_sel),
	.w1_dirty_in(w1_dirty_in),
	.w2_dirty_in(w2_dirty_in),
	.w3_dirty_in(w3_dirty_in),
	.w4_dirty_in(w4_dirty_in),
	.write_back_bit(write_back_bit),
	.rw_mux_sel(rw_mux_sel),
	.arb_resp(L2_resp),
	.pmem_read,
	.pmem_write
);



endmodule : L2_cache