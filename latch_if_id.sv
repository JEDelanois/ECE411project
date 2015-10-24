import lc3b_types::*;

module latch_if_id
(
	input logic clk, load_latch,
	input lc3b_word IR_in, PC_in,
	output lc3b_word IR_out, PC_out
);

register IR
(
    .clk(clk),
    .load(load_latch),
    .in(IR_in),
    .out(IR_out)
);


register PC
(
    .clk(clk),
    .load(load_latch),
    .in(PC_in),
    .out(PC_out)
);


endmodule : latch_if_id