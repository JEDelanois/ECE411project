module adder 
(
	/* port declarations */
	input [15:0] a, b,
	output logic [15:0] sum
);

/*
always_comb
	begin
		sum = a + b;
	end
*/


logic carry_bit_1, carry_bit_2, carry_bit_3;

cla_add_4 CarryLookAhead1
(
	.a(a[7:0]),
	.b(b[7:0]),
	.carry_in(1'b0),
	.sum(sum[7:0]),
	.carry_out(carry_bit_1)
);

cla_add_4 CarryLookAhead2 
(
	.a(a[15:8]),
	.b(b[15:8]),
	.carry_in(carry_bit_1),
	.sum(sum[15:8]),
	.carry_out(carry_bit_2)
);

endmodule : adder