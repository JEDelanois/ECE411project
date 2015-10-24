import lc3b_types::*;

module writeback_module
(
	input clk,
	input [15:0] currALU,
	input [15:0] MDR,
	input [15:0] currIR,
	input [15:0] currPC,
	input lc3b_control controlWord,
	input [15:0] genCC_WB,
	
	output logic [15:0] currALUout,
	output logic [15:0] MDRout,
	output logic [15:0] br_adder_out,
	output logic branch_enable

);


assign currALUout = currALU;
assign MDRout = MDR;

 lc3b_word adj9out;
 lc3b_word adj11out;
 lc3b_word adjMUXout;
logic [2:0] ccin,ccout;

//calculate branch offset
 adj #(.width(9)) adj9
(	
	.in(currIR[8:0]),
   .out (adj9out)   
);


 adj #(.width(11)) adj11
(	
	.in(currIR[10:0]),
   .out(adj11out)   
);


//DANGLE select
mux2 adjMUX
(
	/* port declaration */
	.sel(),
	.a(adj9out), 
	.b(adj11out),
	.f(adjMUXout)
);


adder branchAdder
(
	/* port declarations */
	.a(adjMUXout), 
	.b(currPC),
	.sum(br_adder_out)
);


//calculate branch_enable

gencc gencc
(
     .in(genCC_WB),
     .out(ccin)
);



register #(.width(3)) cc
(
    .clk,
    .load(),
    .in(ccin),
    .out(ccout)
);

cccomp CCcomp
(
	.testcc(currIR[11:9]), 
	.cc(ccout),
	.branch_enable(branch_enable)
);


endmodule : writeback_module