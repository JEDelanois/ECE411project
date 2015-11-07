module arbiter
(
		input instr_read, instr_write,
		input [15:0] instr_addr,
		input [127:0] instr_wdata,
		output logic [127:0] instr_rdata,
		output logic instr_resp,
		
		input data_read, data_write,
		input [15:0] data_addr,
		input [127:0] data_wdata,
		output logic [127:0] data_rdata,
		output logic data_resp,
		
		output logic L2_read, L2_write,
		output logic [15:0] L2_addr,
		output logic [127:0] L2_wdata,
		input [127:0] L2_rdata,
		input L2_resp		
);

always_comb
	begin
		if((instr_read||instr_write)&&(!(data_read||data_write)))		//Only connect instruction if it is high AND data isn't active
			begin
				L2_read = instr_read;
				L2_write = instr_write;
				L2_addr = instr_addr;
				L2_wdata = instr_wdata;
				instr_rdata = L2_rdata;
				instr_resp = L2_resp;
				data_rdata = 128'b1;				//Need to drive all outputs, otherwise not combinational. HIGH IMPEDANCE
				data_resp = 1'b0;
			end
		else
			begin
				L2_read = data_read;
				L2_write = data_write;
				L2_addr = data_addr;
				L2_wdata = data_wdata;
				data_rdata = L2_rdata;
				data_resp = L2_resp;
				instr_rdata = 128'b1;			//Need to drive all outputs, otherwise not combinational.HIGH IMPEDANCE
				instr_resp = 1'b0;
			end
	end

	//Design a reset value for the L2 Cache -- current design is bad if an instruction miss's arguments are replaced with data's halfway through.
			//Thus, making a signal detect when a switch to data happens, reset the L2 cache and service the data. Low performance if it happens, but
			//should be seldom.
	
endmodule : arbiter