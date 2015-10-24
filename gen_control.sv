import lc3b_types::*;

module gen_control
(
		input logic [3:0] opcode,
		output lc3b_control ctrl
);

always_comb
	begin
		/* Default signal assignments*/
		//ctrl.opcode = opcode
		
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