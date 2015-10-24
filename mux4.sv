module mux4 #(parameter width = 16)
(
	/* port declaration */
	input [1:0] sel,
	input [width-1:0] a, b, c, d,
	output logic [width-1:0] f
);

/* multiplexor definition */
always_comb
begin
	case (sel)
		2'd0:	f = a;
		2'd1: f = b;
		2'd2: f = c;
		2'd3: f = d;
		default: f = a;
	endcase
end

endmodule : mux4