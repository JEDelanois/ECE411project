import lc3b_types::*;

module memory_module
(
	input clk,
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
	output lc3b_control controlWordout
);

assign currALUout = currALU;
assign currIRout = currIR;
assign currPCout = currPC;
assign controlWordout = controlWord;


logic [15:0] ldbmux_out;

mux2 mem_addr2Mux
(
	/* port declaration */
	.sel(controlWord.memAdd2mux_sel),
	.a(currALU), 
	.b(),
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

endmodule : memory_module