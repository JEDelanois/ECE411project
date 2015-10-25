import lc3b_types::*;

module latch_ex_mem
(
	input logic clk, load_latch,
	input lc3b_word IR_in, PC_in, ALU_in,
    input lc3b_control CW_in,
	output lc3b_word IR_out, PC_out, ALU_out,
    output lc3b_control CW_out
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


register ALU
(
    .clk(clk),
    .load(load_latch),
    .in(ALU_in),
    .out(ALU_out)
);

register #(CONTROL_WIDTH) CW
(
	.clk(clk),
	.load(load_latch),
	.in(CW_in),
	.out(CW_out)
);

endmodule : latch_ex_mem