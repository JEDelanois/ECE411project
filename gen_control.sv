import lc3b_types::*;

module gen_control
(
		input logic [3:0] opcode,
		input logic [11:0] IRbits,
		output lc3b_control ctrl
);

always_comb
	begin
		/* Default signal assignments*/
		ctrl.opcode = opcode;
		ctrl.PCmux_sel = 3'b000;
		ctrl.mem1_read = 1'b0;
		ctrl.IfId_load = 1'b0;
		ctrl.sr1mux_sel = 1'b0;
		ctrl.sr2mux_sel = 1'b0;
		ctrl.destmux_sel = 1'b0;
		ctrl.IdEx_load = 1'b0;
		ctrl.alumux_sel = 3'b000;
		ctrl.aluop = alu_add;
		ctrl.ExMem_load = 1'b0;
		ctrl.memAdd2mux_sel = 1'b0;
		ctrl.mem_mdrmux_sel = 2'b00;
		ctrl.MemWb_load = 1'b0;
		ctrl.mem2_read = 1'b0;
		ctrl.mem2_write = 1'b0;
		ctrl.mem_byte_enable = 2'b11;
		ctrl.adjmux_sel = 1'b0;
		ctrl.cc_load = 1'b0;
		ctrl.regFilemux_sel = 3'b000;
		ctrl.regFile_load = 1'b0;
		
		/* Apply unique values per instruction*/
		case(opcode)
			op_add: begin
					ctrl.regFile_load = 1'b1;
					ctrl.cc_load = 1'b1;
				if(IRbits[5] == 0)
					ctrl.alumux_sel = 3'b100;
				else
					ctrl.alumux_sel = 3'b001;
			end
			op_and: begin
					ctrl.regFile_load = 1'b1;
					ctrl.aluop = alu_and;
					ctrl.cc_load = 1'b1;
				if(IRbits[5] == 0)
					ctrl.alumux_sel = 3'b100;
				else
					ctrl.alumux_sel = 3'b001;

			end
			op_br: begin
				ctrl.PCmux_sel = 3'b001;
			end
			op_jmp: begin
				ctrl.PCmux_sel = 3'b010;	//NOTE: IF THIS IS BROKEN, SO IS JSRR FOR THE SAME REASON
				ctrl.aluop = alu_pass;
			end
			op_jsr: begin
				//Store PC into R7
				ctrl.destmux_sel = 1'b1;
				ctrl.regFilemux_sel = 3'b001;
				ctrl.regFile_load = 1'b1;
				if(IRbits[11] == 1)	//The case for JSR
					begin
						ctrl.PCmux_sel = 3'b100;
						ctrl.adjmux_sel = 1'b1;
					end
				else						//The case for JSRR
					begin
						ctrl.PCmux_sel = 3'b010;
						ctrl.aluop = alu_pass;
					end
			end
			op_ldb: begin						//LDB assumes that we recieve data already ZEXTed from mem
				ctrl.cc_load = 1'b1;
				ctrl.alumux_sel = 3'b011;
				ctrl.mem_mdrmux_sel = 2'b10;
				ctrl.regFile_load = 1'b1;
			end
			op_ldi: begin
				ctrl.cc_load = 1'b1;
				ctrl.mem2_read = 1'b1;
				ctrl.mem_mdrmux_sel = 2'b01;
				ctrl.regFile_load = 1'b1;
			end
			op_ldr: begin
				ctrl.mem2_read = 1'b1;
				ctrl.regFile_load = 1'b1;
				ctrl.cc_load = 1'b1;
				ctrl.mem_mdrmux_sel = 2'b01;
			end
			op_lea: begin
				ctrl.cc_load = 1'b1;
				ctrl.regFilemux_sel = 3'b010;
				ctrl.regFile_load = 1'b1;
			end
			op_not: begin
				ctrl.aluop = alu_not;
				ctrl.regFile_load = 1'b1;
				ctrl.cc_load = 1'b1;
			end
			op_rti: begin
				//We're assuming this does not need to get done for the checkpoint; or even at all
			end
			op_shf: begin
				ctrl.cc_load = 1'b1;
				ctrl.alumux_sel = 3'b101;
				ctrl.regFile_load = 1'b1;
				if(IRbits[4] == 1'b0)
					begin
						ctrl.aluop = alu_sll;
					end
				else if(IRbits[5] == 1'b0)
					begin
						ctrl.aluop = alu_srl;
					end
				else
					begin
						ctrl.aluop = alu_sra;
					end
			end
			op_stb: begin
				ctrl.mem_byte_enable = 2'b01;
				ctrl.alumux_sel = 3'b011;
				ctrl.sr2mux_sel = 1'b1;
				ctrl.mem2_write = 1'b1;
			end
			op_sti: begin
				ctrl.cc_load = 1'b1;
				ctrl.mem2_read = 1'b1;
				ctrl.mem_mdrmux_sel = 2'b01;	
				ctrl.sr2mux_sel = 1'b1;
			end
			op_str: begin
				ctrl.sr2mux_sel = 1'b1;
				ctrl.mem2_write = 1'b1;
			end
			op_trap: begin
				ctrl.destmux_sel = 1'b1;
				ctrl.regFilemux_sel = 3'b001;
				ctrl.regFile_load = 1'b1;
				ctrl.PCmux_sel = 3'b101;
				ctrl.memAdd2mux_sel = 1'b1;
				ctrl.mem_mdrmux_sel = 1'b1;
			end
	endcase
end

endmodule : gen_control