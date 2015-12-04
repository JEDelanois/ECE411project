module L2_hit_logic
(
	input [5:0] tag, w1_tag_out, w2_tag_out, w3_tag_out, w4_tag_out,
	input w1_valid_out, w2_valid_out, w3_valid_out, w4_valid_out,
	
	output logic [1:0] way_hit_selector, 
	output hit, w1_hit, w2_hit, w3_hit, w4_hit
);

logic w1_eq, w2_eq, w3_eq, w4_eq, out;

assign w1_hit = (w1_eq && w1_valid_out);
assign w2_hit = (w2_eq && w2_valid_out);
assign w3_hit = (w3_eq && w3_valid_out);
assign w4_hit = (w4_eq && w4_valid_out);
assign hit = (w1_hit || w2_hit || w3_hit || w4_hit);		

always_comb
	begin
		w1_eq = 1'b0;
		w2_eq = 1'b0;
		w3_eq = 1'b0;
		w4_eq = 1'b0;
		if(tag == w1_tag_out)
			w1_eq = 1'b1;
		else if(tag == w2_tag_out)
			w2_eq = 1'b1;
		else if(tag == w3_tag_out)
			w3_eq = 1'b1;
		else if(tag == w4_tag_out)
			w4_eq = 1'b1;
		else
			begin
				w1_eq = 1'b0;
				w2_eq = 1'b0;
				w3_eq = 1'b0;
				w4_eq = 1'b0;
			end
	end

always_comb
	begin
		if(w1_hit == 1'b1)
			way_hit_selector = 2'b00;
		else if(w2_hit == 1'b1)
			way_hit_selector = 2'b01;
		else if(w3_hit == 1'b1)
			way_hit_selector = 2'b10;
		else
			way_hit_selector = 2'b11;
	
	end



endmodule : L2_hit_logic