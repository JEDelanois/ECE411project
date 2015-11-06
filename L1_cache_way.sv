import lc3b_types ::*;

module L1_cache_way
(
		input clk, dirty_in,
		input [2:0] index,
		input [3:0] array_write,
		input [8:0] tag_in,
		input [127:0] data_in,
		
		output valid_out, dirty_out,
		output [8:0] tag_out,
		output [127:0] data_out		
);

array #(128) data
(
	.clk,
	.write(array_write[0]),
	.index,
	.in(data_in),
	.out(data_out)
);

array #(9) tag
(
	.clk,
	.write(array_write[1]),
	.index,
	.in(tag_in),
	.out(tag_out)
);

array valid
(
	.clk,
	.write(array_write[2]),
	.index,
	.in(1'b1),
	.out(valid_out)
);

array dirty
(
	.clk,
	.write(array_write[3]),
	.index,
	.in(dirty_in),
	.out(dirty_out)
);


endmodule : L1_cache_way