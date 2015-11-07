import lc3b_types::*;

module memory_module
(
	input clk, mem_resp,
	input [15:0] currALU,
	input [15:0] currIR,
	input [15:0] currPC,
	input lc3b_control controlWord,
	input [15:0] mem_rdata,
	
	output [15:0] mem_addr2,
	output [15:0] currALUout,
	output [15:0] MDR,
	output [15:0] currIRout,
	output [15:0] currPCout,
	output lc3b_control controlWordout,
	output mem_indirect_stall,
	output mem_read,
	output mem_write
);

assign currALUout = currALU;
assign currIRout = currIR;
assign currPCout = currPC;
assign controlWordout = controlWord;

logic iMDR_load, indirect_switch, rw_switch;
logic [15:0] ldbmux_out, zextshift_out, prev_MDR, mem_addr2Mux_out;

mux2 mem_addr2Mux
(
	/* port declaration */
	.sel(controlWord.memAdd2mux_sel),
	.a(currALU), 
	.b(zextshift_out),
	.f(mem_addr2Mux_out)
);


mux2 Indirect_addr_mux
(
	/* port declaration */
	.sel(indirect_switch),
	.a(mem_addr2Mux_out), 
	.b(prev_MDR),
	.f(mem_addr2)
);



mux2 ldbmux
(
	/* port declaration */
	.sel(mem_addr2[0]),
	.a({8'b00000000,mem_rdata[7:0]}), 
	.b({8'b00000000,mem_rdata[15:8]}),
	.f(ldbmux_out)
);

zextshift zextshift
(
	.in(currIR[7:0]),
	.out(zextshift_out)
);

mux4 mem_mdrmux
(
	/* port declaration */
	.sel(controlWord.mem_mdrmux_sel),
	.a(currALU), 
	.b(mem_rdata),
	.c(ldbmux_out),
	.d(),
	.f(MDR)
);

register #(16) iMDR_register
(
	.clk(iMDR_load),
	.load(iMDR_load),
	.in(mem_rdata),
	.out(prev_MDR)
); 

indirect_logic Indirect_Logic_Module
(
		.clk(clk),
		.mem_resp(mem_resp),
		.opcode(currIR[15:12]),
		.indirect_switch(indirect_switch),
		.iMDR_load(iMDR_load),
		.mem_indirect_stall(mem_indirect_stall),
		.rw_switch(rw_switch)
);


//read write muxes
mux2 #(1) read_sig_mux
(
	/* port declaration */
	.sel(indirect_switch),
	.a(controlWord.mem2_read), 
	.b(!rw_switch),
	.f(mem_read)
);


mux2 #(1) write_sig_mux
(
	/* port declaration */
	.sel(indirect_switch),
	.a(controlWord.mem2_write), 
	.b(rw_switch),
	.f(mem_write)
);



endmodule : memory_module