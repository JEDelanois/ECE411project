import lc3b_types::*;

module instruction_fetch
(
	input clk,
	input resp_a,
	input flow_IFID,
	input load_pc,
	input force_pc_load,
	input [2:0] pcmux_sel,
	input lc3b_word br_add_out,
	input lc3b_word sr1_out,
	input lc3b_word final_MDR,
	input lc3b_word mem_rdata,
	input branch_enable,
	
	
	output lc3b_word pc_out,
	output logic mem_read1,
	output logic stall_fetch,
	output logic inject_NOP
);

lc3b_word pcmux_out, branchmux_out;
lc3b_word pc_plus2_out;


Cache1_cont cache1_cont
(
    .resp_a(resp_a),
	 
    
	 .mem_read1(mem_read1),
	 .stall_fetch(stall_fetch),
	 .inject_NOP(inject_NOP)
);



/*
 * PC
 */
register pc
(
    .clk,
    .load(force_pc_load||((load_pc && flow_IFID)||branch_enable)),
    .in(pcmux_out),
    .out(pc_out)
);

/*
 * PC increment
 */
plus2 pc_plus2
(
	.in(pc_out),
	.out(pc_plus2_out)
);

/*
 * PC mux
 */
mux8 #(.width(16)) pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(branchmux_out),
	.c(sr1_out),
	.d(mem_rdata),
	.e(br_add_out),
	.f(final_MDR),
	.g(),
	.h(),
   .z(pcmux_out)
);


/*
 * branch mux
 */
mux2 #(.width(16)) branchmux
(
    .sel(branch_enable),
    .a(pc_plus2_out),
    .b(br_add_out),
    .f(branchmux_out)
);

endmodule : instruction_fetch
