import lc3b_types::*;

module forwardingLogic
(
	input [15:0] ir,
	input [2:0] EX_MEM_dest,
	input [15:0] EX_MEM_val,
	input [2:0] MEM_WB_dest,
	input [15:0] MEM_WB_val,
	
	output logic sr1mux_sel,
	output logic sr2mux_sel,
	output logic sr1_forwardLatchMux_sel,
	output logic sr2_forwardLatchMux_sel,
	output logic storeDataMux_sel,  //used for the 3 store functions
	output logic storeDataLatchMux_sel

);

/*
the EX_MEM mux comes after the MEM_WBmux so that it can "write over it"
*/

always_comb
begin

	//default control signals 
	sr1mux_sel = 1'b0;
	sr2mux_sel =  1'b0;
	sr1_forwardLatchMux_sel= 1'b0; 
	sr2_forwardLatchMux_sel= 1'b0;
	storeDataMux_sel = 1'b0;
	storeDataLatchMux_sel = 1'b0;
	
	
	//if it needs an sr1 check for forwarding 
	if( (ir[15:12] == op_add) || (ir[15:12] == op_and) || (ir[15:12] == op_jmp) || ((ir[15:12] == op_jsr)&& (ir[11] == 1'b0)) || (ir[15:12] == op_ldb) || (ir[15:12] == op_ldi) || (ir[15:12] == op_ldr) || (ir[15:12] == op_not) || (ir[15:12] == op_shf) || (ir[15:12] == op_stb) || (ir[15:12] == op_sti) || (ir[15:12] == op_str) )
	begin
		
		if(ir[8:6] == EX_MEM_dest)// if the sr1 value needs to be forwarded
		begin
			sr1mux_sel = 1'b1;
			sr1_forwardLatchMux_sel= 1'b0; 
		end
		else if(ir[8:6] == MEM_WB_dest)// if the sr1 value needs to be forwarded
		begin
			sr1mux_sel = 1'b1;
			sr1_forwardLatchMux_sel= 1'b1; 
		end

		
	end
	
	
	//if it needs an sr2 check for forwarding 
	if( ((ir[15:12] == op_add) && (ir[5] == 1'b0)) || ((ir[15:12] == op_and) && (ir[5] == 1'b0))  )
	begin
		if(ir[2:0] == EX_MEM_dest)
		begin 
				sr2mux_sel = 1'b1;
				sr2_forwardLatchMux_sel= 1'b0; 
		end
		else if(ir[2:0] == MEM_WB_dest)
		begin
			   sr2mux_sel = 1'b1;
				sr2_forwardLatchMux_sel= 1'b1;
		end
				
	end
	
	
	
	//if the data stored needs to be forwarded
	if( (ir[15:12] == op_stb) || (ir[15:12] == op_sti) || (ir[15:12] == op_str) ) 
	begin
		if(ir[11:9] == EX_MEM_dest)
		begin 
			storeDataMux_sel = 1'b1;
			storeDataLatchMux_sel= 1'b0; 
		end
		else if(ir[11:9] == MEM_WB_dest)
		begin 
			storeDataMux_sel = 1'b1;
			storeDataLatchMux_sel= 1'b1; 
		end
	end


end
endmodule : forwardingLogic