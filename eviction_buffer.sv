module eviction_buffer
(
		input clk, ev_write, ev_read, pmem_resp,
		input [15:0] ev_addr,
		input [1023:0] ev_wdata, pmem_rdata,
		
		
		output ev_resp, pmem_write, pmem_read,
		output [15:0] pmem_addr,
		output [1023:0] pmem_wdata, ev_rdata
);

//Check for case that L1 reads something that is in the writeback buffer! check pmem_read and address
enum int unsigned {
		empty,			//When the eviction buffer has no contents
		delay,			//Allow cache time to request read
		full, 			//Present in this state when there is writeback needing to be done or being done.
		buffer_write	//State where the eviction buffer is writing its contents
} state, next_state;

logic load_buffer, mux_sel, addr_match, read_sel;
logic [15:0] buffer_addr;
logic [127:0] buffer_wdata;

assign addr_match = (buffer_addr == ev_addr);

mux2 #(1024) wdata_mux
(
	.sel(mux_sel),
	.a(ev_wdata),
	.b(buffer_wdata),
	.f(pmem_wdata)
);

mux2 #(16) addr_mux
(
	.sel(mux_sel),
	.a(ev_addr),
	.b(buffer_addr),
	.f(pmem_addr)
);

mux2 #(1024) rdata_mux
(
	.sel(read_sel),
	.a(pmem_rdata),
	.b(buffer_wdata),
	.f(ev_rdata)
);

register #(1024) data_buffer
(
	.clk(clk),
	.load(load_buffer),
	.in(ev_wdata),
	.out(buffer_wdata)
);

register #(16) addr_buffer
(
	.clk(clk),
	.load(load_buffer),
	.in(ev_addr),
	.out(buffer_addr)
);

//Below is the very simple control logic
always_comb
	begin
		load_buffer = 1'b0;
		pmem_write = 1'b0;
		pmem_read = 1'b0;
		ev_resp = 1'b0;
		mux_sel = 1'b0;
		read_sel = 1'b0;
		case(state)
			empty: begin
				//Case where a read request happens
				if(ev_read == 1'b1)
					begin
						pmem_read = 1'b1;				//Tell pmem to do read
						if(pmem_resp == 1'b1)
							ev_resp = 1'b1;			//When read is done, set resp high
					end
				//Case where a write request happens
				else if(ev_write == 1'b1)
					begin
						load_buffer = 1'b1;			//Put wdata and addr in buffer, signal write is done
						ev_resp = 1'b1;
					end
			end
			delay: begin
				//Case where a read request intersects with buffer contents (writes can just overwrite buffer contents)
				if((addr_match == 1'b1)&&(ev_read == 1'b1))
					begin
						read_sel = 1'b1;
						pmem_read = 1'b1;
						if(pmem_resp == 1'b1)
							begin
								ev_resp = 1'b1;
							end
					end
			end
			full: begin
				//Case where a read request intersects with buffer contents (writes can just overwrite buffer contents)
				if((addr_match == 1'b1)&&(ev_read == 1'b1))
					begin
						read_sel = 1'b1;
						pmem_read = 1'b1;
						if(pmem_resp == 1'b1)
							begin
								ev_resp = 1'b1;
							end
					end
				//Case where read request happens
				else if(ev_read == 1'b1)
					begin
						pmem_read = 1'b1;
						if(pmem_resp == 1'b1)
							ev_resp = 1'b1;
					end
				//Case where write request happens
				else if(ev_write == 1'b1)
					begin
						pmem_write = 1'b1;
						if(pmem_resp == 1'b1)
							ev_resp = 1'b1;
					end							
			end
			buffer_write: begin
				//No matter what, just writeback in this state
				pmem_write = 1'b1;
				mux_sel = 1'b1;
				if(pmem_resp == 1'b1)
					ev_resp = 1'b1;
			end
		endcase
end


always_comb
begin : next_state_logic
	case(state)
		empty: begin
			if(ev_write)
				next_state = delay;				//If a write happens when empty, go to delay and eventually full
			else
				next_state = empty;
		end
		delay: begin								//Gives a clock cycle to allow caches to send read request
			next_state = full;
		end
		full: begin
			if((!ev_read)&&(!ev_write))		//If no requests, do the writeback
				next_state = buffer_write;
			else										//Else, stay full while doing other requests.
				next_state = full;
		end
		buffer_write: begin
			if(pmem_resp == 1'b1)				//Once the writeback is done, go to empty
				next_state = empty;
			else
				next_state = buffer_write;
		end
	endcase
end


always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end


endmodule : eviction_buffer