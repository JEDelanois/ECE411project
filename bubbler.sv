import lc3b_types::*;

module bubbler 
(
	input clk,
	input [15:0] IF_ID_ir,
	input [15:0] ID_EX_ir,
	input branch_enable,
	input flow_ID_EX,
	
	
	output logic gen_bubble,
	output logic squash_ID
);

logic [2:0] branch_counter_out, counter_set,counter_minus1,branch_countermux_out;
logic IF_ID_dr, IF_ID_sr1, IF_ID_sr2, IF_ID_Hsr, ID_EX_dr, ID_EX_sr1, ID_EX_sr2, ID_EX_Hsr, branch_counter_load, branch_countermux_sel,branch_enable_latch_out,lastIR_load;
logic [15:0] lastIR_out;
assign counter_minus1 = branch_counter_out - 1;

dependencyCalc ifidDEPS
(
  .ir(IF_ID_ir),
 
  .produces_dr(IF_ID_dr),
  .need_sr1(IF_ID_sr1),
  .need_sr2(IF_ID_sr2),
  .need_Hsr(IF_ID_Hsr)
			
);


dependencyCalc idexDEPS
(
  .ir(ID_EX_ir),
 
  .produces_dr(ID_EX_dr),
  .need_sr1(ID_EX_sr1),
  .need_sr2(ID_EX_sr2),
  .need_Hsr(ID_EX_Hsr)
			
);


register #(.width(3)) branch_counter
(
    .clk(clk),
    .load(branch_counter_load && flow_ID_EX),
    .in(branch_countermux_out),
    .out(branch_counter_out)
);

mux2 #(.width(3)) branch_countermux
(
	/* port declaration */
	.sel(branch_countermux_sel),
	.a(counter_set),
	.b(counter_minus1),
	.f(branch_countermux_out)
);

register #(.width(1)) branch_enable_latch //this holds the branch enable from the cycle before. this is used to decide if we need to squash instructions
(
    .clk(clk),
    .load(flow_ID_EX),
    .in(branch_enable),
    .out(branch_enable_latch_out)
);





register lastIR
(
    .clk(clk),
    .load(lastIR_load && flow_ID_EX),
    .in(IF_ID_ir),
    .out(lastIR_out)
);




always_comb
begin

		gen_bubble = 1'b0;
		squash_ID = 1'b0;
		branch_counter_load = 1'b0;
		branch_countermux_sel = 1'b0;
		counter_set = 3'b101;
		lastIR_load = 1'b1;
		
		//logic for inserting bubbles when there is a load followed by a read for the same register
		if( (ID_EX_ir[15:12] == op_ldb) || (ID_EX_ir[15:12] == op_ldi) || (ID_EX_ir[15:12] == op_ldr) ) // if the latter is a load instruction (dont need a counter since only need 1 bubble)
		begin
		
		//check for previouse dependencies
			if(IF_ID_Hsr == 1'b1) // if instruction is a store check sotre registers
			begin
				if( (IF_ID_ir[11:9] == ID_EX_ir[11:9] ) || (IF_ID_ir[8:6] ==  ID_EX_ir[11:9]) ) // if the dest of the latter matches a source or the previouse
						gen_bubble = 1'b1;// create a bubble
			end
			
			if(IF_ID_sr1 == 1'b1)
			begin
				if( IF_ID_ir[8:6] ==  ID_EX_ir[11:9]) // if the dest of the latter matches a source or the previouse
						gen_bubble = 1'b1;// create a bubble
			end
			
			
			if(IF_ID_sr2 == 1'b1)
			begin
				if( IF_ID_ir[2:0] ==  ID_EX_ir[11:9]) // if the dest of the latter matches a source or the previouse
						gen_bubble = 1'b1;// create a bubble
			end
			
			
		end
		
		
		//logic for creating bubbles after a branch
			//setting signals to set up the counter
		
		if( (branch_counter_out == 3'b000) && (IF_ID_ir != 16'b0000000000000000) && ((IF_ID_ir[15:12] == op_br) || (IF_ID_ir[15:12] == op_jmp) ||(IF_ID_ir[15:12] == op_jsr) ||(IF_ID_ir[15:12] == op_trap)) ) // if there is a branch or instruction that moves the pc
		begin 
			//load counter
			branch_counter_load = 1'b1;
			branch_countermux_sel = 1'b0;
			lastIR_load = 1'b1; // load the ir for the current counter
		end
		else if(branch_counter_out > 3'b001)// if counting down
		begin 
			//if counter is not zero then count down
			branch_counter_load = 1'b1;
			branch_countermux_sel = 1'b1;
			gen_bubble = 1'b1;  //and insert a bubble
			lastIR_load = 1'b0;
		end
		else if(branch_counter_out == 3'b001)// at one
		begin 
			//if counter is not zero then count down and make counter zero
			branch_counter_load = 1'b1;
			branch_countermux_sel = 1'b1;
			if(lastIR_out[15:12] == op_br)//for branch
			begin
				if(branch_enable_latch_out == 1'b1) //if branch is taken then squash the current instruction  
					squash_ID = 1'b1;  //squash id
			end
			else // else its an unconditional jump so squash the instruction
				squash_ID = 1'b1;  //squash id
		end
		
		
		
		if( (branch_counter_out == 3'b000) && (lastIR_out[15:12] == op_lea) ) // if lea then save to see if there are dependencies later
		begin
			if( (IF_ID_sr1 == 1'b1) && (lastIR_out[11:9] == IF_ID_ir[8:6]))
			begin
				branch_counter_load = 1'b1;
				branch_countermux_sel = 1'b0;	
			end
			else if( (IF_ID_sr2 == 1'b1) && (lastIR_out[11:9] == IF_ID_ir[2:0]))
			begin
				branch_counter_load = 1'b1;
				branch_countermux_sel = 1'b0;	
			end
			else if( (IF_ID_Hsr == 1'b1) && (lastIR_out[11:9] == IF_ID_ir[11:9]))
			begin
				branch_counter_load = 1'b1;
				branch_countermux_sel = 1'b0;	
			end
		
		end

		
		if(lastIR_out[15:12] == op_lea)
		begin 
				gen_bubble = 1'b1;  //and insert a bubble
				lastIR_load = 1'b0;
				branch_counter_load = 1'b1;
				branch_countermux_sel = 1'b1;		
		end

		

		
		
		
		
end
endmodule : bubbler





