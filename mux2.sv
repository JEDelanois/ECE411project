module mux2 #(parameter width = 16)
(
	/* port declaration */
	input sel,
	input [width-1:0] a, b,
	output logic [width-1:0] f
);

/* multiplexor definition */
always_comb
begin
	if (sel == 0)
		f = a;
	else
		f = b;
end

endmodule : mux2