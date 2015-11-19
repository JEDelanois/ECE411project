import lc3b_types::*;

module bubbler 
(
	input [15:0] IF_ID_ir,
	input [15:0] ID_EX_ir,
	
	
	output logic gen_bubble,
	output logic squash_ID
);

logic [2:0] branch_counter_out, counter_set,counter_minus1,branch_countermux_out;
logic IF_ID_dr, IF_ID_sr1, IF_ID_sr2, IF_ID_Hsr, ID_EX_dr, ID_EX_sr1, ID_EX_sr2, ID_EX_Hsr, branch_counter_load, branch_countermux_sel;

assign counter_minus1 = branch_counter_out - 3'b001;

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
    .load(branch_counter_load),
    .in(branch_countermux_out),
    .out(branch_counter_out)
);

mux2 branch_countermux
(
	/* port declaration */
	.sel(branch_countermux_sel),
	.a(counter_set),
	.b(counter_minus1),
	.f(branch_countermux_out)
);




always_comb
begin

		gen_bubble = 1'b0;
		squash_ID = 1'b0;
		branch_counter_load = 1'b0;
		branch_countermux_sel = 1'b0;
		counter_set = 3'b101;
		
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
		
		if( (IF_ID_ir[15:12] == op_br) || (IF_ID_ir[15:12] == op_jmp) ||(IF_ID_ir[15:12] == op_jsr) ||(IF_ID_ir[15:12] == op_trap) ) // if there is a branch or instruction that moves the pc
		begin 
			//load counter
			branch_counter_load = 1'b1;
			branch_countermux_sel = 1'b0;
			gen_bubble = 1'b1;
		end
		else if(branch_counter_out > 3'b001)// if counting down
		begin 
			//if counter is not zero then count down
			branch_counter_load = 1'b1;
			branch_countermux_sel = 1'b1;
			gen_bubble = 1'b1;  //and insert a bubble
		end
		else if(branch_counter_out == 3'b001)// at one
		begin 
			//if counter is not zero then count down and make counter zero
			branch_counter_load = 1'b1;
			branch_countermux_sel = 1'b1;
			squash_ID = 1'b1;  //squash id
		end
		
		
		
		

		
		
		
		
end
endmodule : bubbler





