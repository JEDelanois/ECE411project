import lc3b_types::*;

module cpu_datapath
(
		input clk,
		input resp_a,
		input resp_b,
		output lc3b_word mem_addr1,
		output logic mem_read1,
		input lc3b_word mem_rdata1,
		output lc3b_word mem_addr2,
		output logic mem_read2,
		output logic mem_write2,
		input lc3b_word mem_rdata2,
		output lc3b_word mem_wdata2,
		output lc3b_mem_wmask mem_byte_enable2
);

// IF/ID wires
lc3b_word pc_out, IF_IR, IF_EX_PC;
// ID/EX wires
lc3b_word ID_SR1, ID_SR2, ID_IR, IR_EX, PC_EX, SR1_EX, SR2_EX, SR2_MEM;
// EX/MEM wires
lc3b_word EX_IR, EX_PC, EX_ALU, MEM_IR, MEM_PC, MEM_ALU,ex_sr2_out;
// MEM/WB wires
lc3b_word IR_MEM, PC_MEM, ALU_MEM, MDR_MEM, WB_IR, WB_PC, WB_ALU, WB_MDR, final_MDR, genCC_WB,ALUin;
logic flow_X, stall_X, branch_enable, mem_indirect_stall,flow_IFID, flow_IDEX, flow_EXMEM, flow_MEMWB, stall_fetch, inject_NOP, gen_bubble,squash_instruction;
lc3b_word br_adder_out;
logic squash_IF_ID;
logic stall_cache2_miss;
logic btb_pc_load;
lc3b_word predicted_pc;
logic stall_cache2_miss_delay;
logic IF_ID_branch_predict_status, ID_EX_branch_predict_status, EX_MEM_branch_predict_status, MEM_WB_branch_predict_status;
//Control Word typing for register wires
lc3b_control CW_EX, MEM_CW, ID_CW, EX_CW, CW_MEM, WB_CW;

assign mem_addr1 = pc_out;
assign mem_wdata2 = SR2_MEM;
assign mem_byte_enable2 = MEM_CW.mem_byte_enable;
assign stall_cache2_miss = (mem_read2 || mem_write2) && (!resp_b);

btb btb
(
	.clk,
	.curr_pc(pc_out),
	.loaded_pc(WB_PC),
	.loaded_predict_pc(br_adder_out),
	.loaded_predict(1'b0),
	.load_line(WB_IR[15:12] == 4'b0 && WB_IR != 16'b0 && !(stall_cache2_miss_delay & resp_b)),
	.new_predict_val(squash_instruction),
	.btb_pc_load(btb_pc_load),
	.predicted_pc(predicted_pc)
);

flow_control flow_control
(
	 .clk(clk),
	 .mem_indirect_stall(mem_indirect_stall),	
	 .stall_fetch(stall_fetch),
	 .gen_bubble(gen_bubble),
	 .flow_IFID(flow_IFID), 
	 .flow_IDEX(flow_IDEX), 
	 .flow_EXMEM(flow_EXMEM), 
	 .flow_MEMWB(flow_MEMWB),
	 .flow_X(flow_X),
	 .stall_cache2_miss(stall_cache2_miss),
	 .stall_X(stall_X)// stall when you are reading or writing and there is a cache miss 
);


bubbler bubbler
(
	.clk(clk),
	.IF_ID_ir(IF_IR),
	.ID_EX_ir(IR_EX),
	.branch_enable(branch_enable | squash_instruction),
	.flow_ID_EX(flow_IDEX),
	.gen_bubble(gen_bubble)
);


instruction_fetch IF_Logic
(
		.clk(clk),
		.resp_a(resp_a),
		.flow_IFID(flow_IFID),
		.load_pc(1'b1),
		.force_pc_load(WB_CW.force_pc_load),
		.pcmux_sel(WB_CW.PCmux_sel),
		.br_add_out(br_adder_out),
		.sr1_out(WB_ALU),
		.final_MDR(final_MDR),
		.mem_rdata(mem_rdata2),
		.branch_enable(branch_enable),
		.btb_pc_load(btb_pc_load),
		.predicted_pc(predicted_pc),
		.pc_out(pc_out),
		.mem_read1(mem_read1),
		.stall_fetch(stall_fetch),
		.inject_NOP(inject_NOP)
);

latch_if_id IF_ID_Latch
(
		.clk(clk),
		.load_latch(flow_IFID),
		.IR_in(mem_rdata1),
		.PC_in(pc_out + 4'h2),
		.inject_NOP(inject_NOP),
		.squash_instruction(squash_instruction),
		.branch_predict_status_in(branch_enable),
		.IR_out(IF_IR),
		.PC_out(IF_EX_PC),
		.squash_IF_ID(squash_IF_ID),
		.branch_predict_status_out(IF_ID_branch_predict_status)
);


instruction_decode ID_Logic
(
		.clk(clk),
		.IR(IF_IR),
		.WB_IR(WB_IR),
		.data_in(final_MDR),
		.WB_pcin(WB_PC),
		.WB_br_adder_out(br_adder_out),
		.mem_control(WB_CW.regFile_load),
		.mem_select(WB_CW.regFilemux_sel),
		.wb_dest_sel(WB_CW.destmux_sel),
		.gen_bubble(gen_bubble),
		.squash_ID(squash_IF_ID & !inject_NOP),
		
		
		.sr1(ID_SR1),
		.sr2(ID_SR2),
		.IR_post(ID_IR),
		.control_word(ID_CW),
		.genCC_WB(genCC_WB)
);

latch_id_ex ID_EX_Latch
(
		.clk(clk),
		.load_latch(flow_IDEX),
		.IR_in(ID_IR),
		.PC_in(IF_EX_PC),
		.CW_in(ID_CW),
		.squash_instruction(squash_instruction),
		.branch_predict_status_in(IF_ID_branch_predict_status),
		.SR1_in(ID_SR1),
		.SR2_in(ID_SR2),
		.IR_out(IR_EX),
		.PC_out(PC_EX),
		.CW_out(CW_EX),
		.SR1_out(SR1_EX),
		.SR2_out(SR2_EX),
		.branch_predict_status_out(ID_EX_branch_predict_status)
);


execution_module EX_module
(
	.clk(clk),
	.curr_ir_in(IR_EX),
	.sr1_out(SR1_EX),
	.sr2_out(SR2_EX),
	.curr_pc_in(PC_EX),
	.control_word_in(CW_EX),
	.flow_X(flow_X),	

	.EX_MEM_ir(MEM_IR),
	.EX_MEM_val(MEM_ALU),
	.MEM_WB_ir(WB_IR),
	.MEM_WB_val(genCC_WB),
	
	.ex_sr2_out(ex_sr2_out),
	.alu_out(EX_ALU),
	.curr_ir_out(EX_IR),
	.curr_pc_out(EX_PC),
	.control_word_out(EX_CW),
	.stall_X(stall_X)
);

latch_ex_mem EX_MEM_Latch
(
		.clk(clk),
		.load_latch(flow_EXMEM),
		.IR_in(EX_IR),
		.PC_in(EX_PC),
		.ALU_in(EX_ALU),
		.sr2_in(ex_sr2_out),
		.CW_in(EX_CW),
		.squash_instruction(squash_instruction),
		.branch_predict_status_in(ID_EX_branch_predict_status),
		.IR_out(MEM_IR),
		.PC_out(MEM_PC),
		.ALU_out(MEM_ALU),
		.sr2_out(SR2_MEM),
		.CW_out(MEM_CW),
		.branch_predict_status_out(EX_MEM_branch_predict_status)
);


memory_module Mem_Module
(
		.clk(clk),
		.mem_resp(resp_b),
		.currALU(MEM_ALU),
		.currIR(MEM_IR),
		.currPC(MEM_PC),
		.controlWord(MEM_CW),
		.mem_rdata(mem_rdata2),
		.mem_addr2(mem_addr2),
		.currALUout(ALU_MEM),
		.MDR(MDR_MEM),
		.currIRout(IR_MEM),
		.currPCout(PC_MEM),
		.controlWordout(CW_MEM),
		.mem_indirect_stall(mem_indirect_stall),
		.mem_read(mem_read2),
	   .mem_write(mem_write2)
);



latch_wb MEM_WB_latch
(
		.clk(clk),
		.load_latch(flow_MEMWB),
		.IR_in(IR_MEM),
		.PC_in(PC_MEM),
		.ALU_in(ALU_MEM),
		.MDR_in(MDR_MEM),
		.CW_in(CW_MEM),
		.squash_instruction(squash_instruction),
		.stall_fetch(stall_fetch),
		.stall_cache2_miss(stall_cache2_miss),
		.resp_b(resp_b),
		.branch_predict_status_in(EX_MEM_branch_predict_status),
		.IR_out(WB_IR),
		.PC_out(WB_PC),
		.ALU_out(WB_ALU),
		.MDR_out(WB_MDR),
		.CW_out(WB_CW),
		.branch_predict_status_out(MEM_WB_branch_predict_status),
		.stall_cache2_miss_delay(stall_cache2_miss_delay)
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
		.branch_predict_status(MEM_WB_branch_predict_status),

		.currALUout(ALUin),
		.MDRout(final_MDR),
		.br_adder_out(br_adder_out),
		.branch_enable(branch_enable),
		.squash_instruction(squash_instruction)
);

endmodule : cpu_datapath
