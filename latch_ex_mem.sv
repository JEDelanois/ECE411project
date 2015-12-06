import lc3b_types::*;

module latch_ex_mem
(
	input logic clk, load_latch,
	input lc3b_word IR_in, PC_in, ALU_in, sr2_in,
    input lc3b_control CW_in,
    input logic squash_instruction,
    input logic branch_predict_status_in,
	 
	output lc3b_word IR_out, PC_out, ALU_out, sr2_out,
    output lc3b_control CW_out,
    output logic branch_predict_status_out
);

lc3b_word IR_reg_in;
lc3b_control CW_reg_in;
logic branch_predict_reg_in;

always_comb
    begin
        if(squash_instruction == 1'b1)
        begin
            IR_reg_in = 16'b0;
            CW_reg_in = {3'b1,9'b0, alu_add, 7'b0, 2'b11, 11'b0};
        end
        else
        begin
            IR_reg_in = IR_in;
            CW_reg_in = CW_in;
        end

        if (squash_instruction)
            branch_predict_reg_in = 1'b0;
        else
            branch_predict_reg_in = branch_predict_status_in;
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


register ALU
(
    .clk(clk),
    .load(load_latch),
    .in(ALU_in),
    .out(ALU_out)
);

register #(CONTROL_WIDTH) CW
(
	.clk(clk),
	.load(load_latch),
	.in(CW_reg_in),
	.out(CW_out)
);

register sr2
(
    .clk(clk),
    .load(load_latch),
    .in(sr2_in),
    .out(sr2_out)
);

register branch_predict_reg
(
    .clk(clk),
    .load(load_latch | squash_instruction),
    .in(branch_predict_reg_in),
    .out(branch_predict_status_out)
);

endmodule : latch_ex_mem