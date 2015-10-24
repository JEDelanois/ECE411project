import lc3b_types::*;

module instruction_fetch
(
	input clk,
	input load_pc,
	input [1:0] pcmux_sel,
	input lc3b_word br_add_out,
	input lc3b_word sr1_out,
	input lc3b_word mem_rdata,
	output lc3b_word pc_out
);

lc3b_word pcmux_out;
lc3b_word pc_plus2_out;

/*
 * PC
 */
register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);

/*
 * PC increment
 */
plus2 pc_plus2
(
	.in(pc_out),
	.out(pc_plus2_out)
);

/*
 * PC mux
 */
mux4 #(.width(16)) pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(br_add_out),
	.c(sr1_out),
	.d(mem_rdata),
    .f(pcmux_out)
);

endmodule : instruction_fetch
