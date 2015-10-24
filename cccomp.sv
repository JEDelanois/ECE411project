module cccomp #(parameter width = 3)
(
	/* port declarations */
	input [width-1:0] testcc, cc,
	output logic branch_enable
);

/* cc comparator definitions */
always_comb
begin
	/* check which cc to test and if that one is set */
	if ((testcc & cc) != 3'b0)
		branch_enable = 1'b1;
	else
		branch_enable = 1'b0;
end

endmodule : cccomp