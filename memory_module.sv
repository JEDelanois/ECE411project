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




//DANGLE select
mux2 mem_addr2Mux
(
	/* port declaration */
	.sel(controlWord.memAdd2mux_sel),
	.a(currALU), 
	.b(),
	.f(mem_addr2)
);




mux2 mem_rdataMux
(
	/* port declaration */
	.sel(controlWord.mem_mdrmux_sel),
	.a(currALU), 
	.b(mem_rdata),
	.f(MDR)
);

endmodule : memory_module