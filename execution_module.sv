module execution_module
(
	input lc3b_word curr_ir_in,
	input lc3b_word sr1_out,
	input lc3b_word sr2_out,
	input lc3b_word curr_pc_in,
	input lc3b_control control_word_in,
	output lc3b_word alu_out,
	output lc3b_word curr_ir_out,
	output lc3b_word curr_pc_out,
	output lc3b_control control_word_out
);

/* NOTE: aluop and alumux_sel are undefined. need to define control word first */

lc3b_imm4 imm4;
lc3b_word sext4_out;

lc3b_imm5 imm5;
lc3b_word sext5_out;

lc3b_offset6 offset6;
lc3b_word adj6_out;
lc3b_word sext6_out;

lc3b_aluop aluop;

logic [2:0] alumux_sel;
lc3b_word alumux_out;

assign imm4 = curr_ir_in [3:0];
assign imm5 = curr_ir_in [4:0];
assign offset6 = curr_ir_in [5:0];

/*
 * Sign extend imm4
 */
sext #(.width(4)) sext4
(
	.in(imm4),
	.out(sext4_out)
);

/*
 * Sign extend 5 bit
 */
sext #(.width(5)) sext5
(
	.in(imm5),
	.out(sext5_out)
);

/*
 * Sign Extended 6 bit
 */
adj #(.width(6)) adj6
(
	.in(offset6),
	.out(adj6_out)
);

/*
 * Sign extend offset6
 */
sext #(.width(6)) sext6
(
	.in(offset6),
	.out(sext6_out)
);

mux8 #(16) alumuux
(
	.sel(alumux_sel),
	.a(adj6_out),
	.b(sext5_out),
	.c(sext4_out),
	.d(sext6_out),
	.e(sr2_out),
	.f(),
	.g(),
	.h(),
	.z(alumux_out)
);

/*
 * ALU
 */
alu ALU
(
	.aluop,
	.a(sr1_out),
	.b(alumux_out),
	.f(alu_out)
);


endmodule : execution_module
