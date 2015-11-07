module hit_logic
(
	input [8:0] tag, w1_tag_out, w2_tag_out,
	input w1_valid_out,
	input w2_valid_out,
	
	output hit, w2_hit	
);

logic w1_eq, w2_eq, out;

always_comb
	begin
		if(tag == w1_tag_out)
			w1_eq = 1'b1;
		else
			w1_eq = 1'b0;
	end

always_comb
	begin
		if(tag == w2_tag_out)
			w2_eq = 1'b1;
		else
			w2_eq = 1'b0;
	end

assign hit = (w1_eq && w1_valid_out)||(w2_eq && w2_valid_out);
assign w2_hit = (w2_eq && w2_valid_out);
		


endmodule : hit_logic