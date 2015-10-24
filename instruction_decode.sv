import lc3b_types::*;

module instruction_decode
(
		input logic clk,
		input lc3b_word IR,
		input lc3b_word data_in,
		input logic mem_control,
		/* input lc3b_word pc, adj_pc, alu_out,*/ //Used for complex instructions loading into regfile
		output lc3b_word sr1, sr2,
		output lc3b_word IR_post,
		output lc3b_control control_word
);

lc3b_reg src_a, dest;
lc3b_word regfile_mux_out;

assign IR_post = IR;

gen_control Control_Generator
(
	.opcode(IR[15:12]),
	.control_word(control_word)
);

/* Register File and corresponding muxes */
regfile LC3b_RegFile
(
		.clk(clk),
		.load(/*Comes from control of the wb stage*/),
		.in(regfile_mux_out),
		.src_a(src_a), 
		.src_b(IR[2:0]), 
		.dest(dest),
		.reg_a(sr1), 
		.reg_b(sr2)
);

mux2 #(3) sr1_mux
(
		.sel(/* Corresponding bits from the control word */),
		.a(IR[8:6]),
		.b(IR[11:9]), /* DOUBLE CHECK THIS IS CORRECT */
		.f(src_a)
);

mux2 #(3) dest_mux
(
		.sel(/* Corresponding bits from the control word*/),
		.a(IR[11:9]),
		.b(3'b111),
		.f(dest)
);

mux8 regfile_load_mux
(
		.sel(/*Comes from control of the wb stage*/),
		.a(data_in),
		.b(),
		.c(),
		.d(),
		.e(),
		.f(),
		.g(),
		.h(),
		.z(regfile_mux_out)
);
endmodule : instruction_decode