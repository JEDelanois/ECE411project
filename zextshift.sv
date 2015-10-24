import lc3b_types::*;

module zextshift
(
	input lc3b_byte in,
	output lc3b_word out
);

assign out = {7'b0 ,in, 1'b0};

endmodule : zextshift