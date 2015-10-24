module adder #(parameter width = 16)
(
	/* port declarations */
	input [width-1:0] a, b,
	output logic [width-1:0] sum
);

/* adder definition */
always_comb
begin
	sum = a + b;
end

endmodule : adder