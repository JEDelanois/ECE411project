import lc3b_types ::*;

module arb_address_calc
(
	input [15:0] mem_address,
	input [8:0] tag_1, tag_2,
	input LRU_out, write_back_bit,
	output logic [15:0] arb_address
);

always_comb
	begin
		if(!write_back_bit)
			arb_address = mem_address;
		else if(LRU_out)
			arb_address = {tag_2, mem_address[6:0]};
		else
			arb_address = {tag_1, mem_address[6:0]};
	end

endmodule : arb_address_calc