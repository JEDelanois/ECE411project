module Cache1_cont 
(
    input resp_a,
    output logic mem_read1, stall_fetch, inject_NOP
);

//assume that every clock cycle we want to read
assign mem_read1 = 1'b1;


always_comb
begin

if(resp_a == 1'b0) // if there is a cache miss
begin 
	stall_fetch = 1'b1; // stall pipeline
	inject_NOP = 1'b1; // and inject a nop
end

else// there is a cache hit so allow everytihg to be normal
begin 
	stall_fetch = 1'b0;
	inject_NOP = 1'b0;
end


end
endmodule : Cache1_cont