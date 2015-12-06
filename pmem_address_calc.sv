module pmem_address_calc
(
	input [15:0] arb_address,
	input [5:0] tag_1, tag_2,
	input LRU_out, write_back_bit,
	output logic [15:0] pmem_address
);

always_comb
	begin
		if(!write_back_bit)
			pmem_address = arb_address;
		else if(LRU_out)
			pmem_address = {tag_2, arb_address[9:0]};
		else
			pmem_address = {tag_1, arb_address[9:0]};
	end

endmodule : pmem_address_calc