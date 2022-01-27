module register(
						input clk,
						input rst,
						input [7:0]D,
						output reg[7:0]Q);
	always  @ (posedge clk)
		if (rst)
			Q <= 0;
		else
			Q <=D;
endmodule