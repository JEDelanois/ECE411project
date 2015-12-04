module pmem_address_calc
(
	input [15:0] arb_address,
	input [5:0] tag_1, tag_2, tag_3, tag_4,
	input [2:0] LRU_out,
	input write_back_bit,
	output logic [15:0] pmem_address
);

always_comb
	begin
		if(!write_back_bit)
			pmem_address = arb_address;
		else if((LRU_out == 3'b000)||(LRU_out == 3'b100))
			pmem_address = {tag_1, arb_address[9:0]};
		else if((LRU_out == 3'b010)||(LRU_out == 3'b110))
			pmem_address = {tag_2, arb_address[9:0]};
		else if((LRU_out == 3'b001)||(LRU_out == 3'b011))
			pmem_address = {tag_3, arb_address[9:0]};
		else
			pmem_address = {tag_4, arb_address[9:0]};
	end

endmodule : pmem_address_calc