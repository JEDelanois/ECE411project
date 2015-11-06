import lc3b_types::*;

module instruction_fetch
(
	input clk,
	input load_pc,
	input [2:0] pcmux_sel,
	input lc3b_word br_add_out,
	input lc3b_word sr1_out,
	input lc3b_word mem_rdata,
	input branch_enable,
	
	
	output lc3b_word pc_out
);

lc3b_word pcmux_out, branchmux_out;
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
mux8 #(.width(16)) pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(branchmux_out),
	.c(sr1_out),
	.d(mem_rdata),
	.e(br_add_out),
	.f(),
	.g(),
	.h(),
   .z(pcmux_out)
);


/*
 * branch mux
 */
mux2 #(.width(16)) branchmux
(
    .sel(branch_enable),
    .a(pc_plus2_out),
    .b(br_add_out),
    .f(branchmux_out)
);

endmodule : instruction_fetch
