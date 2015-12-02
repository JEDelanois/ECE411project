module flow_control 
(
	input clk,
	input mem_indirect_stall,
	input stall_fetch,
	input stall_cache2_miss,
	input gen_bubble,
	input stall_X,
	
	output logic flow_X, // tells the multiplication unit when it can flow
	output logic flow_IFID, flow_IDEX, flow_EXMEM, flow_MEMWB
);

assign flow_X = !(mem_indirect_stall  || stall_cache2_miss );// as long as nothing is stalling  the ex stage besides the div mult unit the dive mult unit can tell things to flow
/* multiplexor definition */
always_comb
	begin																				// or if multiplying or dividing
	if((mem_indirect_stall == 1'b1) || (stall_cache2_miss == 1'b1) || (stall_X == 1'b1) ) // if there is an indirect memory acces  or a chache miss
		begin
		flow_IFID  = 1'b0;		//stall the entire pipeline
		flow_IDEX  = 1'b0;
		flow_EXMEM = 1'b0;
		flow_MEMWB = 1'b0;
		end
		
	else if(stall_fetch == 1'b1) // if you should stall the fetch stage
		begin
		flow_IFID  = 1'b0;		//stall only the fetxh stage
		flow_IDEX  = 1'b1;
		flow_EXMEM = 1'b1;
		flow_MEMWB = 1'b1;
		end
	
	else if(gen_bubble == 1'b1) // if you should stall the fetch stage
		begin
		flow_IFID  = 1'b0;		//stall only the fetxh stage
		flow_IDEX  = 1'b1;
		flow_EXMEM = 1'b1;
		flow_MEMWB = 1'b1;
		end	
		
	else //allow everything to flow
		begin
		flow_IFID  = 1'b1;
		flow_IDEX  = 1'b1;
		flow_EXMEM = 1'b1;
		flow_MEMWB = 1'b1;
		
		end
end
endmodule : flow_control