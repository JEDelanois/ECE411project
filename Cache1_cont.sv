module Cache1_cont 
(
    input resp_a,
    output logic mem_read1, stall_fetch
);

//assume that every clock cycle we want to read
assign mem_read1 = 1'b1;


always_comb
begin

if(resp_a == 1'b1)
begin 
	stall_fetch = 1'b0;
end

else// there is a cache miss so stall the fetch stage
begin 
	stall_fetch = 1'b1;
end


end
endmodule : Cache1_cont