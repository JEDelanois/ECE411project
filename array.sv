import lc3b_types ::*;

module array #(parameter width = 1)
(
	input clk,
	input write,
	input [2:0] index,
	input [width-1:0] in,
	output logic [width-1:0] out
);

logic [width-1:0] data [7:0]/* synthesis ramstyle = "logic"*/;

initial
	begin
		for (int i = 0; i < $size(data); i++)
		begin
			data[i] = 1'b0;
		end
	end

always_ff @(posedge clk)
	begin
		if(write == 1)
			begin
				data[index] = in;
			end
	end

assign out = data[index];

endmodule : array