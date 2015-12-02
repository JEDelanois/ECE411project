import lc3b_types::*;

module execution_module
(
	input clk,
	input lc3b_word curr_ir_in,
	input lc3b_word sr1_out,
	input lc3b_word sr2_out,
	input lc3b_word curr_pc_in,
	input lc3b_control control_word_in,
	input [15:0] EX_MEM_ir,
	input [15:0] EX_MEM_val,
	input [15:0] MEM_WB_ir,
	input [15:0] MEM_WB_val,
	input flow_X,	
	
	
	output lc3b_word ex_sr2_out,
	output lc3b_word alu_out,
	output lc3b_word curr_ir_out,
	output lc3b_word curr_pc_out,
	output lc3b_control control_word_out,
	output logic stall_X
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
lc3b_word alumux_out,sr1mux_out, sr2mux_out,sr1LatchMmux_out, sr2LatchMmux_out, storeDataLatchMmux_out, divmult_out, reg_alu_out;
logic sr1mux_sel, sr2mux_sel, sr1_forwardLatchMux_sel, sr2_forwardLatchMux_sel,storeDataMux_sel,storeDataLatchMux_sel;


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

forwardingLogic forwardingLogic
(
	.ir(curr_ir_in),
	.EX_MEM_ir(EX_MEM_ir),
	.EX_MEM_val(EX_MEM_val),
	.MEM_WB_ir(MEM_WB_ir),
	.MEM_WB_val(MEM_WB_val),
	
	.sr1mux_sel(sr1mux_sel),
	.sr2mux_sel(sr2mux_sel),
	.sr1_forwardLatchMux_sel(sr1_forwardLatchMux_sel),
	.sr2_forwardLatchMux_sel(sr2_forwardLatchMux_sel),
	.storeDataMux_sel(storeDataMux_sel),  //used for the 3 store functions
	.storeDataLatchMux_sel(storeDataLatchMux_sel)

);

mux2 #(16) sr1mux
(
	.sel(sr1mux_sel),
	.a(sr1_out),
	.b(sr1LatchMmux_out),
	.f(sr1mux_out)
);

mux2 #(16) sr1LatchMmux
(
	.sel(sr1_forwardLatchMux_sel),
	.a(EX_MEM_val),
	.b(MEM_WB_val),
	.f(sr1LatchMmux_out)
);

mux2 #(16) sr2mux
(
	.sel(sr2mux_sel),
	.a(alumux_out),
	.b(sr2LatchMmux_out),
	.f(sr2mux_out)
);

mux2 #(16) sr2LatchMmux
(
	.sel(sr2_forwardLatchMux_sel),
	.a(EX_MEM_val),
	.b(MEM_WB_val),
	.f(sr2LatchMmux_out)
);

mux2 #(16) storeDatamux
(
	.sel(storeDataMux_sel),
	.a(sr2_out),
	.b(storeDataLatchMmux_out),
	.f(ex_sr2_out)
);

mux2 #(16) storeDataLatchMmux
(
	.sel(storeDataLatchMux_sel),
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
	.f(reg_alu_out)
);


//multiplication unit
DivMultUnit divmultuinit
(
	.clk(clk),
	.sr1(sr1mux_out), 
	.sr2(sr2mux_out),
	.aluop(control_word_in.aluop),
	.flow(flow_X),

	.solution(divmult_out),
	.stall_X(stall_X)
);

mux2 #(16) aluselector
(
	.sel((control_word_in.aluop == alu_mult) || (control_word_in.aluop == alu_div)),
	.a(reg_alu_out),
	.b(divmult_out),
	.f(alu_out)
);

endmodule : execution_module
