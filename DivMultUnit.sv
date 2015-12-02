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

logic calc_done, sr1_load, sr2_load, sol_load, state_load;
logic[1:0] state, sr1mux_sel, sr2mux_sel, solmux_sel, bmux_sel, state_out;
lc3b_aluop mini_aluop;
logic [15:0] sr1reg_out, sr2reg_out, solreg_out, sr1mux_out, sr2mux_out, solmux_out, bmux_out, mini_alu_out, sr1signflip_out, sr2signflip_out, solsignflip_out ; 

assign solution = solsignflip_out;
assign stall_X = (((aluop == alu_mult)||(aluop == alu_div)) && (calc_done == 1'b0));


NeedFlipSign sr1signflip
(
   .flip(sr1[15]), // if sr1 is ngegative then flip it
   .in(sr1),

   .out(sr1signflip_out)
);


mux4 sr1mux
(
	/* port declaration */
	.sel(sr1mux_sel),
	.a(sr1signflip_out), 
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


NeedFlipSign sr2signflip
(
   .flip(sr2[15]), // if sr2 is negative then  flip it
   .in(sr2),

   .out(sr2signflip_out)
);


mux4 sr2mux
(
	/* port declaration */
	.sel(sr2mux_sel),
	.a(sr2signflip_out), 
	.b(sr2reg_out - 16'b0000000000000001), 
	.c(), 
	.d(16'b0000000000000000 ),
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
	.b(solreg_out + 16'b0000000000000001 ), 
	.c(), 
	.d(16'b0000000000000000 ),
	.f(solmux_out)
);

register solreg
(
    .clk(clk),
    .load(sol_load),
    .in(solmux_out),
    .out(solreg_out)
);

NeedFlipSign solsignflip
(
   .flip( ((sr1[15] == 1'b1) && (sr2[15] == 1'b0)) || ((sr1[15] == 1'b0) && (sr2[15] == 1'b1))  ), // the result of sol will always be posive so pass on the negative version of the answer only if one of the inputs was origionaly negative
   .in(solreg_out),

   .out(solsignflip_out)
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

register #(2) statereg
(
    .clk(clk),
    .load(state_load),
    .in(state),
    .out(state_out)
);

always_comb
begin
	calc_done = 1'b0;  // when cacl_done and state are both 1 reset
	state = 2'b00;
	sr1mux_sel = 2'b00;
	sr2mux_sel = 2'b00;
	solmux_sel = 2'b00;
	bmux_sel = 2'b00;
	state_load = 1'b0;
	sr1_load = 1'b0;
	sr2_load = 1'b0;
	sol_load = 1'b0;
	mini_aluop = alu_add;
	
	if(aluop == alu_mult)
	begin 
		if( state_out == 2'b00) //first iteration so load all registers
		begin
			sr1_load = 1'b1;
			sr2_load = 1'b1;
			sol_load = 1'b1;
			sr1mux_sel = 2'b00; // load in initial register val
			sr2mux_sel = 2'b00; // load in initial register val
			solmux_sel = 2'b11; // set the solution equal to zero
			state = 2'b01; // go to the next state
			state_load = 1'b1;
		end
		else if (state_out == 2'b01)// do multiplication
		begin
			if(sr2reg_out == 16'b0000000000000000 ) // if done multiplying move to the next state
			begin
				state = 2'b10;
				state_load = 1'b1;
			end
				
			else// else keep multiplying
			begin
				sr2_load = 1'b1;
				sol_load = 1'b1;
				sr2mux_sel = 2'b01; // load in sr2 minus 1 
				solmux_sel = 2'b00; // load the current total
				bmux_sel = 2'b00;
				mini_aluop = alu_add;
			end
		end
		else if (state_out == 2'b10)
		begin
			if(flow == 1'b1) // if the stalling unit says that  DivMult is the only unit stalling the pipeline then unfreeze the pipleine and continue
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
			state_load = 1'b1;
			end
			

		end
		
		
		
	end
	
	
	
	
	else if(aluop == alu_div)
	begin
	if( state_out == 2'b00) //first iteration so load all registers
		begin
			sr1_load = 1'b1;
			sr2_load = 1'b1;
			sol_load = 1'b1;
			sr1mux_sel = 2'b00; // load in initial register val
			sr2mux_sel = 2'b00; // load in initial register val
			solmux_sel = 2'b11; // set the solution equal to zero
			state = 2'b01; // go to the next state
			state_load = 1'b1;
		end
		else if (state_out == 2'b01)// do division
		begin
			if(sr1reg_out < sr2reg_out) // if done dividing move to the next state
			begin
				state = 2'b10;
				state_load = 1'b1;
			end
				
			else// else keep dividing
			begin
				sr1_load = 1'b1;
				sol_load = 1'b1;
				sr1mux_sel = 2'b01; // load in the new subtracted  value 
				solmux_sel = 2'b01; // increment the number of  subtractions that occured
				bmux_sel = 2'b01;
				mini_aluop = alu_sub;
			end
		end
		else if (state_out == 2'b10)
		begin
			if(flow == 1'b1) // if the stalling unit says that  DivMult is the only unit stalling the pipeline then unfreeze the pipleine and continue
			begin
			calc_done = 1'b1; // the calculation is done so allow pipeline to flow (cant inject no ops yet)
			//reset registers
			sr1_load = 1'b1;
			sr2_load = 1'b1;
			sol_load = 1'b1;
			sr1mux_sel = 2'b11; // fill with zero
			sr2mux_sel = 2'b11; // fill with zero
			solmux_sel = 2'b11; // fill with zero
			state = 2'b00; // go to the first state
			state_load = 1'b1;
			end
			

		end
	
	end

end


endmodule : DivMultUnit
