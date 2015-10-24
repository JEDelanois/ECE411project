module memory_module
(
	input clk,
	input [15:0] currALU,
	input [15:0] currIR,
	input [15:0] currPC,
	input lc3b_control controlWord,
	input [15:0] mem_rdata,
	
	output [15:0] mem_addr2,
	output logic mem_read2,
	output logic mem_write2,
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


/* Temporary assignments until control figured out */
assign mem_read2 = 0;
assign mem_write2 = 0;

//DANGLE select
mux2 mem_addr2Mux
(
	/* port declaration */
	.sel(1'b1),
	.a(currALU), 
	.b(),
	.f(mem_addr2)
);



//DANGLE select
mux2 mem_rdataMux
(
	/* port declaration */
	.sel(),
	.a(currALU), 
	.b(mem_rdata),
	.f(MDR)
);

endmodule : memory_module