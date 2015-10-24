import lc3b_types::*;

module cpu
(
	input clk
);


cpu_datapath LC3b_Datapath
(
		.clk(clk)
);

cpu_control LC3b_Control
(
		.clk(clk)
);


endmodule : cpu