import lc3b_types::*;

module latch_if_id
(
	input logic clk, load_latch, inject_NOP,
	input lc3b_word IR_in, PC_in,
	output lc3b_word IR_out, PC_out
);

logic inject_NOP_out;
lc3b_word IR_result;

always_comb
	begin
		if(inject_NOP_out == 1'b1)
			IR_out = 16'b0;
		else
			IR_out = IR_result;	
	end

register IR
(
    .clk(clk),
    .load(load_latch),
    .in(IR_in),
    .out(IR_result)
);


register PC
(
    .clk(clk),
    .load(load_latch),
    .in(PC_in),
    .out(PC_out)
);

assign inject_NOP_out = inject_NOP;
/*
register #(1) NOP
(
    .clk(clk),
    .load(clk),
    .in(inject_NOP),
    .out(inject_NOP_out)
);
*/

endmodule : latch_if_id