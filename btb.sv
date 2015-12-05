import lc3b_types::*;

module btb
(
	input clk,
	input lc3b_word curr_pc,
	input lc3b_word loaded_pc,
	input lc3b_word loaded_predict_pc,
	input loaded_predict,
	input load_line,
	input new_predict_val,
	output logic btb_pc_load,
	output lc3b_word predicted_pc
);

logic [2:0] index;
lc3b_word loaded_delayed_pc;
lc3b_word orig_pc_out1, predict_pc_out1;
logic valid_out_1, predict_out_1;
logic hit1;

always_comb
begin
	if (load_line)
		index = loaded_delayed_pc[2:0];
	else
		index = curr_pc[2:0];
end

always_ff @ (posedge clk)
begin
	loaded_delayed_pc = loaded_pc;
end

array LRU_array
(
	.clk,
	.write(),
	.index(),
	.in(),
	.out()
);

btb_cache_way btb_way_one
(
	.clk(~clk),
	.index(index),
	.array_write(load_line),
	.tag_in(loaded_delayed_pc),
	.data_in(loaded_predict_pc),
	.new_predict_val(new_predict_val),
	
	.valid_out(valid_out_1),
	.predict_out(predict_out_1),
	.tag_out(orig_pc_out1),
	.data_out(predict_pc_out1)
);

btb_cache_way btb_way_two
(
	.clk(),
	.index(),
	.array_write(),
	.tag_in(),
	.data_in(),
	.new_predict_val(),
	
	.valid_out(),
	.tag_out(),
	.data_out()
);

mux2 #(16) waymux
(
	.sel(),
	.a(),
	.b(),
	.f()
);

hit_logic hit_computation
(
	.tag(curr_pc), 
	.w1_tag_out(orig_pc_out1),
	.w2_tag_out(),
	.w1_valid_out(valid_out_1),
	.w2_valid_out(),
	.hit(hit1),
	.w2_hit()
);

assign predicted_pc = predict_pc_out1;
assign btb_pc_load = predict_out_1 & hit1;

endmodule : btb