import lc3b_types::*;

module alu
(
    input lc3b_aluop aluop,
    input lc3b_word a, b,
    output lc3b_word f
);

always_comb
begin
    case (aluop)
        alu_add: f = a + b;
        alu_and: f = a & b;
        alu_not: f = ~a;
        alu_pass: f = a;
        alu_sll: f = a << b;
        alu_srl: f = a >> b;
        alu_sra: f = $signed(a) >>> b;
		  alu_div: f = 0;
		  alu_mult: f = 0;
		  alu_sub: f = a + ((~b) + 16'b0000000000000001 );
		  alu_xor: f = a^b;
		  alu_or: f = a|b;
        default: $display("Unknown aluop");
    endcase
end

endmodule : alu
