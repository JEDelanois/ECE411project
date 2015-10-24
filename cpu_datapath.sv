module cpu_datapath
(
		input clk
);

lc3b_word mem_rdata, pc_out, IF_IR, IF_EX_PC; // IF/ID wires
lc3b_word ID_SR1, ID_SR2, ID_CW, ID_IR, IR_EX, PC_EX, SR1_EX, SR2_EX, CW_EX; // ID/EX wires
lc3b_word EX_IR; // EX/MEM wires

instruction_fetch IF_Logic
(
		.clk(clk),
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
		.load_latch(clk),
		.IR_in(mem_rdata),
		.PC_in(pc_out),
		.IR_out(IF_IR),
		.PC_out(IF_EX_PC)
);


instruction_decode ID_Logic
(
		.clk(clk),
		.IR(IF_IR),
		.data_in(),
		.mem_control(),	/* mem_control is the control to decide when to load regfile, from the writeback section */
		/* input lc3b_word pc, adj_pc, alu_out,*/ //Used for complex instructions loading into regfile
		.sr1(ID_SR1),
		.sr2(ID_SR2),
		.IR_post(ID_IR),
		.control_word(ID_CW)
);

latch_id_ex ID_EX_Latch
(
		.clk(clk),
		.load_latch(clk),
		.IR_in(ID_IR),
		.PC_in(IF_EX_PC),
		.CW_in(ID_CW),
		.SR1_in(ID_SR1),
		.SR2_in(ID_SR2),
		.IR_out(IR_EX),
		.PC_out(PC_EX),
		.CW_out(CW_EX),
		.SR1_out(SR1_EX),
		.SR2_out(SR2_EX)
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