import lc3b_types::*;

module L1_cache_control
(
	input clk, mem_read, mem_write, arb_resp, hit, w2_hit, LRU_out, w1_dirty_out, w2_dirty_out,
	
	output logic [3:0] load_w1, load_w2,
	output logic load_LRU, LRU_in, w1_dirty_in, w2_dirty_in, write_back_bit, rw_mux_sel, writemux_sel, mem_resp,
				arb_read, arb_write
);

enum int unsigned {
		idle,
		evict, //and write-back
		replace, //and write-to
		read,
		write
} state, next_state;

always_comb
begin : state_actions
	/* Default control values */
	load_w1 = 4'b0000;
	load_w2 = 4'b0000;
	load_LRU = 1'b0;
	LRU_in = 1'b0;
	w1_dirty_in = 1'b0;
	w2_dirty_in = 1'b0;
	write_back_bit = 1'b0;
	rw_mux_sel = 1'b0;
	writemux_sel = 1'b0;
	mem_resp = 1'b0;
	arb_read = 1'b0;
	arb_write = 1'b0;
	
	/* Actions for each state */
	case(state)
		default:;
		idle: begin
			if((mem_read||mem_write)&&hit)
				begin
					mem_resp = 1'b1;
					rw_mux_sel = 1'b1;
					if(mem_write&&w2_hit)
						begin
							w2_dirty_in = 1'b1;
							load_w2 = 4'b1001;
						end
					else if(mem_write&&!w2_hit)
						begin
							w1_dirty_in = 1'b1;
							load_w1 = 4'b1001;
						end
				end
		end
		evict: begin
			if(!(!LRU_out&&w1_dirty_out)&&!(LRU_out&&w2_dirty_out))	//Line to be evicted is not dirty! replace the line with the arb version
				begin	
					arb_read = 1'b1;
					if(LRU_out == 0)
						load_w1 = 4'b0111;		//Load into the correct way according to LRU bit
					else
						load_w2 = 4'b0111;
				end
			else if(!LRU_out&&w1_dirty_out)	//The line to be evicted is dirty! Need to write it back to arb
				begin
					write_back_bit = 1'b1;		//Signals address calculation to send address of current cache contents to arb_address
					arb_write = 1'b1;			//Signal to arb to write
				end
			else if(LRU_out&&w2_dirty_out)
				begin
					write_back_bit = 1'b1;
					arb_write = 1'b1;
					writemux_sel = 1'b1;			//Chooses to send w2_data_out to arb_wdata instead of w1_data_out
				end
		end
		replace: begin
			arb_read = 1'b1;
			if(LRU_out)
				load_w2 = 4'b1001;
			else
				load_w1 = 4'b1001;
		end
		read: begin
			mem_resp = 1'b1;
			load_LRU = 1'b1;
			if(w2_hit)
				LRU_in = 1'b0;
			else
				LRU_in = 1'b1;			
		end
		write: begin
			mem_resp = 1'b1;
			load_LRU = 1'b1;
			rw_mux_sel = 1'b1;
			if(w2_hit)
				begin
				LRU_in = 1'b0;
				w2_dirty_in = 1'b1;
				load_w2 = 4'b1000;
				end
			else
				begin
					LRU_in = 1'b1;
					w1_dirty_in = 1'b1;
					load_w1 = 4'b1000;
				end			
		end
	endcase
end

always_comb
begin : next_state_logic
	case(state)
		idle: begin
			if(hit&&mem_read)
				next_state = read;
			else if(hit&&mem_write)
				next_state = write;
			else if(!hit&&(mem_write||mem_read))
				next_state = evict;
			else
				next_state = idle;
		end
		read: begin
			next_state = idle;
		end
		write: begin
			next_state = idle;
		end
		evict: begin
			if((arb_resp == 1)&&(!(!LRU_out&&w1_dirty_out)&&!(LRU_out&&w2_dirty_out)))
				next_state = idle;
			else if(arb_resp == 0)
				next_state = evict;
			else
				next_state = replace;
		end
		replace: begin
			if(arb_resp == 0)
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

endmodule : L1_cache_control