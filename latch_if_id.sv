import lc3b_types::*;

module latch_if_id
(
	input logic clk, load_latch, inject_NOP, squash_instruction,
	input lc3b_word IR_in, PC_in,
	output lc3b_word IR_out, PC_out
);

logic inject_NOP_out;
lc3b_word IR_result, IR_reg_in;

always_comb
	begin
		if(inject_NOP_out == 1'b1)
        begin
			IR_out = 16'b0;
            IR_reg_in = IR_in;
        end
		else if (squash_instruction == 1'b1)
        begin
			IR_out = IR_result;
            IR_reg_in = 16'b0;
        end
        else
        begin
            IR_out = IR_result;
            IR_reg_in = IR_in;
        end
	end

register IR
(
    .clk(clk),
    .load(load_latch),
    .in(IR_reg_in),
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

endmodule : latch_if_id