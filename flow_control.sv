module flow_control 
(
	input clk,
	input mem_indirect_stall,
	
	output logic flow_IFID, flow_IDEX, flow_EXMEM, flow_MEMWB
);

/* multiplexor definition */
always_comb

	if(mem_indirect_stall == 1'b1) // if there is an indirect memory acces 
		begin
		flow_IFID  = 1'b0;		//stall the entire pipeline
		flow_IDEX  = 1'b0;
		flow_EXMEM = 1'b0;
		flow_MEMWB = 1'b0;
		end
		
	else //allow everything to flow
		begin
		flow_IFID  = 1'b1;
		flow_IDEX  = 1'b1;
		flow_EXMEM = 1'b1;
		flow_MEMWB = 1'b1;
		
		end
	
endmodule : flow_control