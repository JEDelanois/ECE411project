module L1_cache
(
		input clk,
		input arb_resp,
		input [127:0] arb_rdata,
		input mem_read,
		input mem_write,
		input [1:0] mem_byte_enable,
		input lc3b_word mem_address,
		input lc3b_word mem_wdata,
	 
		output mem_resp,
		output arb_read,
		output arb_write,
		output lc3b_word mem_rdata,
		output lc3b_word arb_address,
		output [127:0] arb_wdata
);

logic hit, w2_hit, load_LRU, LRU_in, LRU_out, w1_dirty_in, w2_dirty_in, w1_dirty_out, w2_dirty_out, write_back_bit, rw_mux_sel, writemux_sel;
logic [3:0] load_w1, load_w2;

L1_cache_datapath cache_data
(
		.clk,
		.load_LRU(load_LRU),
		.LRU_in(LRU_in),
		.w1_dirty_in(w1_dirty_in),
		.w2_dirty_in(w2_dirty_in),
		.write_back_bit(write_back_bit),
		.rw_mux_sel(rw_mux_sel),
		.writemux_sel(writemux_sel),
		.byte_enable(mem_byte_enable),
		.load_w1(load_w1),
		.load_w2(load_w2),
		.mem_wdata,
		.mem_address,
		.arb_rdata,
		
		.hit(hit),
		.w2_hit(w2_hit),
		.LRU_out(LRU_out),
		.w1_dirty_out(w1_dirty_out),
		.w2_dirty_out(w2_dirty_out),
		.mem_rdata,
		.arb_address,
		.arb_wdata
);

L1_cache_control cache_ctrl
(
	.clk,
	.mem_read,
	.mem_write,
	.arb_resp,
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
	.mem_resp,
	.arb_read,
	.arb_write
);



endmodule : L1_cache