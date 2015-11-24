module NeedFlipSign
(
input flip,
input [15:0] in,

output logic [15:0] out
);

always_comb
begin

	if(flip == 1'b1) // if it says to flip then  output the flipped sign
		out = ((~in) + 16'b0000000000000001 );
	else 
		out = in; // else dont flip the sign


end
endmodule : NeedFlipSign