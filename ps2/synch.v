module synch(
				  input       ps2clk,
				  input       fpgclk,
				  input       rst,
				  output      midout,
				  output [5:0]count );
	wire [5:0]cout;
	wire comp;
	reg Q1;
	reg Q2;
	
	counter c1(.clk(ps2clk),.clr(Q2),.rst(rst),.cout(cout));
	assign comp = (cout == 6'h20)? 1'b1 : 1'b0;
	assign count = cout;
	always @ (posedge fpgclk)
		begin
		if (fpgclk)
			Q1 <= comp;
		else 
			Q1<=Q1;
		end
	assign midout = Q1;
	
	always @ (posedge fpgclk)
		begin
		if (fpgclk)
			Q2 <= Q1;
		else
			Q2 <= Q2;
		end
endmodule