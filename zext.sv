import lc3b_types::*;

module zext
(
	input lc3b_byte in,
	output lc3b_word out
);

assign out = {8'b0 ,in};

endmodule : zext