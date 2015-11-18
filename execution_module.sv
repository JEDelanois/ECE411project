import lc3b_types::*;

module execution_module
(
	input lc3b_word curr_ir_in,
	input lc3b_word sr1_out,
	input lc3b_word sr2_out,
	input lc3b_word curr_pc_in,
	input lc3b_control control_word_in,
	input [2:0] EX_MEM_dest,
	input [15:0] EX_MEM_val,
	input [2:0] MEM_WB_dest,
	input [15:0] MEM_WB_val,
	
	
	
	output lc3b_word ex_sr2_out,
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
lc3b_word alumux_out,sr1mux_out, sr2mux_out,sr1LatchMmux_out, sr2LatchMmux_out, storeDataLatchMmux_out;

assign imm4 = curr_ir_in [3:0];
assign imm5 = curr_ir_in [4:0];
assign offset6 = curr_ir_in [5:0];

assign curr_ir_out = curr_ir_in;
assign curr_pc_out = curr_pc_in;
assign control_word_out = control_word_in;

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
	.sel(control_word_in.alumux_sel),
	.a(adj6_out),
	.b(sext5_out),
	.c(sext4_out),
	.d(sext6_out),
	.e(sr2_out),
	.f({12'b000000000000,imm4}),
	.g(),
	.h(),
	.z(alumux_out)
);

mux2 #(16) sr1mux
(
	.sel(),
	.a(sr1_out),
	.b(sr1LatchMmux_out),
	.f(sr1mux_out)
);

mux2 #(16) sr1LatchMmux
(
	.sel(),
	.a(EX_MEM_val),
	.b(MEM_WB_val),
	.f(sr1LatchMmux_out)
);

mux2 #(16) sr2mux
(
	.sel(),
	.a(alumux_out),
	.b(sr2LatchMmux_out),
	.f(sr2mux_out)
);

mux2 #(16) sr2LatchMmux
(
	.sel(),
	.a(EX_MEM_val),
	.b(MEM_WB_val),
	.f(sr2LatchMmux_out)
);

mux2 #(16) storeDatamux
(
	.sel(),
	.a(sr2_out),
	.b(storeDataLatchMmux_out),
	.f(ex_sr2_out)
);

mux2 #(16) storeDataLatchMmux
(
	.sel(),
	.a(EX_MEM_val),
	.b(MEM_WB_val),
	.f(storeDataLatchMmux_out)
);

/*
 * ALU
 */
alu ALU
(
	.aluop(control_word_in.aluop),
	.a(sr1mux_out),
	.b(sr2mux_out),
	.f(alu_out)
);


endmodule : execution_module
