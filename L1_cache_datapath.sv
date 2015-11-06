import lc3b_types::*;

module L1_cache_datapath
(
		input clk, load_LRU, LRU_in, w1_dirty_in, w2_dirty_in, write_back_bit, rw_mux_sel, writemux_sel,
		input [1:0] byte_enable,
		input [3:0] load_w1, load_w2,
		input lc3b_word mem_wdata,
		input lc3b_word mem_address,
		input [127:0] arb_rdata,
		
		//Logic values must be input
		
		output hit, w2_hit, LRU_out, w1_dirty_out, w2_dirty_out,
		output lc3b_word mem_rdata, arb_address,
		output [127:0] arb_wdata
		
);

logic [127:0] post_write_w1, post_write_w2, w1_data_in, w2_data_in, w1_data_out, w2_data_out, waymux_out;
logic [8:0] tag, w1_tag_out, w2_tag_out;
logic [3:0] offset;
logic [2:0] index, rdata_sel;
logic w1_valid_out, w2_valid_out;


assign tag = mem_address[15:7];
assign index = mem_address[6:4];
assign offset = mem_address[3:0];
assign rdata_sel = mem_address[3:1];

array LRU_array
(
	.clk,
	.write(load_LRU),
	.index,
	.in(LRU_in),
	.out(LRU_out)
);

write_mesh w1_write_mesh
(
	.data_out(w1_data_out),
	.memory_write(mem_wdata),
	.offset,
	.byte_enable,
	.meshed_data_in(post_write_w1)
);

mux2 #(128) data_in_w1_mux
(
	.sel(rw_mux_sel),
	.a(arb_rdata),
	.b(post_write_w1),
	.f(w1_data_in)
);

L1_cache_way way_one
(
		.clk,
		.dirty_in(w1_dirty_in),
		.index,
		.array_write(load_w1),
		.tag_in(tag),
		.data_in(w1_data_in),
		
		.valid_out(w1_valid_out),
		.dirty_out(w1_dirty_out),
		.tag_out(w1_tag_out),
		.data_out(w1_data_out)		
);

write_mesh w2_write_mesh
(
	.data_out(w2_data_out),
	.memory_write(mem_wdata),
	.offset,
	.byte_enable,
	.meshed_data_in(post_write_w2)
);

mux2 #(128) data_in_w2_mux
(
	.sel(rw_mux_sel),
	.a(arb_rdata),
	.b(post_write_w2),
	.f(w2_data_in)
);

L1_cache_way way_two
(
		.clk,
		.dirty_in(w2_dirty_in),
		.index,
		.array_write(load_w2),
		.tag_in(tag),
		.data_in(w2_data_in),
		
		.valid_out(w2_valid_out),
		.dirty_out(w2_dirty_out),
		.tag_out(w2_tag_out),
		.data_out(w2_data_out)		
);


mux2 #(128) waymux
(
	.sel(w2_hit),
	.a(w1_data_out),
	.b(w2_data_out),
	.f(waymux_out)
);

mux2 #(128) writemux
(
	.sel(writemux_sel),
	.a(w1_data_out),
	.b(w2_data_out),
	.f(arb_wdata)
);

mux8 rdata_mux
(
	.sel(rdata_sel),
	.a(waymux_out[15:0]),
	.b(waymux_out[31:16]),
	.c(waymux_out[47:32]),
	.d(waymux_out[63:48]),
	.e(waymux_out[79:64]),
	.f(waymux_out[95:80]),
	.g(waymux_out[111:96]),
	.h(waymux_out[127:112]),
	.z(mem_rdata)
);

arb_address_calc arb_address_calc
(
	.mem_address,
	.tag_1(w1_tag_out),
	.tag_2(w2_tag_out),
	.LRU_out,
	.write_back_bit(write_back_bit),
	.arb_address
);

hit_logic hit_computation
(
	.tag, 
	.w1_tag_out, 
	.w2_tag_out,
	.w1_valid_out,
	.w2_valid_out,
	.hit,
	.w2_hit
);

endmodule : L1_cache_datapath