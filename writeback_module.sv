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
	input logic branch_predict_status,
	
	output logic [15:0] currALUout,
	output logic [15:0] MDRout,
	output logic [15:0] br_adder_out,
	output logic branch_enable,
	output logic squash_instruction

);

logic compare;
lc3b_word br_adder_result;

assign currALUout = currALU;
assign MDRout = MDR;
assign branch_enable = (compare&(currIR[15:12] == 4'b0000)& currIR != 16'b0);
assign squash_instruction = (branch_enable || (controlWord.opcode == op_jmp) || (controlWord.opcode == op_jsr) || (controlWord.opcode == op_jmp) || (controlWord.opcode == op_trap));

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



mux2 adjMUX
(
	/* port declaration */
	.sel(controlWord.adjmux_sel),
	.a(adj9out), 
	.b(adj11out),
	.f(adjMUXout)
);


adder branchAdder
(
	/* port declarations */
	.a(adjMUXout), 
	.b(currPC),
	.sum(br_adder_result)
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
    .load(controlWord.cc_load),
    .in(ccin),
    .out(ccout)
);

cccomp CCcomp
(
	.testcc(currIR[11:9]), 
	.cc(ccout),
	.branch_enable(compare)
);

always_comb
begin
	if (branch_predict_status & !branch_enable)
		br_adder_out = currPC;
	else
		br_adder_out = br_adder_result;
end

endmodule : writeback_module