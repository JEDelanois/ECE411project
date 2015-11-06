import lc3b_types ::*;

module write_mesh
(
	input [127:0] data_out,
	input [15:0] memory_write,
	input [3:0] offset,
	input [1:0] byte_enable,
	output logic [127:0] meshed_data_in
);

always_comb
	begin
		if(byte_enable == 2'b11)
			begin
				case(offset[3:1])
					3'b000: begin
						meshed_data_in = {data_out[127:16], memory_write};
					end
					3'b001: begin
						meshed_data_in = {data_out[127:32], memory_write, data_out[15:0]};
					end
					3'b010: begin
						meshed_data_in = {data_out[127:48], memory_write, data_out[31:0]};
					end
					3'b011: begin
						meshed_data_in = {data_out[127:64], memory_write, data_out[47:0]};
					end
					3'b100: begin
						meshed_data_in = {data_out[127:80], memory_write, data_out[63:0]};
					end
					3'b101: begin
						meshed_data_in = {data_out[127:96], memory_write, data_out[79:0]};
					end
					3'b110: begin
						meshed_data_in = {data_out[127:112], memory_write, data_out[95:0]};
					end
					3'b111: begin
						meshed_data_in = {memory_write, data_out[111:0]};
					end
				endcase
			end
		else
			begin
				case(offset)
					4'b0000: begin
						meshed_data_in = {data_out[127:8], memory_write[7:0]};
					end
					4'b0001: begin
						meshed_data_in = {data_out[127:16], memory_write[7:0], data_out[7:0]};
					end
					4'b0010: begin
						meshed_data_in = {data_out[127:24], memory_write[7:0], data_out[15:0]};
					end
					4'b0011: begin
						meshed_data_in = {data_out[127:32], memory_write[7:0], data_out[23:0]};
					end
					4'b0100: begin
						meshed_data_in = {data_out[127:40], memory_write[7:0], data_out[31:0]};
					end
					4'b0101: begin
						meshed_data_in = {data_out[127:48], memory_write[7:0], data_out[39:0]};
					end
					4'b0110: begin
						meshed_data_in = {data_out[127:56], memory_write[7:0], data_out[47:0]};
					end
					4'b0111: begin
						meshed_data_in = {data_out[127:64], memory_write[7:0], data_out[55:0]};
					end
					4'b1000: begin
						meshed_data_in = {data_out[127:72], memory_write[7:0], data_out[63:0]};
					end
					4'b1001: begin
						meshed_data_in = {data_out[127:80], memory_write[7:0], data_out[71:0]};
					end
					4'b1010: begin
						meshed_data_in = {data_out[127:88], memory_write[7:0], data_out[79:0]};
					end
					4'b1011: begin
						meshed_data_in = {data_out[127:96], memory_write[7:0], data_out[87:0]};
					end
					4'b1100: begin
						meshed_data_in = {data_out[127:104], memory_write[7:0], data_out[95:0]};
					end
					4'b1101: begin
						meshed_data_in = {data_out[127:112], memory_write[7:0], data_out[103:0]};
					end
					4'b1110: begin
						meshed_data_in = {data_out[127:120], memory_write[7:0], data_out[111:96]};
					end
					4'b1111: begin
						meshed_data_in = {memory_write[7:0], data_out[119:0]};
					end
				endcase
			end
	end

endmodule : write_mesh