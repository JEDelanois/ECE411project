import lc3b_types::*;

module DivMultUnit 
(
input clk,
input [15:0] sr1, sr2,
input lc3b_aluop aluop,
input flow,

output logic [15:0] solution,
output logic stall_X
);

logic calc_done, sr1_load, sr2_load, sol_load;
logic[1:0] state, sr1mux_sel, sr2mux_sel, solmux_sel, bmux_sel;
lc3b_aluop mini_aluop;
logic [15:0] sr1reg_out, sr2reg_out, solreg_out, sr1mux_out, sr2mux_out, solmux_out, bmux_out, mini_alu_out;

assign solution = solreg_out;
assign stall_X = (((aluop == alu_mult)||(aluop == alu_div)) && (calc_done == 1'b0));


mux4 sr1mux
(
	/* port declaration */
	.sel(sr1mux_sel),
	.a(sr1), 
	.b(mini_alu_out), 
	.c(), 
	.d(16'b0000000000000000),
	.f(sr1mux_out)
);
register sr1reg
(
    .clk(clk),
    .load(sr1_load),
    .in(sr1mux_out),
    .out(sr1reg_out)
);

mux4 sr2mux
(
	/* port declaration */
	.sel(sr2mux_sel),
	.a(sr2), 
	.b(sr2reg_out - 16'b0000000000000001), 
	.c(), 
	.d(16'b0000000000000000),
	.f(sr2mux_out)
);
register sr2reg
(
    .clk(clk),
    .load(sr2_load),
    .in(sr2mux_out),
    .out(sr2reg_out)
);

mux4 solmux
(
	/* port declaration */
	.sel(solmux_sel),
	.a(mini_alu_out), 
	.b(solreg_out + 16'b0000000000000001), 
	.c(), 
	.d(16'b0000000000000000),
	.f(solmux_out_out)
);

register solreg
(
    .clk(clk),
    .load(sol_load),
    .in(solmux_out_out),
    .out(solreg_out)
);

mux4 bmux
(
	/* port declaration */
	.sel(bmux_sel),
	.a(solreg_out), 
	.b(sr2reg_out), 
	.c(), 
	.d(),
	.f(bmux_out)
);
alu mini_alu
(
   .aluop(mini_aluop),
   .a(sr1reg_out), 
	.b(bmux_out),
   .f(mini_alu_out)
);

always_comb
begin
	calc_done = 1'b0;  // when cacl_done and state are both 1 reset
	state = 2'b00;
	sr1mux_sel = 2'b00;
	sr2mux_sel = 2'b00;
	solmux_sel = 2'b00;
	bmux_sel = 2'b00;
	sr1_load = 1'b0;
	sr2_load = 1'b0;
	sol_load = 1'b0;
	mini_aluop = alu_add;
	
	if(aluop == alu_mult)
	begin 
		if( state == 2'b00) //first iteration so load all registers
		begin
			sr1_load = 1'b1;
			sr2_load = 1'b1;
			sol_load = 1'b1;
			sr1mux_sel = 2'b00; // load in initial register val
			sr2mux_sel = 2'b00; // load in initial register val
			solmux_sel = 2'b11; // set the solution equal to zero
			state = 2'b01; // go to the next state
		end
		else if (state == 2'b01)// do multiplication
		begin
			if(sr2reg_out == 16'b0000000000000000) // if done multiplying move to the next state
			begin
				state = 2'b10;
			end
				
			else// else keep multiplying
			begin
				sr2_load = 1'b1;
				sol_load = 1'b1;
				sr2mux_sel = 2'b01; // load in initial register val
				solmux_sel = 2'b00; // set the solution equal to zero
				bmux_sel = 2'b00;
				state = 2'b01; // stay in same state
				mini_aluop = alu_add;
			end
		end
		else if (state == 2'b10)
		begin
			if(flow == 1'b1)
			begin
			calc_done = 1'b1; // the calculation is done so allow pipeline to flow (cant inject no ops yet)
			//reset registers
			sr1_load = 1'b1;
			sr2_load = 1'b1;
			sol_load = 1'b1;
			sr1mux_sel = 2'b11; // load in initial register val
			sr2mux_sel = 2'b11; // load in initial register val
			solmux_sel = 2'b11; // set the solution equal to zero
			state = 2'b00; // go to the first state
			end
			else
			begin
				state = 2'b10;
			end
		end
		
		
		
	end
	else if(aluop == alu_div)
	begin
	
	end

end


endmodule : DivMultUnit
