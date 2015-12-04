import lc3b_types::*;

module L2_cache_datapath
(
		input clk, load_LRU, 
		input [2:0] LRU_in,
		input [1:0] writemux_sel,
		input w1_dirty_in, w2_dirty_in, w3_dirty_in, w4_dirty_in, write_back_bit, rw_mux_sel,
		input [3:0] load_w1, load_w2, load_w3, load_w4,
		input [127:0] arb_wdata,
		input [15:0] arb_address,
		input [1023:0] pmem_rdata,
		
		//Logic values must be input
		
		output hit, w1_hit, w2_hit, w3_hit, w4_hit,
		output [2:0] LRU_out,
		output w1_dirty_out, w2_dirty_out, w3_dirty_out, w4_dirty_out,
		output [127:0] arb_rdata,
		output [15:0] pmem_address,
		output [1023:0] pmem_wdata
		
);

logic [1023:0] post_write_w1, post_write_w2, post_write_w3, post_write_w4,
					w1_data_in, w2_data_in, w3_data_in, w4_data_in,
					w1_data_out, w2_data_out, w3_data_out, w4_data_out, waymux_out;
logic [5:0] tag, w1_tag_out, w2_tag_out, w3_tag_out, w4_tag_out;
logic [2:0] offset;
logic [2:0] index;
logic [1:0] way_hit_selector;
logic w1_valid_out, w2_valid_out, w3_valid_out, w4_valid_out;


assign tag = arb_address[15:10];
assign index = arb_address[9:7];
assign offset = arb_address[6:4];

array #(3) LRU_array
(
	.clk,
	.write(load_LRU),
	.index,
	.in(LRU_in),
	.out(LRU_out)
);

/////Modules for way 1

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

/////Modules for way 2

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

/////Modules for way 3

L2_write_mesh w3_write_mesh
(
	.data_out(w3_data_out),
	.memory_write(arb_wdata),
	.offset,
	.meshed_data_in(post_write_w3)
);

mux2 #(1024) data_in_w3_mux
(
	.sel(rw_mux_sel),
	.a(pmem_rdata),
	.b(post_write_w3),
	.f(w3_data_in)
);

L2_cache_way way_three
(
		.clk,
		.dirty_in(w3_dirty_in),
		.index,
		.array_write(load_w3),
		.tag_in(tag),
		.data_in(w3_data_in),
		
		.valid_out(w3_valid_out),
		.dirty_out(w3_dirty_out),
		.tag_out(w3_tag_out),
		.data_out(w3_data_out)		
);

/////Modules for way 4

L2_write_mesh w4_write_mesh
(
	.data_out(w4_data_out),
	.memory_write(arb_wdata),
	.offset,
	.meshed_data_in(post_write_w4)
);

mux2 #(1024) data_in_w4_mux
(
	.sel(rw_mux_sel),
	.a(pmem_rdata),
	.b(post_write_w4),
	.f(w4_data_in)
);

L2_cache_way way_four
(
		.clk,
		.dirty_in(w4_dirty_in),
		.index,
		.array_write(load_w4),
		.tag_in(tag),
		.data_in(w4_data_in),
		
		.valid_out(w4_valid_out),
		.dirty_out(w4_dirty_out),
		.tag_out(w4_tag_out),
		.data_out(w4_data_out)		
);


//// Begins all modules that are used by the whole cache

mux4 #(1024) waymux
(
	.sel(way_hit_selector),
	.a(w1_data_out),
	.b(w2_data_out),
	.c(w3_data_out),
	.d(w4_data_out),
	.f(waymux_out)
);

mux4 #(1024) writemux
(
	.sel(writemux_sel),
	.a(w1_data_out),
	.b(w2_data_out),
	.c(w3_data_out),
	.d(w4_data_out),
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
	.tag_3(w3_tag_out),
	.tag_4(w4_tag_out),
	.LRU_out,
	.write_back_bit(write_back_bit),
	.pmem_address
);

L2_hit_logic L2_hit_computation
(
	.tag, 
	.w1_tag_out, 
	.w2_tag_out,
	.w3_tag_out,
	.w4_tag_out,
	.w1_valid_out,
	.w2_valid_out,
	.w3_valid_out,
	.w4_valid_out,
	.way_hit_selector,
	.hit,
	.w1_hit,
	.w2_hit,
	.w3_hit,
	.w4_hit
);

endmodule : L2_cache_datapath