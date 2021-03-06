import lc3b_types::*;

module instruction_decode
(
		input logic clk,
		input lc3b_word IR, WB_IR,
		input lc3b_word data_in,
		input lc3b_word WB_pcin,
		input lc3b_word WB_br_adder_out,
		input logic mem_control,
		input logic [1:0] mem_select,
		input logic wb_dest_sel,
		input gen_bubble,
		input squash_ID,
		
		/* input lc3b_word pc, adj_pc, alu_out,*/ //Used for complex instructions loading into regfile
		output lc3b_word sr1, sr2,
		output lc3b_word IR_post,
		output lc3b_control control_word,
		output lc3b_word genCC_WB
);

lc3b_reg src_a,src_b, dest;
lc3b_word regfile_mux_out, controlBubbleMux_out;


assign genCC_WB = regfile_mux_out;

gen_control Control_Generator
(
	.opcode(controlBubbleMux_out[15:12]),
	.IRbits(controlBubbleMux_out[11:0]),
	.ctrl(control_word)
);


mux2 controlBubbleMux
(
	.sel(gen_bubble || squash_ID),
	.a(IR), 
	.b(16'b0000000000000000),
	.f(controlBubbleMux_out)
);


mux2 IRBubbleMux
(
	.sel(gen_bubble || squash_ID),
	.a(IR), 
	.b(16'b0000000000000000),
	.f(IR_post)
);

/* Register File and corresponding muxes */
regfile LC3b_RegFile
(
		.clk(clk),
		.load(/*Comes from control of the wb stage*/mem_control),
		.in(regfile_mux_out),
		.src_a(src_a), 
		.src_b(src_b), 
		.dest(dest),
		.reg_a(sr1), 
		.reg_b(sr2)
);

mux2 #(3) sr1_mux
(
		.sel(control_word.sr1mux_sel),
		.a(IR[8:6]),
		.b(IR[11:9]), /* DOUBLE CHECK THIS IS CORRECT */
		.f(src_a)
);

mux2 #(3) sr2_mux
(
		.sel(control_word.sr2mux_sel),
		.a(IR[2:0]),
		.b(IR[11:9]), /* DOUBLE CHECK THIS IS CORRECT */
		.f(src_b)
);


mux2 #(3) dest_mux
(
		.sel(wb_dest_sel),
		.a(WB_IR[11:9]),
		.b(3'b111),
		.f(dest)
);

mux4 regfile_load_mux
(
		.sel(mem_select),
		.a(data_in),
		.b(WB_pcin),
		.c(WB_br_adder_out),
		.d(),
		.f(regfile_mux_out)
);
endmodule : instruction_decode