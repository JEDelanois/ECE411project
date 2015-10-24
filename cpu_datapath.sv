module cpu_datapath
(
		input clk
);

lc3b_word mem_rdata, pc_out;

instruction_fetch IF_Logic
(
	.clk(),
	.load_pc(),
	.pcmux_sel(),
	.br_add_out(),
	.sr1_out(),
	.mem_rdata(mem_rdata),
	.pc_out(pc_out)
);

latch_if_id IF_ID_Latch
(
		.clk(clk),
		.load_latch(),
		.IR_in(mem_rdata),
		.PC_in(pc_out),
		.IR_out(),
		.PC_out()
);


instruction_decode ID_Logic
(
		.clk(clk),
		.IR(),
		.data_in(),
		.mem_control(),
		/* input lc3b_word pc, adj_pc, alu_out,*/ //Used for complex instructions loading into regfile
		.sr1(),
		.sr2(),
		.IR_post(),
		.control_word()
);

latch_id_ex ID_EX_Latch
(
		.clk(clk)
);


execution_module EX_module
();

latch_ex_mem EX_MEM_Latch
(
		.clk(clk)
);


memory_module Mem_Module
();

latch_wb WB_latch
(
		.clk(clk)
);

writeback_module WB_Module
();

endmodule : cpu_datapath