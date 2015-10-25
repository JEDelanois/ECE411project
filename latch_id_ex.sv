import lc3b_types::*;

module latch_id_ex
(
	input logic clk, load_latch,
	input lc3b_word IR_in, PC_in, SR1_in, SR2_in,
    input lc3b_control  CW_in,
	output lc3b_word IR_out, PC_out, SR1_out, SR2_out,
    output lc3b_control CW_out
);

register IR
(
    .clk(clk),
    .load(load_latch),
    .in(IR_in),
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
    .in(CW_in),
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