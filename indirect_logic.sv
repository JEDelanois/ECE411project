import lc3b_types::*;

module indirect_logic
(
		input clk, mem_resp,
		input [3:0] opcode,
		output logic indirect_switch, iMDR_load, mem_indirect_stall, rw_switch
);

logic state_load, state_in, state_out;

//This needs to be able to be reset after ldi/sti finishes.
register #(1) indirect_state
(
	.clk(clk),
	.load(state_load),
	.in(state_in),
	.out(state_out)
);

always_comb
	begin
		if(opcode == op_sti)
			begin
				if(state_out == 1'b0)
					rw_switch = 1'b0;
				else
					rw_switch = 1'b1;
			end
		else
			rw_switch = 1'b0;
	end

	
always_comb
	begin
		mem_indirect_stall = 1'b0;
		state_load = 1'b0;
		state_in = 1'b0;
		iMDR_load = 1'b0;
		indirect_switch = 1'b0;
		if((opcode == op_ldi)||(opcode == op_sti))
			begin
				case({mem_resp, state_out})
					2'b00: begin
					mem_indirect_stall = 1'b1;
					end
					2'b01: begin
					mem_indirect_stall = 1'b1;
					indirect_switch = 1'b1;
					end
					2'b10: begin
					mem_indirect_stall = 1'b1;
					state_load = 1'b1;
					state_in = 1'b1;
					iMDR_load = 1'b1;
					end
					2'b11: begin
					state_load = 1'b1;
					indirect_switch = 1'b1;
					end
				endcase
			end
end

/*	
always_comb
	begin
		if((opcode == op_ldi)||(opcode == op_sti))
			begin
				if((mem_resp == 1'b0)&&(state_out == 1'b0))
					begin
						mem_indirect_stall = 1'b1;
						state_load = 1'b0;
						state_in = 1'b1;
						iMDR_load = 1'b0;
						indirect_switch = 1'b0;
					end
				else if((mem_resp == 1'b1)&&(state_out == 1'b0))
					begin
						mem_indirect_stall = 1'b1;
						state_load = 1'b1;
						state_in = 1'b1;
						iMDR_load = 1'b1;
						indirect_switch = 1'b0;
					end
				else if((mem_resp == 1'b0)&&(state_out == 1'b1))
					begin
						mem_indirect_stall = 1'b1;
						state_load = 1'b0;
						state_in = 1'b1;
						iMDR_load = 1'b0;
						indirect_switch = 1'b1;
					end
				else if((mem_resp == 1'b1)&&(state_out == 1'b1))
					begin
						mem_indirect_stall = 1'b0;
						state_load = 1'b1;
						state_in = 1'b0;
						iMDR_load = 1'b0;
						indirect_switch = 1'b1;
					end
				else
					mem_indirect_stall = 1'b0;
					state_load = 1'b0;
					state_in = 1'b0;
					iMDR_load = 1'b0;
					indirect_switch = 1'b0;
			end
		else
			mem_indirect_stall = 1'b0;
			state_load = 1'b0;
			state_in = 1'b0;
			iMDR_load = 1'b0;
			indirect_switch = 1'b0;
end
*/
endmodule : indirect_logic