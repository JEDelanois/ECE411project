import lc3b_types::*;

module cpu_datapath
(
		input clk,
		output lc3b_word mem_addr1,
		output logic mem_read1,
		input lc3b_word mem_rdata1,
		output lc3b_word mem_addr2,
		output logic mem_read2,
		output logic mem_write2,
		input lc3b_word mem_rdata2,
		output lc3b_word mem_wdata2
);

lc3b_word pc_out, IF_IR, IF_EX_PC; // IF/ID wires
lc3b_word ID_SR1, ID_SR2, ID_IR, IR_EX, PC_EX, SR1_EX, SR2_EX; // ID/EX wires
lc3b_word EX_IR, EX_PC, EX_ALU, MEM_IR, MEM_PC, MEM_ALU ; // EX/MEM wires
lc3b_word IR_MEM, PC_MEM, ALU_MEM, MDR_MEM, WB_IR, WB_PC, WB_ALU, WB_MDR, final_MDR, genCC_WB,branch_enable,ALUin; // MEM/WB wires
lc3b_control CW_EX, MEM_CW, ID_CW, EX_CW, CW_MEM, WB_CW; //Control Word typing for register wires

assign mem_read1 = clk;
assign mem_addr1 = pc_out;

instruction_fetch IF_Logic
(
		.clk(clk),
		.load_pc(clk),
		.pcmux_sel({1'b1, branch_enable}),
		.br_add_out(br_adder_out),
		.sr1_out(),
		.mem_rdata(mem_rdata2),
		.pc_out(pc_out)
);

latch_if_id IF_ID_Latch
(
		.clk(clk),
		.load_latch(clk),
		.IR_in(mem_rdata1),
		.PC_in(pc_out),
		.IR_out(IF_IR),
		.PC_out(IF_EX_PC)
);


instruction_decode ID_Logic
(
		.clk(clk),
		.IR(IF_IR),
		.data_in(final_MDR),
		.mem_control(WB_CW.regFile_load),	/* mem_control is the control to decide when to load regfile, from the writeback section */
		/* input lc3b_word pc, adj_pc, alu_out,*/ //Used for complex instructions loading into regfile
		.sr1(ID_SR1),
		.sr2(ID_SR2),
		.IR_post(ID_IR),
		.control_word(ID_CW),
		.genCC_WB(genCC_WB)
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
		.load_latch(clk),
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
(
		.clk(clk),
		.currALU(MEM_ALU),
		.currIR(MEM_IR),
		.currPC(MEM_PC),
		.controlWord(MEM_CW),
		.mem_rdata(mem_rdata2),
		.mem_addr2(mem_addr2),
		.mem_read2(mem_read2),																				//These two signals need to me connected to memory
		.mem_write2(mem_write2),
		.currALUout(ALU_MEM),
		.MDR(MDR_MEM),
		.currIRout(IR_MEM),
		.currPCout(PC_MEM),
		.controlWordout(CW_MEM)
);

assign mem_wdata2 = MDR_MEM;

latch_wb WB_latch
(
		.clk(clk),
		.load_latch(clk),
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
(
		.clk(clk),
		.currALU(WB_ALU),
		.MDR(WB_MDR),
		.currIR(WB_IR),
		.currPC(WB_PC),
		.controlWord(WB_CW),
		.genCC_WB(genCC_WB),
		
		.currALUout(ALUin),
		.MDRout(final_MDR),
		.br_adder_out(br_adder_out),
		.branch_enable(branch_enable)
);

endmodule : cpu_datapath
