import lc3b_types::*;

module latch_if_id
(
	input logic clk, load_latch, inject_NOP, squash_instruction,
	input lc3b_word IR_in, PC_in,
    input logic branch_predict_status_in,
	output lc3b_word IR_out, PC_out,
    output logic squash_IF_ID,
    output logic branch_predict_status_out
);

logic inject_NOP_out;
lc3b_word IR_result, IR_reg_in;

always_ff @ (posedge clk)
begin
    squash_IF_ID = squash_instruction & inject_NOP_out;
end

always_comb
	begin
		if(inject_NOP_out == 1'b1)
        begin
			IR_out = 16'b0;
            IR_reg_in = 16'b0;
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
    .load(load_latch || (squash_IF_ID) || (squash_instruction & !inject_NOP_out)),
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

register branch_predict_reg
(
    .clk(clk),
    .load(load_latch),
    .in(branch_predict_status_in),
    .out(branch_predict_status_out)
);

assign inject_NOP_out = inject_NOP;

endmodule : latch_if_id