module cla_add_4
(
	input  [7:0] a,
	input  [7:0] b,
	input        carry_in,    //Carry in
	output [7:0] sum,    //Sum
	output       carry_out  //Carry
);

logic  [6:0] carr, dummy; // 3:1 to align numbers with wikipedia article
logic [7:0] p;
logic [7:0] g;

always_comb
	begin
		g = a & b;
		p = a | b;
		carr[0] = (g[0] + (p[0] & carry_in));
		carr[1] = (g[1] + (p[1] & (g[0] + (p[0] & carry_in))));
		carr[2] = (g[2] + (p[2] & (g[1] + (p[1] & (g[0] + (p[0] & carry_in))))));
		carr[3] = (g[3] + (p[3] & (g[2] + (p[2] & (g[1] + (p[1] & (g[0] + (p[0] & carry_in))))))));
		carr[4] = (g[4] + (p[4] & g[3] + (p[3] & (g[2] + (p[2] & (g[1] + (p[1] & (g[0] + (p[0] & carry_in)))))))));
		carr[5] = (g[5] + (p[5] & (g[4] + (p[4] & g[3] + (p[3] & (g[2] + (p[2] & (g[1] + (p[1] & (g[0] + (p[0] & carry_in)))))))))));
		carr[6] = (g[6] + (p[6] & (g[5] + (p[5] & (g[4] + (p[4] & g[3] + (p[3] & (g[2] + (p[2] & (g[1] + (p[1] & (g[0] + (p[0] & carry_in)))))))))))));
		carry_out = (g[7] + (p[7] & (g[6] + (p[6] & (g[5] + (p[5] & (g[4] + (p[4] & g[3] + (p[3] & (g[2] + (p[2] & (g[1] + (p[1] & (g[0] + (p[0] & carry_in)))))))))))))));
	end

assign {dummy, sum[0]} = a[0] + b[0] + carry_in;
assign {dummy, sum[1]} = a[1] + b[1] + carr[0];
assign {dummy, sum[2]} = a[2] + b[2] + carr[1];
assign {dummy, sum[3]} = a[3] + b[3] + carr[2];
assign {dummy, sum[4]} = a[4] + b[4] + carr[3];
assign {dummy, sum[5]} = a[5] + b[5] + carr[4];
assign {dummy, sum[6]} = a[6] + b[6] + carr[5];
assign {dummy, sum[7]} = a[7] + b[7] + carr[6];


endmodule : cla_add_4