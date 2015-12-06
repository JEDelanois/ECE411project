import lc3b_types::*;

module L2_cache_datapath
(
		input clk, load_LRU, LRU_in, w1_dirty_in, w2_dirty_in, write_back_bit, rw_mux_sel, writemux_sel,
		input [3:0] load_w1, load_w2,
		input [127:0] arb_wdata,
		input [15:0] arb_address,
		input [1023:0] pmem_rdata,
		
		//Logic values must be input
		
		output hit, w2_hit, LRU_out, w1_dirty_out, w2_dirty_out,
		output [127:0] arb_rdata,
		output [15:0] pmem_address,
		output [1023:0] pmem_wdata
		
);

logic [1023:0] post_write_w1, post_write_w2, w1_data_in, w2_data_in, w1_data_out, w2_data_out, waymux_out;
logic [5:0] tag, w1_tag_out, w2_tag_out;
logic [2:0] offset;
logic [2:0] index;
logic w1_valid_out, w2_valid_out;


assign tag = arb_address[15:10];
assign index = arb_address[9:7];
assign offset = arb_address[6:4];

array LRU_array
(
	.clk,
	.write(load_LRU),
	.index,
	.in(LRU_in),
	.out(LRU_out)
);

L2_write_mesh w1_write_mesh
(
	.data_out(w1_data_out),
	.memory_write(arb_wdata),
	.offset,
	.meshed_data_in(post_write_w1)
);

mux2 #(1024) data_in_w1_mux
(
	.sel(rw_mux_sel),
	.a(pmem_rdata),
	.b(post_write_w1),
	.f(w1_data_in)
);

L2_cache_way way_one
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

L2_write_mesh w2_write_mesh
(
	.data_out(w2_data_out),
	.memory_write(arb_wdata),
	.offset,
	.meshed_data_in(post_write_w2)
);

mux2 #(1024) data_in_w2_mux
(
	.sel(rw_mux_sel),
	.a(pmem_rdata),
	.b(post_write_w2),
	.f(w2_data_in)
);

L2_cache_way way_two
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


mux2 #(1024) waymux
(
	.sel(w2_hit),
	.a(w1_data_out),
	.b(w2_data_out),
	.f(waymux_out)
);

mux2 #(1024) writemux
(
	.sel(writemux_sel),
	.a(w1_data_out),
	.b(w2_data_out),
	.f(pmem_wdata)
);

mux8 #(128) rdata_mux
(
	.sel(offset),
	.a(waymux_out[127:0]),
	.b(waymux_out[255:128]),
	.c(waymux_out[383:256]),
	.d(waymux_out[511:384]),
	.e(waymux_out[639:512]),
	.f(waymux_out[767:640]),
	.g(waymux_out[895:768]),
	.h(waymux_out[1023:896]),
	.z(arb_rdata)
);

pmem_address_calc pmem_address_calc
(
	.arb_address,
	.tag_1(w1_tag_out),
	.tag_2(w2_tag_out),
	.LRU_out,
	.write_back_bit(write_back_bit),
	.pmem_address
);

L2_hit_logic L2_hit_computation
(
	.tag, 
	.w1_tag_out, 
	.w2_tag_out,
	.w1_valid_out,
	.w2_valid_out,
	.hit,
	.w2_hit
);

endmodule : L2_cache_datapath