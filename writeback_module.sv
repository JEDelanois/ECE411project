module writeback_module
(
	input [15:0] currALU,
	input [15:0] MDR,
	input [15:0] currIR,
	input [15:0] currPC,
	input [15:0] lc3b_control,
	input [15:0] genCC_WB,
	
	output logic [15:0] currALUout
	output logic [15:0] MDRout
	output logic [15:0] br_adder_out,
	output logic branch_enable;

);


assign currALUout = currALU;
assign MDRout = MDR;

logic lc3b_word adj9out;
logic lc3b_word adj11out;
logic lc3b_word adjMUXout;
logic [2:0] ccin,ccout;

//calculate branch offset
 adj (parameter = 9) adj9
(	
	in (currIR[8:0]),
   out (adj9out)   
);


 adj (parameter = 11) adj11
(	
	in (currIR[10:0]),
   out (adj11out)   
);


//DANGLE select
mux2 adjMUX
(
	/* port declaration */
	sel(),
	a(adj9out), 
	b(adj11out),
	f(adjMUXout)
);


adder branchAdder
(
	/* port declarations */
	a(adjMUXout), 
	b(currPC),
	sum(br_adder_out)
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

CCCOMP cccomp
(
	.dest(currIR[11:9]), 
	.cc(ccout),
	.branch_enable(branch_enable)
);


endmodule : writeback_module