import lc3b_types::*;

module dependencyCalc 
(
 input [15:0] ir,
 
 output logic produces_dr,
 output logic need_sr1,
 output logic need_sr2,
 output logic need_Hsr
			
);

always_comb
begin
	produces_dr = 1'b0;
   need_sr1 = 1'b0;
   need_sr2 = 1'b0;
   need_Hsr = 1'b0;
	
	case(ir[15:12])
	
	op_add: 
		begin
				produces_dr = 1'b1;
				need_sr1 = 1'b1;
				if(ir[5] == 1'b0)
					need_sr2 = 1'b1;
		end
	op_and: 
		begin
				produces_dr = 1'b1;
				need_sr1 = 1'b1;
				if(ir[5] == 1'b0)
					need_sr2 = 1'b1;
		end
	op_jmp:  
		begin
				need_sr1 = 1'b1;
		end
	op_jsr:  
		begin
				if(ir[11] == 1'b0)
					need_sr1 = 1'b1;
		end
	op_ldb:  
		begin
				produces_dr = 1'b1;
				need_sr1 = 1'b1;
		end
	op_ldi:  
		begin
			   produces_dr = 1'b1;
				need_sr1 = 1'b1;
		end
	op_ldr:  
		begin
				produces_dr = 1'b1;
				need_sr1 = 1'b1;
		end
	op_lea:  
		begin
				produces_dr = 1'b1;
		end
	op_not:  
		begin
				produces_dr = 1'b1;
				need_sr1 = 1'b1;
		end
	op_shf:  
		begin
				produces_dr = 1'b1;
				need_sr1 = 1'b1;
		end
	op_stb: 
		begin
				need_Hsr = 1'b1;
				need_sr1 = 1'b1;
		end 
	op_sti:  
		begin
				need_Hsr = 1'b1;
				need_sr1 = 1'b1;
		end
	op_str:  
		begin
				need_Hsr = 1'b1;
				need_sr1 = 1'b1;
		end
	
	endcase
	




end
endmodule : dependencyCalc