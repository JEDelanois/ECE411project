import lc3b_types::*;

module gen_control
(
		input logic [3:0] opcode,
		output lc3b_control ctrl
);

always_comb
	begin
		/* Default signal assignments*/
		ctrl.opcode = opcode;
		ctrl.PCmux_sel = 2'b00;
		ctrl.mem1_read = 1'b0;
		ctrl.IfId_load = 1'b0;
		ctrl.sr1mux_sel = 1'b0;
		ctrl.destMux_sl = 1'b0;
		ctrl.IdEx_load = 1'b0;
		ctrl.alumux_sel = 3'b000;
		ctrl.aluop = alu_add;
		ctrl.ExMem_load = 1'b0;
		ctrl.memAdd2mux_sel = 1'b0;
		ctrl.mem_rdatamux_sel = 1'b0;
		ctrl.MemWb_load = 1'b0;
		ctrl.mem2_read = 1'b0;
		ctrl.mem2_write = 1'b0;
		ctrl.adjmux_sel = 1'b0;
		ctrl.cc_load = 1'b0;
		ctrl.regFilemux_sel = 3'b000;
		ctrl.regFile_load = 1'b0;
		
		/* Apply unique values per instruction*/
		case(opcode)
			op_add: begin //TODO
			
			end
			op_and: begin //TODO
			
			end
			op_br: begin
			
			end
			op_jmp: begin
			
			end
			op_jsr: begin
			
			end
			op_ldb: begin
			
			end
			op_ldi: begin
			
			end
			op_ldr: begin //TODO
			
			end
			op_lea: begin
			
			end
			op_not: begin //TODO
			
			end
			op_rti: begin
			
			end
			op_shf: begin
			
			end
			op_stb: begin
			
			end
			op_sti: begin
			
			end
			op_str: begin //TODO
			
			end
			op_trap: begin
			
			end
	endcase
end

endmodule : gen_control