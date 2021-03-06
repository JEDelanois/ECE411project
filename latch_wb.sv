import lc3b_types::*;

module latch_wb
(
	input logic clk, load_latch,
	input lc3b_word IR_in, PC_in, ALU_in, MDR_in,
    input lc3b_control CW_in,
    input logic squash_instruction,
    input logic stall_fetch,
    input logic stall_cache2_miss,
    input logic resp_b,
	output lc3b_word IR_out, PC_out, ALU_out, MDR_out,
    output lc3b_control CW_out
);

lc3b_word IR_reg_in, IR_result;
lc3b_control CW_reg_in, CW_result;
logic load_wb_nop;
logic stall_cache2_miss_delay;

assign load_wb_nop = stall_cache2_miss_delay & (!stall_fetch);

always_ff @ (posedge clk)
begin
    stall_cache2_miss_delay = stall_cache2_miss;
end


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

        if (load_wb_nop & !resp_b)
        begin
            IR_out = 16'b0;
            CW_out = {3'b1,9'b0, alu_add, 7'b0, 2'b11, 10'b0};
        end
        else
        begin
            IR_out = IR_result;
            CW_out = CW_result;
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

register #(CONTROL_WIDTH) CW
(
    .clk(clk),
    .load(load_latch),
    .in(CW_reg_in),
    .out(CW_result)
);

register MDR
(
    .clk(clk),
    .load(load_latch),
    .in(MDR_in),
    .out(MDR_out)
);

register ALU
(
    .clk(clk),
    .load(load_latch),
    .in(ALU_in),
    .out(ALU_out)
);

endmodule : latch_wb