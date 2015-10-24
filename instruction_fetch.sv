module instruction_fetch
(
	input clk,
	input load_pc,
	input pcmux_out,
	output logic pc_out
);

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

endmodule : instruction_fetch