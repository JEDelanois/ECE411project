import lc3b_types::*;

module btb_cache_way
(
	input clk,
	input [2:0] index,
	input array_write,
	input lc3b_word tag_in,
	input lc3b_word data_in,
	input logic new_predict_val,
	
	output valid_out,
	output predict_out,
	output lc3b_word tag_out,
	output lc3b_word data_out
);

array #(16) predict_pc
(
	.clk,
	.write(array_write),
	.index,
	.in(data_in),
	.out(data_out)
);

array #(16) orig_pc
(
	.clk,
	.write(array_write),
	.index,
	.in(tag_in),
	.out(tag_out)
);

array valid
(
	.clk,
	.write(array_write),
	.index,
	.in(1'b1),
	.out(valid_out)
);

array predict
(
	.clk,
	.write(array_write),
	.index,
	.in(1'b1),
	.out(predict_out)
);

endmodule : btb_cache_way