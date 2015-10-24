module cpu_datapath
(
		input clk
);

lc3b_word mem_rdata, pc_out, IF_IR, IF_EX_PC; // IF/ID wires
lc3b_word ID_SR1, ID_SR2, ID_CW, ID_IR, IR_EX, PC_EX, SR1_EX, SR2_EX, CW_EX; // ID/EX wires
lc3b_word EX_IR, EX_PC, EX_ALU, EX_CW, MEM_IR, MEM_PC, MEM_ALU, MEM_CW; // EX/MEM wires
lc3b_word IR_MEM, PC_MEM, ALU_MEM, CW_MEM, MDR_MEM, WB_IR, WB_PC, WB_ALU, WB_CW, WB_MDR; // MEM/WB wires

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
(
	.curr_ir_in(IR_EX),
	.sr1_out(SR1_EX),
	.sr2_out(SR2_EX),
	.curr_pc_in(PC_EX),
	.control_word_in(CW_EX),
	.alu_out(EX_ALU),
	.curr_ir_out(EX_IR),
	.curr_pc_out(EX_PC),
	.control_word_out(EX_CW)
);

latch_ex_mem EX_MEM_Latch
(
		.clk(clk),
		.latch_load(clk),
		.IR_in(EX_IR),
		.PC_in(EX_PC),
		.ALU_in(EX_ALU),
		.CW_in(EX_CW),
		.IR_out(MEM_IR),
		.PC_out(MEM_PC),
		.ALU_out(MEM_ALU),
		.CW_out(MEM_CW)
);


memory_module Mem_Module
();

latch_wb WB_latch
(
		.clk(clk),
		.latch_load(clk),
		.IR_in(IR_MEM),
		.PC_in(PC_MEM),
		.ALU_in(ALU_MEM),
		.CW_in(CW_MEM),
		.MDR_in(MDR_MEM),
		.IR_out(WB_IR),
		.PC_out(WB_PC),
		.ALU_out(WB_ALU),
		.CW_out(WB_CW),
		.MDR_out(WB_MDR)
);

writeback_module WB_Module
();

magic_memory_dp magic_memory_dp
(
    .clk,

    /* Port A */
    .read_a,
    .write_a,
    .wmask_a,
    .address_a,
    .wdata_a,
    .resp_a,
    .rdata_a,

    /* Port B */
    .read_b,
    .write_b,
    .wmask_b,
    .address_b,
    .wdata_b,
    .resp_b,
    .rdata_b
);

endmodule : cpu_datapath