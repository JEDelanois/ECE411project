module L2_cache_control
(
	input clk, arb_read, arb_write, pmem_resp, hit, w1_hit, w2_hit, w3_hit, w4_hit,
	input [2:0] LRU_out,
	input w1_dirty_out, w2_dirty_out, w3_dirty_out, w4_dirty_out,
	
	output logic [3:0] load_w1, load_w2, load_w3, load_w4,
	output logic load_LRU, 
	output logic [2:0]LRU_in,
	output logic [1:0] writemux_sel,
	output logic w1_dirty_in, w2_dirty_in, w3_dirty_in, w4_dirty_in, write_back_bit, rw_mux_sel, arb_resp,
				pmem_read, pmem_write
);

logic w1_dirt, w2_dirt, w3_dirt, w4_dirt;

assign w1_dirt = ((LRU_out == 3'b000)||(LRU_out == 3'b100))&&w1_dirty_out;
assign w2_dirt = ((LRU_out == 3'b010)||(LRU_out == 3'b110))&&w2_dirty_out;
assign w3_dirt = ((LRU_out == 3'b001)||(LRU_out == 3'b011))&&w3_dirty_out;
assign w4_dirt = ((LRU_out == 3'b101)||(LRU_out == 3'b111))&&w4_dirty_out;


enum int unsigned {
		idle,
		evict, //and write-back
		replace
} state, next_state;

always_comb
begin : state_actions
	/* Default control values */
	load_w1 = 4'b0000;
	load_w2 = 4'b0000;
	load_w3 = 4'b0000;
	load_w4 = 4'b0000;
	load_LRU = 1'b0;
	LRU_in = 3'b000;
	w1_dirty_in = 1'b0;
	w2_dirty_in = 1'b0;
	w3_dirty_in = 1'b0;
	w4_dirty_in = 1'b0;
	write_back_bit = 1'b0;
	rw_mux_sel = 1'b0;
	writemux_sel = 2'b00;
	arb_resp = 1'b0;
	pmem_read = 1'b0;
	pmem_write = 1'b0;
	
	/* Actions for each state */
	case(state)
		default:;
		idle: begin
			if(arb_read&&hit)
				begin
					arb_resp = 1'b1;
					rw_mux_sel = 1'b1;
					load_LRU = 1'b1;
					if(w1_hit)
						LRU_in = {LRU_out[2], 1'b1, 1'b1};
					else if(w2_hit)
						LRU_in = {LRU_out[2], 1'b0, 1'b1};
					else if(w3_hit)
						LRU_in = {1'b1, LRU_out[1], 1'b0};
					else if(w4_hit)
						LRU_in = {1'b0, LRU_out[1], 1'b0};
					else
						LRU_in = 3'b000;
				end
			else if(arb_write&&hit)
				begin
				arb_resp = 1'b1;
				rw_mux_sel = 1'b1;
				load_LRU = 1'b1;
				if(w1_hit)
					begin
					LRU_in = {LRU_out[2], 1'b1, 1'b1};
					w1_dirty_in = 1'b1;
					load_w1 = 4'b1001;
					end
				else if(w2_hit)
					begin
					LRU_in = {LRU_out[2], 1'b0, 1'b1};
					w2_dirty_in = 1'b1;
					load_w2 = 4'b1001;
					end
				else if(w3_hit)
					begin
					LRU_in = {1'b1, LRU_out[1], 1'b0};
					w3_dirty_in = 1'b1;
					load_w3 = 4'b1001;
					end
				else
					begin
					LRU_in = {1'b0, LRU_out[1], 1'b0};
					w4_dirty_in = 1'b1;
					load_w4 = 4'b1001;
					end
				end
		end
		evict: begin
			if(w1_dirt)	//The line to be evicted is dirty! Need to write it back to arb
				begin
					write_back_bit = 1'b1;		//Signals address calculation to send address of current cache contents to arb_address
					pmem_write = 1'b1;			//Signal to arb to write
				end
			else if(w2_dirt)
				begin
					write_back_bit = 1'b1;
					pmem_write = 1'b1;
					writemux_sel = 2'b01;			//Chooses to send w2_data_out to arb_wdata
				end
			else if(w3_dirt)
				begin
					write_back_bit = 1'b1;
					pmem_write = 1'b1;
					writemux_sel = 2'b10;			//Chooses to send w3_data_out to arb_wdata
				end
			else if(w4_dirt)
				begin
					write_back_bit = 1'b1;
					pmem_write = 1'b1;
					writemux_sel = 2'b11;			//Chooses to send w4_data_out to arb_wdata
				end
			else 			 //Line to be evicted is not dirty! replace the line with the arb version
				begin	
					pmem_read = 1'b1;
					if(pmem_resp == 1'b1)
						begin
						case(LRU_out)
							3'b000: begin
								load_w1 = 4'b0111;
							end
							3'b100: begin
								load_w1 = 4'b0111;
							end
							3'b010: begin
								load_w2 = 4'b0111;
							end
							3'b110: begin
								load_w2 = 4'b0111;
							end
							3'b001: begin
								load_w3 = 4'b0111;
							end
							3'b011: begin
								load_w3 = 4'b0111;
							end
							3'b101: begin
								load_w4 = 4'b0111;
							end
							3'b111: begin
								load_w4 = 4'b0111;
							end
						endcase
					end
				end
		end
		replace: begin
			pmem_read = 1'b1;
			if((LRU_out == 3'b000)||(LRU_out == 3'b100))
				load_w1 = 4'b1001;
			else if((LRU_out == 3'b010)||(LRU_out == 3'b110))
				load_w2 = 4'b1001;
			else if((LRU_out == 3'b001)||(LRU_out == 3'b011))
				load_w3 = 4'b1001;
			else
				load_w4 = 4'b1001;
		end
	endcase
end

always_comb
begin : next_state_logic
	case(state)
		idle: begin
			if(!hit&&(arb_write||arb_read))
				next_state = evict;
			else
				next_state = idle;
		end
		evict: begin
			if((pmem_resp == 1)&&(!w1_dirt&&!w2_dirt&&!w3_dirt&&!w4_dirt))
				next_state = idle;
			else if(pmem_resp == 0)
				next_state = evict;
			else
				next_state = replace;
		end
		replace: begin
			if(pmem_resp == 0)
				next_state = replace;
			else
				next_state = idle;
		end
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : L2_cache_control