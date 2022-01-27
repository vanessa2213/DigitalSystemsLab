module flipflop(
						input 	clk,
						input 	rst,
						input 	D,
						output 	reg Q);
always @ (posedge clk)
	if (rst)
	Q<=0;
	else
	Q<= D;
endmodule
