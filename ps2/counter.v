module counter(
					input  clk,
					input  clr,
					input  rst,
					output [5:0]cout);
	
	reg [5:0]Q;
	
	always @ (negedge clk or posedge rst or posedge clr)
		
		 if (clr | rst)
				Q <= 1'b0;
		else
				Q <= Q + 1'b1;
				
	assign cout = Q;
	
endmodule