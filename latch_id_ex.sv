import lc3b_types::*;

module latch_id_ex
(
	input logic clk, load_latch,
	input lc3b_word IR_in, PC_in, SR1_in, SR2_in,
    input lc3b_control  CW_in,
    input logic squash_instruction,
	output lc3b_word IR_out, PC_out, SR1_out, SR2_out,
    output lc3b_control CW_out
);

lc3b_word IR_reg_in;
lc3b_control CW_reg_in;

always_comb
    begin
        if(squash_instruction == 1'b1)
        begin
            IR_reg_in = 16'b0;
            CW_reg_in = {3'b1,9'b0, alu_add, 7'b0, 2'b11, 10'b0};
        end
        else
        begin
            IR_reg_in = IR_in;
            CW_reg_in = CW_in;
        end
    end

register IR
(
    .clk(clk),
    .load(load_latch),
    .in(IR_reg_in),
    .out(IR_out)
);


register PC
(
    .clk(clk),
    .load(load_latch),
    .in(PC_in),
    .out(PC_out)
);

register #(CONTROL_WIDTH) CW
(
    .clk(clk),
    .load(load_latch),
    .in(CW_reg_in),
    .out(CW_out)
);

register SR1
(
    .clk(clk),
    .load(load_latch),
    .in(SR1_in),
    .out(SR1_out)
);

register SR2
(
    .clk(clk),
    .load(load_latch),
    .in(SR2_in),
    .out(SR2_out)
);


endmodule : latch_id_ex