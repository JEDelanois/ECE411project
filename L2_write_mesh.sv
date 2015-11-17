module L2_write_mesh
(
	input [1023:0] data_out,
	input [127:0] memory_write,
	input [2:0] offset,
	output logic [1023:0] meshed_data_in
);

always_comb
	begin
			case(offset)
					3'b000: begin
						meshed_data_in = {data_out[1023:128], memory_write[127:0]};
					end
					3'b001: begin
						meshed_data_in = {data_out[1023:256], memory_write[127:0], data_out[127:0]};
					end
					3'b010: begin
						meshed_data_in = {data_out[1023:384], memory_write[127:0], data_out[255:0]};
					end
					3'b011: begin
						meshed_data_in = {data_out[1023:512], memory_write[127:0], data_out[383:0]};
					end
					3'b100: begin
						meshed_data_in = {data_out[1023:640], memory_write[127:0], data_out[511:0]};
					end
					3'b101: begin
						meshed_data_in = {data_out[1023:768], memory_write[127:0], data_out[639:0]};
					end
					3'b110: begin
						meshed_data_in = {data_out[1023:896], memory_write[127:0], data_out[767:0]};
					end
					3'b111: begin
						meshed_data_in = {memory_write[127:0], data_out[895:0]};
					end
				endcase
	end

endmodule : L2_write_mesh