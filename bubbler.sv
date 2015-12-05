import lc3b_types::*;

module bubbler 
(
	input clk,
	input [15:0] IF_ID_ir,
	input [15:0] ID_EX_ir,
	input branch_enable,
	input flow_ID_EX,
	
	
	output logic gen_bubble
);

logic IF_ID_dr, IF_ID_sr1, IF_ID_sr2, IF_ID_Hsr, ID_EX_dr, ID_EX_sr1, ID_EX_sr2, ID_EX_Hsr, branch_counter_load, branch_countermux_sel,branch_enable_latch_out,counterIR_load;

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

always_comb
begin
	gen_bubble = 1'b0;
		
	//logic for inserting bubbles when there is a load followed by a read for the same register
	if( (ID_EX_ir[15:12] == op_ldb) || (ID_EX_ir[15:12] == op_ldi) || (ID_EX_ir[15:12] == op_ldr) || (ID_EX_ir[15:12] == op_lea)) // if the latter is a load instruction (dont need a counter since only need 1 bubble)
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
			
end
endmodule : bubbler





